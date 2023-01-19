/* CSED273 lab5 experiment 2 */
/* lab5_2.v */

`timescale 1ns / 1ps

/* Implement srLatch */
module srLatch(
    input s, r,
    output q, q_
    );

    ////////////////////////
    /* Add your code here */
    nor(q, r, ~q);
    nor(q_, s, q);
    ////////////////////////

endmodule

/* Implement master-slave JK flip-flop with srLatch module */
module lab5_2(
    input reset_n, j, k, clk,
    output q, q_
    );

    ////////////////////////
    /* Add your code here */
    wire masterJ, masterK, masterS, masterR;
    wire p, p_;
    wire slaveS, slaveR;
    
    assign masterJ = j & q_ & clk;
    assign masterK = k & q & clk;
    
    assign masterS = masterJ & reset_n;
    assign masterR = masterK | ~reset_n;
      
    srLatch master(masterS, masterR, p, p_);
    
    and(slaveS, p, ~clk);
    and(slaveR, p_, ~clk);
    
    srLatch slave(slaveS, slaveR, q, q_);
    ////////////////////////
    
endmodule