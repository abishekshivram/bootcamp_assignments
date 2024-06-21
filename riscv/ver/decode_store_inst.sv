
module decode_store_inst(
    input logic [31:7] instruction_code,
    output logic [4:0] rs1,
    output logic [4:0] rs2,
    output logic [11:0] imm,
    output logic [2:0] store_control
);

logic [2:0] func3;

always @ (instruction_code) begin
    func3 = instruction_code[14:12];
    rs1 = instruction_code[19:15];
    rs2 = instruction_code[24:20];
    imm = {instruction_code[31:25], instruction_code[11:7]};
    case (func3)
        3'd1: store_control = `SH;
        3'd2: store_control = `SW;
        default: store_control = `SB;
    endcase
end


endmodule
