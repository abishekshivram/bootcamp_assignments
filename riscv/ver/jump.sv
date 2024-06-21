
module jump(
    input logic [31:0] pc,
    input logic [31:0] imm,
    input logic [31:0] rs1_val,
    input logic [1:0] jump_control,
    output logic rd_write_control,
    output logic [31:0] rd_write_val,
    output logic pc_update_control,
    output logic [31:0] pc_update_val
);

always @ (*) begin
    rd_write_control = 1'b0;
    rd_write_val = 32'h0;
    pc_update_control = 1'b0;
    pc_update_val = 32'h0;
    case (jump_control)
        `JAL: begin
            rd_write_control = 1'b1;
            rd_write_val = pc + 32'h0;
            pc_update_control = 1'b1;
            pc_update_val = pc + imm;
        end
        `JALR: begin
            rd_write_control = 1'b1;
            rd_write_val = pc + 32'h0;
            pc_update_control = 1'b1;
            pc_update_val = rs1_val + imm;
        end
    endcase
end

endmodule
