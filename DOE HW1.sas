data exp_design;
array loc{5} (0.01 0 0.05 0.02 0.03);
array pr{4} (0.01 0 -0.01 -0.03);
array exp{2} (0.02 0.0);
array O{4} (0 0.01 0.02 0.04);
do i=1 to 5;
	*do j=15 to 30 by 5;
		do k=1 to 2;
			do l=1 to 4;
			Location=i;
			Price=rand("Integer",1,4);
			Experience=k;
			Other=l;
			RR=sum(loc{i},pr{Price},exp{k},o{l},0.01);
			output;
			end;
		end;
	*end;
end;
keep Location Price Experience Other RR;
run;
proc print data=exp_design(obs=10);
run;
	
proc univariate data = exp_design;
histogram RR;
run;
/*Power function*/
proc glmpower data = exp_design; 
	*Three class variables; 
	class location experience other; 
	*Only main effects for now;
	model RR = location price experience other; 
	contrast 'Experience 2  vs. Experience 1' experience 1 -1;  
	contrast 'Location 2 vs. Location 1' location 0 1 -1 0 0;
	contrast 'Price 1 vs. Price 2' price 1 -1 0 0;
	contrast 'Other  1 vs. Other 2'  Other 1 0 0 -1; 
	POWER  /*THIS IS THE ONLY PART YOU NEED TO WORRY ABOUT*/
		alpha = 0.0125 
		STDDEV = 0.099 /*Mean Square Error = MSE^0.5*/
		NTOTAL = .  /*TOTAL OBSERVATIONS IN THE STUDY*/ 
		POWER  = .80;  
	run; 
quit; 
*I think 960 should be the sample size since it is the largest number with the power necessary.;
