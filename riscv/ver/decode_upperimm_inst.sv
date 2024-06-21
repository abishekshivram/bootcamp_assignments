
module decode_upperimm_inst(
    input logic [31:0] instruction_code,
    output logic [4:0] rd,
    output logic [31:12] imm,
    output logic [4:0] alu_control
);

always_comb begin
    rd = instruction_code[11:7];
    imm = instruction_code[31:12];
    if (instruction_code[6:0] == `OP_LUI)
        alu_control = `LUI;
    else
        alu_control = `AUIPC;
end


endmodule
