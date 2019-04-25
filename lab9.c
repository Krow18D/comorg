#include <stdio.h>
#include <time.h>

void as(int i,int j,int k){
	asm("mov r4,%0; mov r5,%1;mov r6,%2;loop:;add r4,r4,r5;sub r6,r6,#1;cmp r6,#0;bne loop;":"+r"(i),"+r"(j),"+r"(k));
}
void c(int i,int j,int k){
	while(k!=0){
	i+=j;
	k--;
	}
}
int main ()
{
	int i=0,j=3,k=10;
	int x;
	time_t c_sec,as_sec,start,end;
	start = time(NULL);
	for(x=0;x<100000000;x++){
		c(i,j,k);
	}
	end = time(NULL);
	c_sec = end - start;
	printf("c = %ld sec\t", c_sec);
								
	start = time(NULL);
	for(x=0;x<100000000;x++){
		as(i,j,k);
	}
	end = time(NULL);
	as_sec=end-start;						
	printf("assembly = %ld sec\n", as_sec);
											
	printf("\tc-assembly = %ld sec\n",c_sec-as_sec);										
	 return(0);
} 
