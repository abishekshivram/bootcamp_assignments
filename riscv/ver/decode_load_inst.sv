
module decode_load_inst(
    input logic [31:7] instruction_code,
    output logic [4:0] rs1,
    output logic [4:0] rd,
    output logic [11:0] imm,
    output logic [2:0] load_control
);

logic [2:0] func3;

always_comb begin
    rd = instruction_code[11:7];
    func3 = instruction_code[14:12];
    rs1 = instruction_code[19:15];
    imm = instruction_code[31:20];
    case (func3)
        3'd1: load_control = `LH;
        3'd2: load_control = `LW;
        3'd4: load_control = `LBU;
        3'd5: load_control = `LHU;
        default: load_control = `LB;
    endcase 
end

endmodule
