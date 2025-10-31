////////////////////////////////////////////////////////////////////////////
//
// Design of hamming decoder by taking input and output we are taking extra 
// wire as syndrome xor operation takes place based on parity bit on array
// indices if syndrome is non zero there is error by then we will idnetify 
////////////////////////////////////////////////////////////////////////////

module hamming_decoder (
  input [11:0] data_in,
  output  logic error_detected,
  output logic error_corrected;

  output [7:0] data_out
  );
  logic error_detected;
  logic error_corrected;
  logic [3:0] syndrome;
  logic [11:0] corrected_code;
  assign syndrome[0] = data_in[0] ^ data_in[2] ^ data_in[4] ^ data_in[6] ^ data_in[8] ^ data_in[10];
  assign syndrome[1] = data_in[1] ^ data_in[2] ^ data_in[5] ^ data_in[6] ^ data_in[9] ^ data_in[10];
  assign syndrome[2] = data_in[3] ^ data_in[4] ^ data_in[5] ^ data_in[6];
  assign syndrome[3] = data_in[7] ^ data_in[8] ^ data_in[9] ^ data_in[10] ^ data_in[11];
  assign error_detected = | syndrome;
  assign error_corrected = | syndrome;
  always_comb begin
    corrected_code = data_in;
    if(error_detected)
      corrected_code[syndrome-1] = ~corrected_code[syndrome-1];
  end
  assign data_out[0] = corrected_code[2];
  assign data_out[1] = corrected_code[4];
  assign data_out[2] = corrected_code[5];
  assign data_out[3] = corrected_code[6];
  assign data_out[4] = corrected_code[8];
  assign data_out[5] = corrected_code[9];
  assign data_out[6] = corrected_code[10];
  assign data_out[7] = corrected_code[11];
  
  
endmodule
