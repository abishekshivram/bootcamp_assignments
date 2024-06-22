
module store(
    input logic i_clk,
    input logic i_rst,
    input logic [31:0] rs1_val,
    input logic [31:0] rs2_val,
    input logic [31:0] imm,
    input logic [2:0] store_control,
    output logic stall_pc,
    output logic stall_other_exec,
    output logic mem_rw_mode,
    output logic [9:0] mem_addr,
    output logic [31:0] mem_write_data,
    output logic [3:0] mem_byte_en
);

// logic [1:0] state, next_state;
logic state;
logic next_state;
logic [31:0] mem_addr_reg;

always_ff @(posedge i_clk or posedge i_rst) begin
    if(i_rst) begin 
        state <= 'd0;
    end 
    else begin
        state <= next_state;
    end
end


always @ (*) begin
    case (state)
        `STORE_RESET: begin
            if (store_control != `STR_NOP) begin
                next_state = `WRITE_MEM;
                stall_pc = 1'b1;
                mem_rw_mode = 1'b1;
                mem_addr_reg = rs1_val + imm;
                mem_write_data = rs2_val;
            end
            else begin
                next_state = `STORE_RESET;
                stall_pc = 1'b0;
                mem_rw_mode = 1'b0;
                mem_addr_reg = 32'h0;
                mem_write_data = 32'h0;
            end
            stall_other_exec = 1'b0;
        end
        `WRITE_MEM: begin
            next_state = `STORE_RESET;
            stall_pc = 1'b0;
            mem_rw_mode = 1'b0;
            mem_addr_reg = 32'h0;
            mem_write_data = 32'h0;
            stall_other_exec = 1'b1;
        end
    endcase
end

always @ (*) begin
    mem_write_data = 32'h0;
    mem_byte_en = 4'h0;
    case (store_control)
        `SB: begin
            if (mem_addr_reg[1:0] == 2'd0)
                mem_write_data = {24'd0, rs2_val[7:0]};
            else if (mem_addr_reg[1:0] == 2'd1)
                mem_write_data = {24'd0, rs2_val[15:8]};
            else if (mem_addr_reg[1:0] == 2'd2)
                mem_write_data = {24'd0, rs2_val[23:16]};
            else
                mem_write_data = {24'd0, rs2_val[31:24]};
            mem_byte_en = (1 << mem_addr_reg[1:0]);
        end
        `SH: begin
            if (mem_addr_reg[1:0] == 2'd0)
                mem_write_data = {16'd0, rs2_val[15:0]};
            else
                mem_write_data = {16'd0, rs2_val[31:16]};
            mem_byte_en = (mem_addr_reg == 2'h0) ? 4'b0011 : 4'b1100;
        end
        `SW: begin
            mem_write_data = rs2_val;
            mem_byte_en = 4'b1111;
        end
    endcase
end

assign mem_addr = mem_addr_reg[11:2];

endmodule
