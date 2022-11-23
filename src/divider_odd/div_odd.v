module div_odd
    (
        input clk,
        input rst_n,
        output clk_out
    );

    parameter N = 5;
    localparam cnt_bit =
               N > 512 ? 10 :
               N > 256 ? 9 :
               N > 128 ? 8 :
               N > 64 ? 7 :
               N > 32 ? 6 :
               N > 16 ? 5 :
               N > 8 ? 4 :
               N > 4 ? 3 :
               N > 2 ? 2 : 1 ;//分频数，需要是偶数
    //----------count the posedge---------------------
    reg [cnt_bit-1:0] cnt_p;
    reg clk_p;

    always @ (posedge clk or negedge rst_n)
        if(!rst_n)
            cnt_p <= 0;
        else if(cnt_p == N-1)
            cnt_p <= 0;
        else
            cnt_p <= cnt_p + 1'b1;

    always @ (posedge clk or negedge rst_n)
        if(!rst_n)
            clk_p <= 0;
        else if((cnt_p == N/2) || (cnt_p == N-1))
            clk_p <= ~ clk_p;
    //---------------------------------------------

    //----------count the negedge------------------
    reg [2:0] cnt_n;
    reg clk_n;

    always @ (negedge clk or negedge rst_n)
        if(!rst_n)
            cnt_n <= 0;
        else if(cnt_n == N-1)
            cnt_n <= 0;
        else
            cnt_n <= cnt_n + 1'b1;

    always @ (negedge clk or negedge rst_n)
        if(!rst_n)
            clk_n <= 1'b0;
        else if((cnt_n == N/2) || (cnt_n == N-1))
            clk_n <= ~clk_n;
    //----------------------------------------------

    assign clk_out = clk_p | clk_n;


endmodule
