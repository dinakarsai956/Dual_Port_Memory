module decoder_testbench;
  parameter A = 2;
  parameter B = 8;
  
  logic [A-1:0] in;
  logic [B-1:0] out;
  decoder #(.A(A), .B(B)) dut(.in(in), .out(out));
    initial begin
      
      in = 2'b00;
      #10;
      in = 2'b01;
      #10;
      in = 2'b11;
      #10;
      in = 2'b10;
      #10;
      $display("in = %0d", in, $time);
      $finish;
    end
endmodule
