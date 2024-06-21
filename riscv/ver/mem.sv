
module mem(
    input logic i_clk,
    input logic i_rst,
    input logic [9:0] in_mem_addr,
    input logic in_mem_rw_mode,
    input logic [31:0] in_mem_write_data,
    input logic [3:0] in_mem_byte_en,
    output logic [31:0] out_mem_data
);

logic [31:0] memory_reg [0:1023];
logic [31:0] write_data_muxed;
logic [31:0] out_mem_data_reg;
integer i;

always @ (*) begin
    write_data_muxed[7:0]   = in_mem_byte_en[0] ? in_mem_write_data[7:0]   : memory_reg[in_mem_addr][7:0];
    write_data_muxed[15:8]  = in_mem_byte_en[1] ? in_mem_write_data[15:8]  : memory_reg[in_mem_addr][15:8];
    write_data_muxed[23:16] = in_mem_byte_en[2] ? in_mem_write_data[23:16] : memory_reg[in_mem_addr][23:16];
    write_data_muxed[31:24] = in_mem_byte_en[3] ? in_mem_write_data[31:24] : memory_reg[in_mem_addr][31:24];
    out_mem_data = out_mem_data_reg;
end

always @ (posedge i_clk) begin
    if (!in_mem_rw_mode)
        memory_reg[in_mem_addr] <= write_data_muxed;
end

always @ (posedge i_clk, posedge i_rst) begin
    if (i_rst)
        out_mem_data_reg <= 32'h0;
    else if (in_mem_rw_mode)
        out_mem_data_reg <= memory_reg[in_mem_addr];
end


endmodule
