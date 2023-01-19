/* CSED273 lab6 experiments */
/* lab6_tb.v */

`timescale 1ps / 1fs

module lab6_tb();

    integer Passed;
    integer Failed;

    /* Define input, output and instantiate module */
    ////////////////////////
    /* Add your code here */
    wire [3:0] count0;
    wire [7:0] count1;
    wire [3:0] count2;
    reg rstn, clk;
    
    initial begin
        rstn = 1;
        clk = 1;
    end
    
    always #1 clk = ~clk;
    
    decade_counter DC_test(rstn, clk, count0[3:0]);
    decade_counter_2digits DC2_test(rstn, clk, count1[7:0]);
    counter_369 C369_test(rstn, clk, count2[3:0]);
    ////////////////////////

    initial begin
        Passed = 0;
        Failed = 0;

        lab6_1_test;
        lab6_2_test;
        lab6_3_test;

        $display("Lab6 Passed = %0d, Failed = %0d", Passed, Failed);
        $finish;
    end

    /* Implement test task for lab6_1 */
    task lab6_1_test;
        ////////////////////////
        /* Add your code here */
        integer i;
        reg [3:0] out_expected;
        
        begin
            out_expected = 4'b0000;
            
            for(i = 0; i < 10; i = i + 1) begin
                if(i === 0) #1;
                else #2; 
                         
                if(out_expected === count0) begin //예측과 똑같을 경우
                    Passed = Passed + 1;
                end
           
                else begin //오류가 생겼을 경우
                    $display("Error) count: %0b, answer: %0b", count0, out_expected);
                    Failed = Failed + 1;
                end
                
                out_expected = out_expected + 1;  
            end
        end
        ////////////////////////
    endtask

    /* Implement test task for lab6_2 */
    task lab6_2_test;
        ////////////////////////
        /* Add your code here */
        integer i;
        reg [7:0] out_expected;
        
        begin
            out_expected = 8'b00000000;
            for(i = 0; i < 100; i = i + 1) begin
                if(i === 0) #1;
                else #2;
                
                if(out_expected === count1) begin //예측과 똑같을 경우
                    Passed = Passed + 1;
                end
                
                else begin //오류가 생겼을 경우
                    $display("Error) count: %0b, answer: %0b", count1, out_expected);
                    Failed = Failed + 1;
                end
                
                if (i === 9) out_expected = 8'b00010000;
                else if (i === 19) out_expected = 8'b00100000;
                else if (i === 29) out_expected = 8'b00110000;
                else if (i === 39) out_expected = 8'b01000000;
                else if (i === 49) out_expected = 8'b01010000;
                else if (i === 59) out_expected = 8'b01100000;
                else if (i === 69) out_expected = 8'b01110000;
                else if (i === 79) out_expected = 8'b10000000;
                else if (i === 89) out_expected = 8'b10010000;
                else if (i === 99) out_expected = 8'b10011001;
                else out_expected = out_expected + 1;
            end
        end
        ////////////////////////
    endtask

    /* Implement test task for lab6_3 */
    task lab6_3_test;
        ////////////////////////
        /* Add your code here */
        integer i;
        reg [3:0] out_expected;
        
        begin
            if(Passed === 0) begin
                out_expected = 4'b0000;
                for(i = 0; i < 13; i = i + 3) begin
                    /* out_expected 업데이트 */
                    if(i === 12) begin
                        out_expected = 4'b1101;
                    end
                
                    if(i === 0) #1;
                    else #2;
                
                    if(out_expected === count2) begin //예측과 똑같을 경우
                         Passed = Passed + 1;
                    end
                
                    else begin //오류가 생겼을 경우
                        $display("Error) count: %0b, answer: %0b", count1, out_expected);
                        Failed = Failed + 1;
                    end
                
                     out_expected = out_expected + 4'b0011;
                end
            end
            
            else begin
                out_expected = 4'b0110;
                for(i = 6; i < 13; i = i + 3) begin
                    /* out_expected 업데이트 */
                    if(i === 12) begin
                        out_expected = 4'b1101;
                    end
                
                    #2;
                    if(out_expected === count2) begin //예측과 똑같을 경우
                         Passed = Passed + 1;
                    end
                
                    else begin //오류가 생겼을 경우
                        $display("Error) count: %0b, answer: %0b", count1, out_expected);
                        Failed = Failed + 1;
                    end
                
                     out_expected = out_expected + 4'b0011;
                end
            end
        end
        ////////////////////////
    endtask
endmodule