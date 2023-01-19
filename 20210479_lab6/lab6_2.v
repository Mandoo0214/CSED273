/* CSED273 lab6 experiment 2 */
/* lab6_2.v */

`timescale 1ps / 1fs

/* Implement 2-decade BCD counter (0-99)
 * You must use decade BCD counter of lab6_1.v */
module decade_counter_2digits(input reset_n, input clk, output [7:0] count);

    ////////////////////////
    /* Add your code here */
    wire [3:0] count0; //0의 자리 bcd counter의 count
    wire [3:0] count1; //10의 자리 bcd counter의 count
    reg newclk;
    
    always @(negedge clk) begin
        if(count0 === 4'b1001) newclk = 0;
        else newclk = 1;
    end
    
    decade_counter DC0(reset_n, clk, count0[3:0]); //0의 자리 bcd counter
    decade_counter DC1(reset_n, newclk, count1[3:0]); //10의 자리 bcd counter

    /* 실제 output에 count0, count1 값 대입하기 */
    assign count[7] = count1[3];
    assign count[6] = count1[2];
    assign count[5] = count1[1];
    assign count[4] = count1[0];
    assign count[3] = count0[3];
    assign count[2] = count0[2];
    assign count[1] = count0[1];
    assign count[0] = count0[0];
    ////////////////////////
	
endmodule
