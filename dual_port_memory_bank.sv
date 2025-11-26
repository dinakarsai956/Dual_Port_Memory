///////////////////////////////////////////////////////////////////////////////
//  Designing of dual port memory bank of parametrized where it has parameters WIDTH,
//  ADDR, DEPTH by using it divides it into multiple independent banks to
//  enable parallel access , reduce latency, and improve data throughout.
//  Each bank can be access simultaneously through seperate ports allowing
//  efficient read / write operations with reduce conflicts and improves the
//  performance.
//
/////////////////////////////////////////////////////////////////////////////////////////

module dual_port_memory_bank #(parameter WIDTH = 8,
  parameter ADDR = 3,
  parameter DEPTH = 2 ** ADDR)
  ( input i_clk_a, i_clk_b,
    input i_en_a, i_en_b,
    input i_we_a, i_we_b,
    input [WIDTH-1:0] i_din_a, i_din_b,
    input [ADDR-1:0] i_addr_a, i_addr_b,
    output logic [WIDTH-1:0] o_dout_a, o_dout_b
    );
    logic [WIDTH-1:0] mem[DEPTH-1:0];

    // Port_A
    always_ff @(posedge i_clk_a)begin
      if(i_en_a)begin
        if(i_we_a)begin
	  mem[i_addr_a] <= i_din_a;
	  end
	else
	  begin
	    o_dout_a <= mem[i_addr_a];
	  end
      end
    end

    // Port_B
     always_ff @(posedge i_clk_b)begin
      if(i_en_b)begin
        if(i_we_b)begin
	  mem[i_addr_b] <= i_din_b;
	  end
	else
	  begin
	    o_dout_b <= mem[i_addr_b];
	  end
      end
    end

endmodule
