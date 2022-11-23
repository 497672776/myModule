module div_half(
        output clk_out,
        output clk1,
        input clk,
        input rst_n);

    parameter N = 13; //以12.5分频为例，N=13

    wire clk1;
    reg clk_out;
    reg[4:0] cnt;
    reg flag = 1'b0;

    //系统时钟clk计数器
    always @(negedge clk or negedge rst_n)
        if(!rst_n)
            flag <= 1'b0;
        else if(cnt == 5'd6)
            flag <= ~flag;
    //在第五个时钟结束后立即将 clk1 状态翻转
    assign clk1 = (flag)? ~clk:clk;

    //时钟 clk1 计数器，模为N
    always @(posedge clk1 or negedge rst_n)
        if(!rst_n)
            cnt <= 5'b0;
        else if(cnt == 5'd12)
            cnt <= 5'b0;
        else
            cnt <= cnt + 1'b1;

    //前6.5个周期为低电平，后6个周期为高电平，
    //即为12.5分频
    always @(posedge clk1 or negedge rst_n)
        if(!rst_n)
            clk_out <= 1'b0;
        else if(cnt == 5'd0)
            clk_out <= 1'b0;
        else if(cnt == 5'd7)
            clk_out <= 1'b1;
        else
            clk_out <= clk_out;
endmodule
