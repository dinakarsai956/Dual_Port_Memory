module dual_port_memory_bank_testbench;
  parameter WIDTH = 8;
  parameter ADDR = 10;
  parameter DEPTH = 2 ** ADDR;
  logic i_clk_a, i_clk_b;
  logic i_en_a, i_en_b;
  logic i_we_a, i_we_b;
  logic [WIDTH-1:0] i_din_a, i_din_b;
  logic [ADDR-1:0] i_addr_a, i_addr_b;
  logic [WIDTH-1:0] o_dout_a, o_dout_b;
  dual_port_memory_bank #(.WIDTH(WIDTH), .ADDR(ADDR)) dut(.i_clk_a(i_clk_a), .i_clk_b(i_clk_b), .i_en_a(i_en_b), .i_en_b(i_en_b), .i_we_a(i_we_a), .i_we_b(i_we_b),.i_din_a(i_din_a), .i_din_b(i_din_b), .i_addr_a(i_addr_a), .i_addr_b(i_addr_b), .o_dout_a(o_dout_a), .o_dout_b(o_dout_b));
  initial begin
    i_clk_a = 0;
    i_clk_b = 0;
  end
   always #5 i_clk_a = ~i_clk_a;
   always #10 i_clk_b = ~i_clk_b;

   initial begin
     i_en_a = 0;
     i_we_a = 0;
     i_din_a = '0;
     i_addr_a = '0;
     @(negedge i_clk_a);
    
     for(int i = 0; i < 10; i++)begin
      i_en_a = 1;
      i_we_a = 1;
      i_addr_a = $urandom_range(0,10);
      i_din_a = $urandom_range(45,65);
      @(negedge i_clk_a);
      $display("i_addr_a = %d, /n i_din_a = %d, /t time = %t", i_addr_a, i_din_a, $time);
     end
     i_we_a = 0;
     @(negedge i_clk_a);
   end

    initial begin
      i_en_b = 0;
      i_we_b = 0;
      @(negedge i_clk_b);
      i_en_b = 1;
      i_we_b = 1;
      for(int i = 0; i < 10; i++)begin
        i_addr_b = $urandom_range(10, 20);
	i_din_b  = $urandom_range(0,29);
	@(negedge i_clk_b);
	$display("i_addr_b = %d , /n i_din_b = %d, /t time = %t", i_addr_b, i_din_b, $time);
      end
      i_we_b = 0;
      @(negedge i_clk_b);
          end
     initial begin
       #2000 $finish;
     end
endmodule
