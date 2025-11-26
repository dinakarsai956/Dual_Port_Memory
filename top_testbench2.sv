`include"dual_port_memory_top_module2.sv"
module top_testbench;
   parameter WIDTH = 8;
    parameter CODE_WIDTH = 12;
    parameter ADDR_WIDTH = 5;
    parameter WRITE_LATENCY_A = 0;
    parameter READ_LATENCY_A = 0;
    parameter WRITE_LATENCY_B = 0;
    parameter READ_LATENCY_B = 0;
    parameter NUM_BANK = 4;
    parameter DEPTH = 2 ** ADDR_WIDTH;
    logic i_clk_a, i_clk_b;
    logic i_we_a , i_we_b;
    logic i_en_a, i_en_b;
    logic [WIDTH-1:0] i_din_a, i_din_b;
    logic [WIDTH-1:0] o_dout_a1, o_dout_b1;
    logic [ADDR_WIDTH-1:0] i_addr_a, i_addr_b;
  dual_port_memory_top_module#(.WIDTH(WIDTH), .CODE_WIDTH(CODE_WIDTH), .ADDR_WIDTH(ADDR_WIDTH), .WRITE_LATENCY_A(WRITE_LATENCY_A), .READ_LATENCY_A(READ_LATENCY_A), .WRITE_LATENCY_B(WRITE_LATENCY_B), .READ_LATENCY_B(READ_LATENCY_B), .NUM_BANK(NUM_BANK), .DEPTH(DEPTH)) dut(.i_clk_a(i_clk_a), .i_clk_b(i_clk_b), .i_en_a(i_en_a), .i_en_b(i_en_b),.i_we_a(i_we_a), .i_we_b(i_we_b), .i_din_a(i_din_a), .i_din_b(i_din_b), .i_addr_a(i_addr_a), .i_addr_b(i_addr_b), .o_dout_a1(o_dout_a1), .o_dout_b1(o_dout_b1));
  initial begin
    i_clk_a = 0;
    i_clk_b = 0;
  end
  always #10 i_clk_a = ~i_clk_a;
  always #10 i_clk_b = ~i_clk_b;
  initial begin
    i_en_a = 1;
    i_we_a = 1;
    i_din_a = 8'hAA;
    i_addr_a = 5'd0;
    @(posedge i_clk_a);
    i_din_a = 8'hBB;
    i_addr_a = 5'd1;
    @(posedge i_clk_a);
    i_we_a = 0;
    i_addr_a = 5'd0;
    @(posedge i_clk_a);
    i_addr_a = 5'd1;
    @(posedge i_clk_a);
  end
  initial begin
    i_en_b = 1;
    i_we_b = 1;
    i_din_b = 8'hCC;
    i_addr_b = 5'd2;
    @(posedge i_clk_b);
    i_din_b = 8'hDD;
    i_addr_b = 5'd3;
    @(posedge i_clk_b);
    i_we_b = 0;
    i_addr_b = 5'd2;
    @(posedge i_clk_b);
    i_addr_b = 5'd3;
  end
   initial begin
   #1000  $finish;
  end
 endmodule
