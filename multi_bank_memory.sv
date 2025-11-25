///////////////////////////////////////////////////////////////////////
//  Designing of multi bank memory by using a decoder to control the 
//  memory banks using decoder to based on inputs of the decoder we are
// we are instanting externally to multi bank memory
///////////////////////////////////////////////////////////////////////
module multi_bank_memory #(parameter  ADDR_TOTAL = 10,
  parameter WIDTH = 8,
  parameter NUM_BANK = 4
  )
  ( 
    input i_clk_a, i_clk_b,
    input i_en_a, i_en_b,
    input i_we_a , i_we_b,
    input [WIDTH-1:0] i_din_a, i_din_b,
    input [ADDR_TOTAL-3:0] i_addr_a, i_addr_b,
    input [ADDR_TOTAL-1:ADDR_TOTAL-2] bank_sel_a, bank_sel_b,
    output logic [WIDTH-1:0] o_dout_a, o_dout_b);
    logic [NUM_BANK-1:0] out_a, out_b;

     decoder #(.A(2), .NUM_BANK(NUM_BANK)) dut_a(.in(bank_sel_a), .out(out_a));
     decoder #(.A(2), .NUM_BANK(NUM_BANK)) dut_b(.in(bank_sel_b), .out(out_b));
      logic [WIDTH-1:0] bank_dout_a[NUM_BANK-1:0];
      logic [WIDTH-1:0] bank_dout_b[NUM_BANK-1:0];
     genvar i;
     generate
     for( i = 0; i < NUM_BANK; i++) begin : BANKS
     memory #(
    .WIDTH(WIDTH),
    .ADDR(ADDR_TOTAL),
    .NUM_BANK(NUM_BANK)
  ) dut (
    .i_clk_a(i_clk_a),
    .i_clk_b(i_clk_b),
    .i_en_a(i_en_a),
    .i_en_b(i_en_b ),
    .i_we_a(i_we_a),
    .i_we_b(i_we_b),
    .i_din_a(i_din_a),
    .i_din_b(i_din_b),
    .i_addr_a(i_addr_a),
    .i_addr_b(i_addr_b),
    .o_dout_a(bank_dout_a),
    .o_dout_b(bank_dout_b)
  );
  end
     endgenerate
     assign o_dout_a = bank_dout_a[bank_sel_a];
     assign o_dout_b = bank_dout_b[bank_sel_b];
endmodule
