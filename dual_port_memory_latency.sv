////////////////////////////////////////////////////////////////////////////////////////////
//
//  Design of dual port memory using latency feature , where latency feature
//  will delay the signals for read and write the operations using parameters
//  WRITE_LATENCY, READ_LATENCY. Here we are designing a parameters using
//  WIDTH, ADDR, DEPTH, READ_LATENCY, WRITE_LATENCY . Based on i_en_a , i_en_b
//  signal it depends whether to perform operation or not here when i_en_a,
//  i_en_b is high it will perform read or write when i_we_a, i_we_b is high 
//  it will write when it is low it will read . based on address i_addr_a,
//  i_addr_b will select location of memory access. Based on latency
//  parameters and i_en_a, i_en_b, i_we_a, i_we_b it will write and read. 
//
///////////////////////////////////////////////////////////////////////////////////////////////

module dual_port_memory_latency #(
    parameter DATA_WIDTH      = 8,
    parameter ADDR_WIDTH      = 3,
    parameter WRITE_LATENCY_A = 5,
    parameter READ_LATENCY_A  = 4,
    parameter WRITE_LATENCY_B = 4,
    parameter READ_LATENCY_B  = 5
)(
    input  logic                   i_clk_a,
    input  logic                   i_clk_b,
    input  logic                   i_en_a,
    input  logic                   i_en_b,
    input  logic                   i_we_a,
    input  logic                   i_we_b,
    input  logic [DATA_WIDTH-1:0]  i_din_a,
    input  logic [DATA_WIDTH-1:0]  i_din_b,
    input  logic [ADDR_WIDTH-1:0]  i_addr_a,
    input  logic [ADDR_WIDTH-1:0]  i_addr_b,
    output logic [DATA_WIDTH-1:0]  o_dout_a,
    output logic [DATA_WIDTH-1:0]  o_dout_b
);

        localparam MEM_DEPTH = 2**ADDR_WIDTH;
    
        logic [DATA_WIDTH-1:0] mem [MEM_DEPTH];

        logic [DATA_WIDTH-1:0] read_sr_a [READ_LATENCY_A:0];
       logic [DATA_WIDTH-1:0] write_sr_a [WRITE_LATENCY_A:0];
    logic [ADDR_WIDTH-1:0] addr_sr_a  [WRITE_LATENCY_A:0];

        logic [DATA_WIDTH-1:0] read_sr_b [READ_LATENCY_B:0];
        logic [DATA_WIDTH-1:0] write_sr_b [WRITE_LATENCY_B:0];
    logic [ADDR_WIDTH-1:0] addr_sr_b  [WRITE_LATENCY_B:0];
    
        always_ff @(posedge i_clk_a) begin
        if (i_en_a) begin
          write_sr_a[0] <= i_din_a;
          addr_sr_a[0]  <= i_addr_a;
          for (int i = 0; i < WRITE_LATENCY_A; i++) begin
             write_sr_a[i+1] <= write_sr_a[i];
             addr_sr_a[i+1]  <= addr_sr_a[i];
            end
            end
    end
    logic we_sr_a [WRITE_LATENCY_A:0];
    logic en_sr_a [WRITE_LATENCY_A:0];
    logic we_sr_b [WRITE_LATENCY_B:0];
    logic en_sr_b [WRITE_LATENCY_B:0];

    always_ff @(posedge i_clk_a) begin
              en_sr_a[0]  <= i_en_a;
        we_sr_a[0]  <= i_we_a;
        addr_sr_a[0]<= i_addr_a;
        write_sr_a[0]<= i_din_a;
        read_sr_a[0]<= mem[i_addr_a];
	for (int i = 0; i < WRITE_LATENCY_A; i++) begin
            en_sr_a[i+1] <= en_sr_a[i];
            we_sr_a[i+1] <= we_sr_a[i];
            addr_sr_a[i+1] <= addr_sr_a[i];
            write_sr_a[i+1] <= write_sr_a[i];
        end

        for (int i = 0; i < READ_LATENCY_A; i++) begin
             read_sr_a[i+1] <= read_sr_a[i];
        end

       
        if (en_sr_a[WRITE_LATENCY_A] && we_sr_a[WRITE_LATENCY_A]) begin
            mem[addr_sr_a[WRITE_LATENCY_A]] <= write_sr_a[WRITE_LATENCY_A];
        end

          o_dout_a <= read_sr_a[READ_LATENCY_A];
        end
    
        always_ff @(posedge i_clk_b) begin
               en_sr_b[0]  <= i_en_b;
        we_sr_b[0]  <= i_we_b;
        addr_sr_b[0]<= i_addr_b;
        write_sr_b[0]<= i_din_b;
        read_sr_b[0]<= mem[i_addr_b];
        for (int i = 0; i < WRITE_LATENCY_B; i++) begin
            en_sr_b[i+1] <= en_sr_b[i];
            we_sr_b[i+1] <= we_sr_b[i];
            addr_sr_b[i+1] <= addr_sr_b[i];
            write_sr_b[i+1] <= write_sr_b[i];
        end

        for (int i = 0; i < READ_LATENCY_B; i++) begin
             read_sr_b[i+1] <= read_sr_b[i];
        end

                if (en_sr_b[WRITE_LATENCY_B] && we_sr_b[WRITE_LATENCY_B]) begin
            mem[addr_sr_b[WRITE_LATENCY_B]] <= write_sr_b[WRITE_LATENCY_B];
        end

                o_dout_b <= read_sr_b[READ_LATENCY_B];
    end

endmodule

