/* CSED273 lab6 experiment 1 */
/* lab6_1.v */

`timescale 1ps / 1fs

/* Implement synchronous BCD decade counter (0-9)
 * You must use JK flip-flop of lab6_ff.v */
module decade_counter(input reset_n, input clk, output [3:0] count);

    ////////////////////////
    /* Add your code here */
    wire qa, qb, qc, qd;
    wire qa_, qb_, qc_, qd_;
    wire ja, ka, jb, kb, jc, kc, jd, kd;
    
    assign ja = qb & qc & qd;
    assign ka = qd;
    assign jb = qc & qd;
    assign kb = qc & qd;
    assign jc = qa_ & qd;
    assign kc = qd;
    assign jd = 1;
    assign kd = 1;
    
    edge_trigger_JKFF JKFFA(reset_n, ja, ka, clk, qa, qa_);
    edge_trigger_JKFF JKFFB(reset_n, jb, kb, clk, qb, qb_);
    edge_trigger_JKFF JKFFC(reset_n, jc, kc, clk, qc, qc_);
    edge_trigger_JKFF JKFFD(reset_n, jd, kd, clk, qd, qd_);
    
    assign count[3] = qa;
    assign count[2] = qb;
    assign count[1] = qc;
    assign count[0] = qd;
    ////////////////////////
	
endmodule