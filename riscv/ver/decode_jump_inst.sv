
module decode_jump_inst(
    input logic [31:0] instruction_code,
    output logic [4:0] rd,
    output logic [20:0] imm,
    output logic [1:0] jump_control
);

always @ (instruction_code) begin
    rd = instruction_code[11:7];
    if (instruction_code[6:0] == `OP_JAL) begin
        imm = {instruction_code[31], instruction_code[19:12], instruction_code[20], instruction_code[30:21], 1'b0};
        jump_control = `JAL;
    end
    else begin
        imm = instruction_code[31:20];
        jump_control = `JALR;
    end
end

endmodule
