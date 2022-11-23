`timescale 1ns / 1ps
module tb ;

    // 定义信号
    reg clk,rst_n;
    wire clk1;
    wire clk_out;

    // 生成始时钟
    parameter NCLK = 40; //40ns 25Mhz
    initial begin
        clk=0;
        forever
            clk=#(NCLK/2) ~clk;
    end

    /****************** 开始 ADD module inst ******************/
    div_half #(
                 .N ( 13 ))
             inst_div_half (
                 .clk_out           (clk_out),
                 .clk1              (clk1),
                 .clk               (clk),
                 .rst_n             (rst_n)
             );
    /****************** 结束 END module inst ******************/

    initial begin
        $dumpfile("wave.lxt2");
        $dumpvars(0, tb);   //dumpvars(深度, 实例化模块1, 实例化模块2, .....)
    end

    initial begin
        rst_n = 1;
        #(NCLK) rst_n=0;
        #(NCLK) rst_n=1; //复位信号

        repeat(1000) @(posedge clk)begin

        end
        $display("运行结束！");
        $dumpflush;
        $finish;
        $stop;
    end
endmodule
