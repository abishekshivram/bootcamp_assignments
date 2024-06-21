
module load(
    input logic i_clk,
    input logic i_rst,
    input logic [31:0] rs1_val,
    input logic [31:0] imm,
    input logic [31:0] mem_data,
    input logic [4:0] rd_in,
    input logic [2:0] load_control,
    output logic stall_pc,
    output logic stall_other_exec,
    output logic rd_write_control,
    output logic [4:0] rd_out,
    output logic [31:0] rd_write_val,
    output logic mem_rw_mode,
    output logic [9:0] mem_addr
);

logic [1:0] state, next_state;
logic [4:0] rd_reg;
logic [31:0] mem_addr_reg;
logic [31:0] final_mem_val;
logic [2:0] load_control_reg;
logic [1:0] mem_addr_lsbs;

always @ (*) begin
    case (state)
        `LOAD_RESET: begin
            if (load_control != `LD_NOP) begin
                next_state = `READ_MEM;
                stall_pc = 1'b1;
                mem_addr_reg = rs1_val + imm;
            end
            else begin
                next_state = `LOAD_RESET;
                stall_pc = 1'b0;
                mem_addr_reg = 32'h0;
            end
            stall_other_exec = 1'b0;
            rd_write_control = 1'b0;
            rd_write_val = 32'h0;
        end
        `READ_MEM: begin
            next_state = `LOAD_RESET;
            stall_pc = 1'b0;
            mem_addr_reg = 32'h0;
            stall_other_exec = 1'b1;
            rd_write_control = 1'b1;
            rd_write_val = final_mem_val;
        end
    endcase
end

always @ (posedge i_clk, posedge i_rst) begin
    if (i_rst)
        state <= `LOAD_RESET;
    else
        state <= next_state;
end

always @ (posedge i_clk) begin
    if (next_state == `READ_MEM) begin
        rd_reg <= rd_in;
        load_control_reg <= load_control;
        mem_addr_lsbs <= mem_addr_reg[1:0];
    end
    else begin
        rd_reg <= 4'd0;
        load_control_reg <= `LD_NOP;
        mem_addr_lsbs <= 2'h0;
    end
end

always @ (*) begin
    final_mem_val = 32'h0;
    case (load_control_reg)
        `LB: begin
            if (mem_addr_lsbs == 2'h0)
                final_mem_val = {{24{mem_data[7]}}, mem_data[7:0]};
            else if (mem_addr_lsbs == 2'h1)
                final_mem_val = {{24{mem_data[15]}}, mem_data[15:8]};
            else if (mem_addr_lsbs == 2'h2)
                final_mem_val = {{24{mem_data[23]}}, mem_data[23:16]};
            else
                final_mem_val = {{24{mem_data[31]}}, mem_data[31:24]};
        end
        `LH: begin
            if (mem_addr_lsbs == 2'h0)
                final_mem_val = {{16{mem_data[15]}}, mem_data[15:0]};
            else
                final_mem_val = {{16{mem_data[31]}}, mem_data[31:16]};
        end
        `LW: final_mem_val = mem_data;
        `LBU: begin
            if (mem_addr_lsbs == 2'h0)
                final_mem_val = {24'h0, mem_data[7:0]};
            else if (mem_addr_lsbs == 2'h1)
                final_mem_val = {24'h0, mem_data[15:8]};
            else if (mem_addr_lsbs == 2'h2)
                final_mem_val = {24'h0, mem_data[23:16]};
            else
                final_mem_val = {24'h0, mem_data[31:24]};
        end
        `LHU: begin
            if (mem_addr_lsbs == 2'h0)
                final_mem_val = {16'h0, mem_data[15:0]};
            else
                final_mem_val = {16'h0, mem_data[31:16]};
        end
    endcase
end



assign mem_rw_mode = 1'b0;
assign mem_addr = mem_addr_reg[11:2];

endmodule
