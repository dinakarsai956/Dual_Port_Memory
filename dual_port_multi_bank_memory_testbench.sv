module dual_port_multi_bank_memory_testbench;
  parameter WIDTH      = 8;
  parameter ADDR_TOTAL = 5;     
  parameter NUM_BANK   = 4;

  
  logic i_clk_a, i_clk_b;
  logic i_en_a, i_en_b;
  logic i_we_a, i_we_b;
  logic [WIDTH-1:0]        i_din_a, i_din_b;
  logic [ADDR_TOTAL-1:0]   i_addr_a, i_addr_b;
  logic [WIDTH-1:0]        o_dout_a, o_dout_b;

  
  dual_port_multi_bank_memory #(
    .WIDTH(WIDTH),
    .ADDR_TOTAL(ADDR_TOTAL),
    .NUM_BANK(NUM_BANK)
  ) dut (
    .i_clk_a(i_clk_a),
    .i_clk_b(i_clk_b),
    .i_en_a(i_en_a),
    .i_en_b(i_en_b),
    .i_we_a(i_we_a),
    .i_we_b(i_we_b),
    .i_din_a(i_din_a),
    .i_din_b(i_din_b),
    .i_addr_a(i_addr_a),
    .i_addr_b(i_addr_b),
    .o_dout_a(o_dout_a),
    .o_dout_b(o_dout_b)
  );

 
  initial begin 
    i_clk_a = 0;
    i_clk_b = 0;
  end
  always #10 i_clk_a = ~i_clk_a;
  always #10 i_clk_b = ~i_clk_b;
/*
  localparam N_WRITES = 8;
  logic [ADDR_TOTAL-1:0] written_addr_a [N_WRITES-1:0];
  logic [WIDTH-1:0]      written_data_a [N_WRITES-1:0];

  logic [ADDR_TOTAL-1:0] written_addr_b [N_WRITES-1:0];
  logic [WIDTH-1:0]      written_data_b [N_WRITES-1:0];
*/
  initial begin
    i_en_a = 0;
    i_we_a = 0; 
    i_din_a = '0; 
    i_addr_a = '0; 
    @(posedge i_clk_a);
    i_en_a = 1;
    i_we_a = 1; 
    i_din_a = 8'd12;; 
    i_addr_a = 10'd312;
    @(posedge i_clk_a);
    i_din_a = 8'd22;
    i_addr_a = 10'd202;
    @(posedge i_clk_a);
    i_din_a = 8'd98;
    i_addr_a = 10'd010;
    @(posedge i_clk_a);
    i_din_a = 8'd23;
    i_addr_a = 10'd101;
    @(posedge i_clk_a);
    i_we_a = 0;
    i_addr_a = 10'd312;
    @(posedge i_clk_a);
    i_addr_a = 10'd202;
    @(posedge i_clk_a);
    i_addr_a = 10'd101;
    @(posedge i_clk_a);
    i_addr_a = 10'd010;
    @(posedge i_clk_a);
  end
  initial begin
     i_en_b = 0;
     i_we_b = 0;
     i_din_b = '0;
     i_addr_b = '0;
     @(posedge i_clk_b);
      i_en_b = 1;
      i_we_b = 1;
      i_din_b = 8'd11;
      i_addr_b = 10'd301;
      @(posedge i_clk_b);
      i_din_b = 8'd13;
      i_addr_b = 10'd113;
      @(posedge i_clk_b);
      i_din_b = 8'd14;
      i_addr_b = 10'd001;
      @(posedge i_clk_b);
      i_din_b = 8'd12;
      i_addr_b = 10'd215;
      @(posedge i_clk_b);
      i_we_b = 0;
      i_addr_b = 10'd312;
      @(posedge i_clk_b);
      i_addr_b =  10'd113;
      @(posedge i_clk_b);
      i_addr_b =  10'd001;
      @(posedge i_clk_b);
      i_addr_b = 10'd215;
      @(posedge i_clk_b);
  end
 
/*
  initial begin
    @(negedge i_clk_a);
    i_en_a = 1;

    for (int k = 0; k < N_WRITES; k++) begin
      @(negedge i_clk_a);
      i_we_a   = 1;
      written_addr_a[k] = $urandom_range(900, 1023);
      written_data_a[k] = $urandom_range(0, 2**WIDTH-1);
      i_addr_a = written_addr_a[k];
      i_din_a  = written_data_a[k];
      $display("[%0t] PRT A WRITE  addr=%0d data=0x%0h", $time, i_addr_a, i_din_a);
    end

    @(negedge i_clk_a);
    i_we_a = 0;
    @(posedge i_clk_a);

    for (int k = 0; k < N_WRITES; k++) begin
      @(negedge i_clk_a);
      i_we_a = 0;
      i_addr_a = written_addr_a[k];
            @(posedge i_clk_a);
      $display("[%0t] PRT A READ   addr=%0d exp=0x%0h got=0x%0h",
               $time, i_addr_a, written_data_a[k], o_dout_a);
    end

    
    i_en_a = 0;
    i_we_a = 0;
  end

  
  initial begin
    @(negedge i_clk_b);
    i_en_b = 1;

   
    for (int k = 0; k < N_WRITES; k++) begin
      @(negedge i_clk_b);
      i_we_b = 1;
      written_addr_b[k] = $urandom_range(700, 899);
      written_data_b[k] = $urandom_range(0, 2**WIDTH-1);
      i_addr_b = written_addr_b[k];
      i_din_b  = written_data_b[k];
      $display("[%0t] PRT B WRITE  addr=%0d data=0x%0h", $time, i_addr_b, i_din_b);
    end

    @(negedge i_clk_b);
    i_we_b = 0;
    @(posedge i_clk_b);


    for (int k = 0; k < N_WRITES; k++) begin
      @(negedge i_clk_b);
      i_we_b = 0;
      i_addr_b = written_addr_b[k];
      @(posedge i_clk_b);
      $display("[%0t] PRT B READ   addr=%0d exp=0x%0h got=0x%0h",
               $time, i_addr_b, written_data_b[k], o_dout_b);
    end

    i_en_b = 0;
    i_we_b = 0;
  end*/

  initial begin
    #500;
    $display("TESTBENCH DONE");
    $finish;
  end


endmodule
