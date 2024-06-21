
module regfile(
    input logic i_clk,
    input logic i_rst,
    input logic [4:0] rs1,
    input logic [4:0] rs2,
    input logic [4:0] rd,
    input logic rd_write_control,
    input logic [31:0] rd_write_val,
    output logic [31:0] rs1_val,
    output logic [31:0] rs2_val
);

logic [31:0] regs [0:31];
integer i;

always @ (posedge i_clk or posedge i_rst) begin
    if (i_rst) begin
        for (i=0; i<32; i=i+1)
            regs[i] <= 32'b0;
    end
    else if (rd_write_control)
        regs[rd] <= rd_write_val;
end

assign rs1_val = regs[rs1];
assign rs2_val = regs[rs2];

endmodule
