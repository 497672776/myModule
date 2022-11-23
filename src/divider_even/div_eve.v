module div_eve(
        output reg clk_out,
        input clk,
        input rst_n);

    parameter N = 20;//分频数，需要是偶数
    localparam cnt_bit =
               N/2 > 512 ? 10 :
               N/2 > 256 ? 9 :
               N/2 > 128 ? 8 :
               N/2 > 64 ? 7 :
               N/2 > 32 ? 6 :
               N/2 > 16 ? 5 :
               N/2 > 8 ? 4 :
               N/2 > 4 ? 3 :
               N/2 > 2 ? 2 : 1 ;//分频数，需要是偶数
    reg [cnt_bit-1:0] cnt;

    always @(posedge clk or negedge rst_n)
        if(!rst_n)begin
            cnt <= 5'b0;
            clk_out <= 1'b0;
        end
        else if(cnt == N/2-1)begin
            cnt <= 5'b0;
            clk_out <= ~clk_out;
        end
        else
            cnt <= cnt + 1'b1;

endmodule
