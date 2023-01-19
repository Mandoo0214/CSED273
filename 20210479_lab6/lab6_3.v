/* CSED273 lab6 experiment 3 */
/* lab6_3.v */

`timescale 1ps / 1fs

/* Implement 369 game counter (0, 3, 6, 9, 13, 6, 9, 13, 6 ...)
 * You must first implement D flip-flop in lab6_ff.v
 * then you use D flip-flop of lab6_ff.v */
module counter_369(input reset_n, input clk, output [3:0] count);

    ////////////////////////
    /* Add your code here */
    wire qa, qb, qc, qd;
    wire qa_, qb_, qc_, qd_;
    wire da, db, dc, dd;
    
    assign da = (qa & qb_) | (qc & qd_);
    assign db = qd;
    assign dc = (qa_ & qb_) | (qa & qb);
    assign dd = qd_ | (qa & qb_);
    
    edge_trigger_D_FF DFFA(reset_n, da, clk, qa, qa_);
    edge_trigger_D_FF DFFB(reset_n, db, clk, qb, qb_);
    edge_trigger_D_FF DFFC(reset_n, dc, clk, qc, qc_);
    edge_trigger_D_FF DFFD(reset_n, dd, clk, qd, qd_);
    
    assign count[3] = qa;
    assign count[2] = qb;
    assign count[1] = qc;
    assign count[0] = qd;
    ////////////////////////	
endmodule
