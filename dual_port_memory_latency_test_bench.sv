module dual_port_memory_latency_test_bench;

    localparam DATA_WIDTH      = 8;
    localparam ADDR_WIDTH      = 3;
    localparam WRITE_LATENCY_A = 5;
    localparam READ_LATENCY_A  = 4;
    localparam WRITE_LATENCY_B = 4;
    localparam READ_LATENCY_B  = 5;

    
    logic i_clk_b;
    
    initial begin
        i_clk_a = 0;
        forever #5 i_clk_a = ~i_clk_a; 
    end
    initial begin
        i_clk_b = 0;
        forever #10 i_clk_b = ~i_clk_b; 
    end

  
    logic                   i_en_a;
    logic                   i_en_b;
    logic                   i_we_a;
    logic                   i_we_b;
    logic [DATA_WIDTH-1:0]  i_din_a;
    logic [DATA_WIDTH-1:0]  i_din_b;
    logic [ADDR_WIDTH-1:0]  i_addr_a;
    logic [ADDR_WIDTH-1:0]  i_addr_b;

  
    logic [DATA_WIDTH-1:0]  o_dout_a;
    logic [DATA_WIDTH-1:0]  o_dout_b;


    dual_port_ram_with_latencies #(
        .DATA_WIDTH(DATA_WIDTH),
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
        .i_din_a(i_din_a),
        .i_din_b(i_din_b),
        .i_addr_a(i_addr_a),
        .i_addr_b(i_addr_b),
        .o_dout_a(o_dout_a),
        .o_dout_b(o_dout_b)
    );

   
    initial begin
        
        i_en_a = 0;
        i_en_b = 0;
        i_we_a = 0;
        i_we_b = 0;
        i_din_a = 0;
        i_din_b = 0;
        i_addr_a = 0;
        i_addr_b = 0;

        /
        #20ns;

        $display("Starting simulation...");

       
        $display("--- Port A Writes ---");
        i_en_a = 1;
        i_we_a = 1;

       
        i_addr_a = 0;
        i_din_a  = 8'hA0;
        @(posedge i_clk_a); 

        
        i_addr_a = 1;
        i_din_a  = 8'hA1;
        @(posedge i_clk_a);

     
        i_addr_a = 2;
        i_din_a  = 8'hA2;
        @(posedge i_clk_a);

        i_we_a = 0; 

        
        repeat (WRITE_LATENCY_A + 2) @(posedge i_clk_a);


       
        $display("--- Port B Writes ---");
        i_en_b = 1;
        i_we_b = 1;

     
        i_addr_b = 5;
        i_din_b  = 8'hB5;
        @(posedge i_clk_b);

       
        i_addr_b = 6;
        i_din_b  = 8'hB6;
        @(posedge i_clk_b);

        i_we_b = 0; 
        
    
        repeat (WRITE_LATENCY_B + 2) @(posedge i_clk_b);


        
        $display("--- Port A Reads ---");
        i_en_a = 1;
        i_we_a = 0;

        
        i_addr_a = 0;
        @(posedge i_clk_a); 
        $display("CLK A Cycle %0t: Read Request Addr %0d. Data out will appear after %0d cycles.", $time, i_addr_a, READ_LATENCY_A);

        i_addr_a = 1;
        @(posedge i_clk_a);
        $display("CLK A Cycle %0t: Read Request Addr %0d. Data out will appear after %0d cycles.", $time, i_addr_a, READ_LATENCY_A);

        i_addr_a = 2;
        @(posedge i_clk_a);
        $display("CLK A Cycle %0t: Read Request Addr %0d. Data out will appear after %0d cycles.", $time, i_addr_a, READ_LATENCY_A);


        
        repeat (READ_LATENCY_A) @(posedge i_clk_a);
        $display("CLK A Cycle %0t: o_dout_a = 0x%h (Expected: 0xA0)", $time, o_dout_a);
        @(posedge i_clk_a);
        $display("CLK A Cycle %0t: o_dout_a = 0x%h (Expected: 0xA1)", $time, o_dout_a);
        @(posedge i_clk_a);
        $display("CLK A Cycle %0t: o_dout_a = 0x%h (Expected: 0xA2)", $time, o_dout_a);
        

        
        $display("--- Port B Reads ---");
        i_en_b = 1;
        i_we_b = 0;

        
        i_addr_b = 5;
        @(posedge i_clk_b);
        $display("CLK B Cycle %0t: Read Request Addr %0d. Data out will appear after %0d cycles.", $time, i_addr_b, READ_LATENCY_B);

        i_addr_b = 6;
        @(posedge i_clk_b);
        $display("CLK B Cycle %0t: Read Request Addr %0d. Data out will appear after %0d cycles.", $time, i_addr_b, READ_LATENCY_B);


        
        repeat (READ_LATENCY_B) @(posedge i_clk_b);
        $display("CLK B Cycle %0t: o_dout_b = 0x%h (Expected: 0xB5)", $time, o_dout_b);
        @(posedge i_clk_b);
        $display("CLK B Cycle %0t: o_dout_b = 0x%h (Expected: 0xB6)", $time, o_dout_b);


        $display("Simulation finished.");
        $finish;

    end

endmodule

