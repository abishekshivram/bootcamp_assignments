
module branch(
    input logic [31:0] pc,
    input logic [31:0] imm,
    input logic [31:0] rs1_val,
    input logic [31:0] rs2_val,
    input logic [2:0] branch_control,
    output logic pc_update_control,
    output logic [31:0] pc_update_val
);

always @ (*) begin
    pc_update_control = 1'b0;
    pc_update_val = 32'h0;
    case (branch_control)
        `BEQ: begin
            if (rs1_val == rs2_val) begin
                pc_update_control = 1'b1;
                pc_update_val = pc + imm;
            end
        end
        `BNE: begin
            if (rs1_val != rs2_val) begin
                pc_update_control = 1'b1;
                pc_update_val = pc + imm;
            end
        end
        `BLT: begin
            if ($signed(rs1_val) < $signed(rs2_val)) begin
                pc_update_control = 1'b1;
                pc_update_val = pc + imm;
            end
        end
        `BGE: begin
            if ($signed(rs1_val) >= $signed(rs2_val)) begin
                pc_update_control = 1'b1;
                pc_update_val = pc + imm;
            end
        end
        `BLTU: begin
            if (rs1_val < rs2_val) begin
                pc_update_control = 1'b1;
                pc_update_val = pc + imm;
            end
        end
        `BGEU: begin
            if (rs1_val >= rs2_val) begin
                pc_update_control = 1'b1;
                pc_update_val = pc + imm;
            end
        end
    endcase
end

endmodule
