module multi_bank_memory_testbench;
 parameter WIDTH = 8;
 parameter ADDR_TOTAL = 10;
 parameter NUM_BANK = 4;
 logic i_clk_a, i_clk_b;
 logic i_en_a, i_en_b;
 logic i_we_a, i_we_b;
 logic [WIDTH-1:0] i_din_a, i_din_b;
 logic [ADDR_TOTAL-3:0] i_addr_a, i_addr_b;
 logic [ADDR_TOTAL-1:ADDR_TOTAL-2] bank_sel_a, bank_sel_b;
 logic [WIDTH-1:0] o_dout_a, o_dout_b;
 multi_bank_memory #(.WIDTH(WIDTH), .ADDR_TOTAL(ADDR_TOTAL), .NUM_BANK(NUM_BANK)) dut(.i_clk_a(i_clk_a), .i_clk_b(i_clk_b), .i_en_a(i_en_a), .i_en_b(i_en_b), .i_we_a(i_we_a), .i_we_b(i_we_b), .i_din_a(i_din_a), .i_din_b(i_din_b), .i_addr_a(i_addr_a), .i_addr_b(i_addr_b), .bank_sel_a(bank_sel_a), .bank_sel_b(bank_sel_b), .o_dout_a(o_dout_a), .o_dout_b(o_dout_b));
 
 initial begin
   i_clk_a = 0;
   i_clk_b = 0;
 end
   always #5 i_clk_a = ~i_clk_a;
   always #10 i_clk_b = ~i_clk_b;
 initial begin
   i_en_a = 0;
   i_we_a = 0;
   i_din_a = 0;
   i_addr_a = 0;
   bank_sel_a = 0;
   @(negedge i_clk_a);
   i_en_a = 1;
   i_we_a = 1;
   i_din_a = 8'h1f;
   i_addr_a = 8'hdd;
   bank_sel_a = 2'b00;
   @(negedge i_clk_a);
   i_we_a = 1;
   i_din_a = 8'h20;
   i_addr_a = 8'hfd;
   bank_sel_a = 2'b01;
   @(negedge i_clk_a);
   i_din_a = 8'hde;
   i_addr_a = 8'h23;
   bank_sel_a = 2'b10;
   @(negedge i_clk_a);
   i_we_a = 0;
   i_din_a = 8'hff;
   i_addr_a = 8'hce;
   bank_sel_a = 2'b11;
   @(negedge i_clk_a);
 end
 initial begin
   i_en_b = 0;
   i_we_b = 0;
   i_din_b = 0;
   i_addr_b = 0;
   bank_sel_b = 0;
   @(negedge i_clk_b);
   i_en_b = 1;
   i_we_b = 1;
   i_din_b = 8'heb;
   i_addr_b = 8'hfc;
   bank_sel_b = 2'b00;
   @(negedge i_clk_b);
   i_we_b = 1;
   i_din_b = 8'hcd;
   i_addr_b = 8'hcf;
   bank_sel_b = 2'b01;
   @(negedge i_clk_b);
   i_din_b = 8'hdc;
   i_addr_b = 8'hab;
   bank_sel_b = 2'b10;
   @(negedge i_clk_b);
   i_we_b = 0;
   i_din_b = 8'hbd;
   i_addr_b = 8'hcd;
   bank_sel_b = 2'b11;
   @(negedge i_clk_b);
 end
 initial #2000 $finish;
endmodule
