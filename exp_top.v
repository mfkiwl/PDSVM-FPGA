`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:43:56 12/04/2017 
// Design Name: 
// Module Name:    exp_top 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module exp_top(
     
     clk,
	  rst_n,
     sum_a,//input
	  enable,
	  svm_enable,
	  out_b,//output
	  busy_e
	  
    );
     
	  parameter IN_WIDTH = 32;
	  parameter OUT_WIDTH = 32;
	  
	  input clk;
	  input rst_n;
	  input [IN_WIDTH-1:0] sum_a;
	  input enable;
	  input svm_enable;
	  output reg [OUT_WIDTH-1:0] out_b;//wire
	  output  busy_e;
	  assign busy_e = busy_reg_e;
	  
	  reg [31:0] ln_G [0:15];
	  reg [31:0] ln_g [0:14];
	  reg [4:0] i;
	  //reg [4:0] ii;
	  //reg [4:0] j;
	  reg [31:0] a;
	  reg [47:0] b;
	  //reg start;
	  
	  /////////////////////////////////////////
	   //  wire [31:0] exp_b;	 
		// wire [31:0] yyushu;   
	  reg [4:0] kk;
	  reg busy_reg_e;

	  always @(posedge clk or negedge rst_n)
	  begin
	       if(!rst_n)
          begin
					 i <= 5'b0;
					 //ii <= 5'b0;
					 //j <= 5'b0;
					 b <= 48'b000000000000000100000000000000000000000000000000;
					 a <= sum_a;
					 //start <= 1'b0;
					 //busy_e <= 1'b1;///////////
					 kk <= 0;
					 out_b <= 32'h00010000;
					 busy_reg_e <= 1;
					 
					 ln_G[0] <= 32'b00000000000000001011000101101111;//0.6931
					 ln_G[1] <= 32'b00000000000000010110001011100100;//1.3863
					 ln_G[2] <= 32'b00000000000000100001010001010011;//2.0794
					 ln_G[3] <= 32'b00000000000000101100010111001001;//2.7726
					 ln_G[4] <= 32'b00000000000000110111011100111000;//3.4657
					 ln_G[5] <= 32'b00000000000001000010100010101101;//4.1589
					 ln_G[6] <= 32'b00000000000001001101101000011100;//4.8520
					 ln_G[7] <= 32'b00000000000001011000101110010010;//5.5452
					 ln_G[8] <= 32'b00000000000001100011110100000001;//6.2383
					 ln_G[9] <= 32'b00000000000001101110111001110110;//6.9315
					 ln_G[10] <= 32'b00000000000001111001111111100101;//7.6246
					 ln_G[11] <= 32'b00000000000010000101000101010100;//8.3177
					 ln_G[12] <= 32'b00000000000010010000001011001010;//9.0109
					 ln_G[13] <= 32'b00000000000010011011010000111101;//9.7041
			       ln_G[14] <= 32'b00000000000010100110010110101111;//10.3972
			       ln_G[15] <= 32'b00000000000010110001011100100100;//11.0904
					 
					 ln_g[0] <= 32'b00000000000000000100100110100110;//0.2877
					 ln_g[1] <= 32'b00000000000000000010001000101101;//0.1335
					 ln_g[2] <= 32'b00000000000000000001000010000101;//0.06454
					 ln_g[3] <= 32'b00000000000000000000100000100000;//0.03175
					 ln_g[4] <= 32'b00000000000000000000010000001000;//0.01575
					 ln_g[5] <= 32'b00000000000000000000001000000010;//0.0078432
					 ln_g[6] <= 32'b00000000000000000000000100000000;//0.003914
					 ln_g[7] <= 32'b00000000000000000000000010000000;//0.001955
					 ln_g[8] <= 32'b00000000000000000000000001000000;//0.000977
					 ln_g[9] <= 32'b00000000000000000000000000100000;//0.0004884
					 ln_g[10] <= 32'b00000000000000000000000000010000;//0.0002442
					 ln_g[11] <= 32'b00000000000000000000000000001000;//0.0001221
					 ln_g[12] <= 32'b00000000000000000000000000000100;//0.00006103
					 ln_g[13] <= 32'b00000000000000000000000000000010;//0.00003052
					 ln_g[14] <= 32'b00000000000000000000000000000001;//0.00001526
					 
					 
			 end
			 else if(svm_enable == 1'b1) 
			 begin
			 
			 if((enable == 1'b1))
			 begin//1 if(enable)
			    busy_reg_e <= 1'b1;//state
				// busy_e <= 1'b1;
				 if(kk == 0)
				 begin
				     a <= sum_a;//
				     kk <= kk+1;
				 end
				 else if(sum_a > 32'b00000000000010110000000000000000)
				 begin
				      out_b <= 0;
						busy_reg_e <= 1'b0;
				      //busy_e <= 1'b0;//state
				 end
			    else if((sum_a > 0) && (sum_a <= 32'b00000000000010110000000000000000))
			    begin//2
				    //for(i = 0;i < 12;i = i+1)
					 if(a >= 32'b00000000000000001011000101101111)//0.6931
					 begin
						 if(i <= 14)
						 begin//3
								if((a >= ln_G[i]) && (a < ln_G[i+1]))
								begin
								a <= a - ln_G[i];
								b <= b>>(i+1);//2^(i+1),i start 0
								i <= 0;//clear 0,0
								end
								else begin
								i <= i+1;
								end
						 end
					 end
					 if((a >= 32'b00000000000000000100100110100110)&&(a < 32'b00000000000000001011000101101111))
					 begin
					     // begin 
							a <= a - 32'b00000000000000000100100110100110;//0.2877
							b <= b - (b>>2);
							//ii <= 0;//clear 0
					
					 end
              
					  if((a >= ln_g[1])&&(a < ln_g[0]))
					  begin
							  a <= a - ln_g[1];
							  b <= b - (b>>3);		  
                 end	
                 if((a >= ln_g[2])&&(a < ln_g[1]))
					  begin
							  a <= a - ln_g[2];
							  b <= b - (b>>4);		  
                 end					  
					  if((a >= ln_g[3])&&(a < ln_g[2]))
					  begin
							  a <= a - ln_g[3];
							  b <= b - (b>>5);		  
                 end	
					  if((a >= ln_g[4])&&(a < ln_g[3]))
					  begin
							  a <= a - ln_g[4];
							  b <= b - (b>>6);		  
                 end	
					  if((a >= ln_g[5])&&(a < ln_g[4]))
					  begin
							  a <= a - ln_g[5];
							  b <= b - (b>>7);		  
                 end	
					  if((a >= ln_g[6])&&(a < ln_g[5]))
					  begin
							  a <= a - ln_g[6];
							  b <= b - (b>>8);		  
                 end	
					  if((a >= ln_g[7])&&(a < ln_g[6]))
					  begin
							  a <= a - ln_g[7];
							  b <= b - (b>>9);		  
                 end	
					  if((a >= ln_g[8])&&(a < ln_g[7]))
					  begin
							  a <= a - ln_g[8];
							  b <= b - (b>>10);		  
                 end	
					  if((a >= ln_g[9])&&(a < ln_g[8]))
					  begin
							  a <= a - ln_g[9];
							  b <= b - (b>>11);		  
                 end	
					  if((a >= ln_g[10])&&(a < ln_g[9]))
					  begin
							  a <= a - ln_g[10];
							  b <= b - (b>>12);		  
                 end	
					  if((a >= ln_g[11])&&(a < ln_g[10]))
					  begin
							  a <= a - ln_g[11];
							  b <= b - (b>>13);		  
                 end	
					  if((a >= ln_g[12])&&(a < ln_g[11]))
					  begin
							  a <= a - ln_g[12];
							  b <= b - (b>>14);		  
                 end	
					  if((a >= ln_g[13])&&(a < ln_g[12]))
					  begin
							  a <= a - ln_g[13];
							  b <= b - (b>>15);		  
                 end	
					  if((a >= ln_g[14])&&(a < ln_g[13]))
					  begin
							  a <= a - ln_g[14];
							  b <= b - (b>>16);		  
                 end
					  
					 if((a < 32'b00000000000000000000000000000001))//(j == 0)&&
					 begin
					      
							busy_reg_e <= 1'b0;
				         //busy_e <= 1'b0;//state
	                  out_b <= b[47:16];
					 end
					
				 end//2
				 else if(sum_a == 0) 
				 begin
				    out_b <= 32'b00000000000000010000000000000000;
				    busy_reg_e <= 1'b0;
				   // busy_e <= 1'b0;//state
				 end
		end//1
		if(enable == 0)
		begin 		
			  i <= 0;
			  kk <= 0;
			  b <= 48'b000000000000000100000000000000000000000000000000;
			  busy_reg_e <= 1;
		end
	end
 end


endmodule
