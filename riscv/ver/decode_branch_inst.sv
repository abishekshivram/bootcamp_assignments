
module decode_branch_inst(
    input logic [31:7] instruction_code,
    output logic [4:0] rs1,
    output logic [4:0] rs2,
    output logic [12:1] imm,
    output logic [2:0] branch_control
);

logic [2:0] func3;

always_comb begin
    func3 = instruction_code[14:12];
    rs1 = instruction_code[19:15];
    rs2 = instruction_code[24:20];
    imm = {instruction_code[31], instruction_code[7], instruction_code[30:25], instruction_code[11:8]};
    case (func3)
        3'd1: branch_control = `BNE;
        3'd4: branch_control = `BLT;
        3'd5: branch_control = `BGE;
        3'd6: branch_control = `BLTU;
        3'd7: branch_control = `BGEU;
        default: branch_control = `BEQ;
    endcase
end

endmodule
