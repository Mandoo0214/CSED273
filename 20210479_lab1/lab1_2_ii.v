/* CSED273 lab1 experiment 2_ii */
/* lab1_2_ii.v */


/* Implement OR with {AND, NOT}
 * You are only allowed to wire modules together */
module lab1_2_ii(outOR, inA, inB);
    output wire outOR;
    input wire inA, inB;

    wire nA, nB, andAB;
    
    not(nA, inA);
    not(nB, inB);
    and(andAB, nA, nB);
    not(outOR, andAB);

endmodule