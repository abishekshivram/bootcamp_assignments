`timescale 1ns/100ps

module tb_counter;

   localparam COUNT_WD = 8;
   logic [COUNT_WD-1:0] o_count;
   logic                i_clk, i_rstb, i_tm_reset, i_tm_direction;


   counter #(.COUNT_WD (COUNT_WD)) dut
     (
      // Outputs
      .o_count                          (o_count),
      // Inputs
      .i_clk                            (i_clk),
      .i_rstb                           (i_rstb),
      .i_tm_reset                       (i_tm_reset),
      .i_tm_direction                   (i_tm_direction)
      );

   always
     #0.5 i_clk = ~i_clk;
   
   initial
     begin
        $dumpfile("./results/counter_ivlog.vcd");
        $dumpvars(0, tb_counter);
        i_clk          = 1'b0;
        i_rstb         = 1'b1;
        #1;
        i_rstb         = 1'b0;
        #1;
        i_rstb         = 1'b1;
        //
        i_tm_reset     = 1'b0;
        i_tm_direction = 1'b0;
        #1000;
        i_tm_reset     = 1'b1;
        #1;
        i_tm_reset     = 1'b0;
        i_tm_direction = 1'b1;
        #1000;
        $finish;
     end

endmodule

// Local Variables:
// verilog-library-directories : ("../ver/")
// End:
