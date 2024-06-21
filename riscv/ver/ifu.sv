
module ifu(
    input logic i_clk,
    input logic i_rst,
    input logic stall_pc,
    input logic pc_update_control,
    input logic [31:0] pc_update_val,
    output logic [31:0] pc
);

always @ (posedge i_clk, posedge i_rst) begin
    if (i_rst)
        pc <= 32'h0;
    else if (!stall_pc) begin
        if (pc_update_control)
            pc <= pc_update_val;
        else
            pc <= pc + 32'h4;
    end
end

endmodule
