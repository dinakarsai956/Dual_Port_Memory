///////////////////////////////////////////////////////////////////////////////////////////
//  Design of dual port memory with latency feature as well as error correction feature . 
//  Here we are including hamming encoder as well as hamming decoder here we
//  are giving a data to a dual port memory it will add parity bits to the
//  data bits and combination of data we produce the output these output will
//  acts as input to hamming decoder and it will detect the error and bit and
//  correct it by flipping the error bit.
//
///////////////////////////////////////////////////////////////////////////////////////////

module dual_port_memory_latency_error_correction #(parameter DATA_WIDTH = 8,
  parameter ENCODED_WIDTH = 12,
  parameter ADDR_WIDTH = 3,
  parameter MEM_DEPTH = 2 ** ADDR_WIDTH,
  parameter WRITE_LATENCY_A = 5,
  parameter READ_LATENCY_A = 4,
  parameter WRITE_LATENCY_B = 4,
  parameter READ_LATENCY_B = 5
  )
  ( input i_clk_a, i_clk_b,
    input i_en_a, i_en_b,
    input i_we_a, i_we_b,
    input [DATA_WIDTH-1:0] i_din_a, i_din_b,
    input [ADDR_WIDTH-1:0] i_addr_a, i_addr_b,
    output reg[DATA_WIDTH-1:0] o_dout_a, o_dout_b,
    output logic error_a, error_b
  );
  logic [ENCODED_WIDTH-1:0] i_encoded_data_a, i_encoded_data_b;
  logic [ENCODED_WIDTH-1:0] o_encoded_data_a, o_encoded_data_b;
  logic [DATA_WIDTH-1:0] o_decoded_data_a, o_decoded_data_b;
  logic corrected_data_a, corrected_data_b;
  hamming_encoder duta(.data_in(i_din_a), .data_out(i_encoded_data_a));
  hamming_encoder dutb(.data_in(i_din_b), .data_out(i_encoded_data_b));
  
    dual_port_ram_with_latencies #(
        .DATA_WIDTH(ENCODED_WIDTH),
        .ADDR_WIDTH(ADDR_WIDTH),
        .WRITE_LATENCY_A(WRITE_LATENCY_A),
        .READ_LATENCY_A(READ_LATENCY_A),
        .WRITE_LATENCY_B(WRITE_LATENCY_B),
        .READ_LATENCY_B(READ_LATENCY_B)
    ) UUT (
        .i_clk_a(i_clk_a),
        .i_clk_b(i_clk_b),
        .i_en_a(i_en_a),
        .i_en_b(i_en_b),
        .i_we_a(i_we_a),
        .i_we_b(i_we_b),
        .i_din_a(i_encoded_data_a),
        .i_din_b(i_encoded_data_b),
        .i_addr_a(i_addr_a),
        .i_addr_b(i_addr_b),
        .o_dout_a(o_encoded_data_a),
        .o_dout_b(o_encoded_data_b)
    );
  hamming_decoder dutc(.data_in(o_encoded_data_a), .data_out(o_decoded_data_a), .error_detected(error_a), .error_corrected(corrected_data_a));
  hamming_decoder dutd(.data_in(o_encoded_data_b), .data_out(o_decoded_data_b), .error_detected(error_b), .error_corrected(corrected_data_b));
   
   always_ff @(posedge i_clk_a)begin
     o_dout_a <= o_decoded_data_a;
     if(error_a)
       $display("Port_A errror detcted and corrected at time %0t", $time);
   end
     always_ff @(posedge i_clk_b)begin
       o_dout_b <= o_decoded_data_b;
     if(error_b)
       $display("Port_B errror detcted and corrected at time %0t", $time);
   end





endmodule
