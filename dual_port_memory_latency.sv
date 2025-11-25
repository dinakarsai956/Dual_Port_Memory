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

//=========================================================
// Dual-Port Memory with Per-Port Read/Write Latency
// - Dual clocks: i_clk_a, i_clk_b
// - Read occurs when i_en_* = 1 and i_we_* = 0
// - Write occurs when i_we_* = 1 (i_en_* is ignored for write)
// - READ_LATENCY_* cycles from read request to o_dout_*
// - WRITE_LATENCY_* cycles from write request to memory commit
// NOTE:
//   - This is a behavioral model intended for simulation/inference.
//   - In real dual-clock RAMs, read is typically synchronous (READ_LATENCY >= 1).
//   - Same-address write collisions across clocks resolve to "last in time wins".
//=========================================================
module dual_port_memory_latency
    #(
        parameter integer WIDTH            = 8,
        parameter integer ADDR_WIDTH       = 4,
        parameter integer DEPTH            = 2 ** ADDR_WIDTH,
        parameter integer WRITE_LATENCY_A  = 1,
        parameter integer READ_LATENCY_A   = 2,
        parameter integer WRITE_LATENCY_B  = 1,
        parameter integer READ_LATENCY_B   = 2
    )
    (
        // --------- Port A ---------
        input  wire                      i_clk_a,
        input  wire                      i_we_a,   // Write enable (A)
        input  wire                      i_en_a,   // Read enable  (A)
        input  wire [ADDR_WIDTH-1:0]     i_addr_a,
        input  wire [WIDTH-1:0]          i_din_a,
        output logic [WIDTH-1:0]         o_dout_a,

        // --------- Port B ---------
        input  wire                      i_clk_b,
        input  wire                      i_we_b,   // Write enable (B)
        input  wire                      i_en_b,   // Read enable  (B)
        input  wire [ADDR_WIDTH-1:0]     i_addr_b,
        input  wire [WIDTH-1:0]          i_din_b,
        output logic [WIDTH-1:0]         o_dout_b
    );

    // -----------------------------------------------------
    // Memory Array
    // -----------------------------------------------------
    logic [WIDTH-1:0] mem [0:DEPTH-1];

    // -----------------------------------------------------
    // Helpers
    // Read only when en=1 and we=0 on that port
    // -----------------------------------------------------
    wire ren_a = i_en_a & ~i_we_a;
    wire ren_b = i_en_b & ~i_we_b;

    
    typedef struct packed {
        logic                    we;
        logic [ADDR_WIDTH-1:0]   addr;
        logic [WIDTH-1:0]        din;
    } wr_req_t;

    wr_req_t wpipe_a [0:WRITE_LATENCY_A];
    wr_req_t wpipe_b [0:WRITE_LATENCY_B];

    // Capture and shift write pipeline on Port A
    integer i;
    always_ff @(posedge i_clk_a) begin
        // Stage 0 captures current cycle write request
        wpipe_a[0].we   <= i_we_a;
        wpipe_a[0].addr <= i_addr_a;
        wpipe_a[0].din  <= i_din_a;

        // Shift deeper stages
        for (i = 1; i <= WRITE_LATENCY_A; i++) begin
            wpipe_a[i] <= wpipe_a[i-1];
        end

        // Commit at final stage
        if (wpipe_a[WRITE_LATENCY_A].we) begin
            mem[wpipe_a[WRITE_LATENCY_A].addr] <= wpipe_a[WRITE_LATENCY_A].din;
        end
    end

    // Capture and shift write pipeline on Port B
    integer j;
    always_ff @(posedge i_clk_b) begin
        // Stage 0 captures current cycle write request
        wpipe_b[0].we   <= i_we_b;
        wpipe_b[0].addr <= i_addr_b;
        wpipe_b[0].din  <= i_din_b;
        for (j = 1; j <= WRITE_LATENCY_B; j++) begin
            wpipe_b[j] <= wpipe_b[j-1];
        end
        if (wpipe_b[WRITE_LATENCY_B].we) begin
            mem[wpipe_b[WRITE_LATENCY_B].addr] <= wpipe_b[WRITE_LATENCY_B].din;
        end
    end
    // --------- Port A Read ---------
    generate
        if (READ_LATENCY_A == 0) begin : G_A_ASYNC_READ
            always_comb begin
                o_dout_a = (ren_a) ? mem[i_addr_a] : '0;
            end
        end else begin : G_A_SYNC_READ
            // Address/enable pipelines
            logic [ADDR_WIDTH-1:0] raddr_a_pipe [0:READ_LATENCY_A-1];
            logic                  ren_a_pipe   [0:READ_LATENCY_A-1];

            integer ra;
            always_ff @(posedge i_clk_a) begin
                // Stage 0 capture
                raddr_a_pipe[0] <= i_addr_a;
                ren_a_pipe[0]   <= ren_a;

                // Shift deeper stages
                for (ra = 1; ra < READ_LATENCY_A; ra++) begin
                    raddr_a_pipe[ra] <= raddr_a_pipe[ra-1];
                    ren_a_pipe[ra]   <= ren_a_pipe[ra-1];
                end
                if (ren_a_pipe[READ_LATENCY_A-1]) begin
                    o_dout_a <= mem[raddr_a_pipe[READ_LATENCY_A-1]];
                end
                // else hold previous o_dout_a
            end
        end
    endgenerate

    // --------- Port B Read ---------
    generate
        if (READ_LATENCY_B == 0) begin : G_B_ASYNC_READ
            always_comb begin
                o_dout_b = (ren_b) ? mem[i_addr_b] : '0;
            end
        end else begin : G_B_SYNC_READ
            // Address/enable pipelines
            logic [ADDR_WIDTH-1:0] raddr_b_pipe [0:READ_LATENCY_B-1];
            logic                  ren_b_pipe   [0:READ_LATENCY_B-1];

            integer rb;
            always_ff @(posedge i_clk_b) begin
                // Stage 0 capture
                raddr_b_pipe[0] <= i_addr_b;
                ren_b_pipe[0]   <= ren_b;

                // Shift deeper stages
                for (rb = 1; rb < READ_LATENCY_B; rb++) begin
                    raddr_b_pipe[rb] <= raddr_b_pipe[rb-1];
                    ren_b_pipe[rb]   <= ren_b_pipe[rb-1];
                end

                // Read at final stage address; update output only when read enabled
                if (ren_b_pipe[READ_LATENCY_B-1]) begin
                    o_dout_b <= mem[raddr_b_pipe[READ_LATENCY_B-1]];
                end
                // else hold previous o_dout_b
            end
        end
    endgenerate

endmodule

