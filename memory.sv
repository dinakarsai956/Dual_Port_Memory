////////////////////////////////////////////////////////////////////////////////////
// Design of normal dual port memory based on inputs i_clk_a, i_clk_b 
// i_din_a, i_din_b are two inputs are loaded into memory when i_en_a , i_en_b are high 
// then they are access to read and write when i_we_a and i_we_b are high then
// it will write and when it is low it will read
///////////////////////////////////////////////////////////////////////////////////

module memory #(
    parameter WIDTH = 8,
    ADDR = 3,
    DEPTH = 2 ** ADDR
) (
    input [WIDTH-1:0] i_din_a,
    input [WIDTH-1:0] i_din_b,
    input [ADDR-1:0] i_addr_a,
    input [ADDR-1:0] i_addr_b,
    input i_clk_a,
    i_clk_b,
    input i_en_a,
    i_en_b,
    input i_we_a,
    i_we_b,
    output logic [WIDTH-1:0] o_dout_a,
    output logic [WIDTH-1:0] o_dout_b
);
  logic [WIDTH-1:0] mem[0:DEPTH-1];

  always_ff @(posedge i_clk_a) begin  // memory read or write in port_A
    if (i_en_a) begin
      if (i_we_a) begin
        mem[i_addr_a] <= i_din_a;
      end else o_dout_a <= mem[i_addr_a];
    end
  end

  always_ff @(posedge i_clk_b) begin
    if (i_en_b) begin
      if (i_we_b) begin
        mem[i_addr_b] <= i_din_b;
      end else o_dout_b <= mem[i_addr_b];
    end
  end

endmodule
