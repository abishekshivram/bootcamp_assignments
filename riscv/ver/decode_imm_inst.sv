
module decode_imm_inst(
    input logic [31:7] instruction_code,
    output logic [4:0] rs1,
    output logic [4:0] rd,
    output logic [11:0] imm,
    output logic [4:0] alu_control
);

logic [2:0] func3;

// always_comb begin
always@(*) begin
    rd = instruction_code[11:7];
    func3 = instruction_code[14:12];
    rs1 = instruction_code[19:15];
    imm = instruction_code[31:20];
    case (func3)
        3'd1: alu_control = `SLLI;
        3'd2: alu_control = `SLTI;
        3'd3: alu_control = `SLTIU;
        3'd4: alu_control = `XORI;
        3'd5: begin
            if (imm[11:5] == 7'h00)
                alu_control = `SRLI;
            else
                alu_control = `SRAI;
        end
        3'd6: alu_control = `ORI;
        3'd7: alu_control = `ANDI;
        default: alu_control = `ADDI;
    endcase
end

endmodule
