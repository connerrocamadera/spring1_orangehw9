/*Dataset*/
data exp_design;
array loc{5} (0.04 0.04 0.04 0.04 0.04);
array pr{4} (0.01 0 -0.01 -0.03);
array exp{3} (0.01 0.01 0.03);
array O{4} (-0.005 0.015 0.01 0.02);
do i=1 to 5;
	do j=1 to 4;
		do k=1 to 3;
			do l=1 to 4;
			Location=i;
			Price=j;
			Experience=k;
			Other=l;
			RR=sum(loc{i},pr{j},exp{k},o{l},0.01);
			output;
			end;
		end;
	end;
end;
keep Location Price Experience Other RR;
run;
	
