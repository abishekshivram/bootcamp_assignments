
module decode_reg_inst(
    input logic [31:7] instruction_code,
    output logic [4:0] rs1,
    output logic [4:0] rs2,
    output logic [4:0] rd,
    output logic [4:0] alu_control
);

logic [2:0] func3;
logic [6:0] func7;

always_comb begin
    rd = instruction_code[11:7];
    func3 = instruction_code[14:12];
    rs1 = instruction_code[19:15];
    rs2 = instruction_code[24:20];
    func7 = instruction_code[31:25];
    case(func3)
        3'd1: alu_control = `SLL;
        3'd2: alu_control = `SLT;
        3'd3: alu_control = `SLTU;
        3'd4: alu_control = `XOR;
        3'd5: begin
            if (func7 == 7'h00)
                alu_control = `SRL;
            else
                alu_control = `SRA;
        end
        3'd6: alu_control = `OR;
        3'd7: alu_control = `AND;
        default: begin
            if (func7 == 7'h00)
                alu_control = `ADD;
            else
                alu_control = `SUB;
        end
    endcase
end


endmodule
