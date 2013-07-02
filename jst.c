/****************************************************
Implementasi Jaringan Syaraf Tiruan
Multi Layer Perceptron Dengan Algoritma Belajar Propagasi Balik
wangready.wordpress.com
*****************************************************/
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
// Declare your global variables here
#define JHneuron_val 9
#define JOneuron_val 3
int CP[JOneuron_val];
unsigned char JHneuron = JHneuron_val;
unsigned char JOneuron = JOneuron_val;
unsigned char kelas[JOneuron_val];
float W1[JOneuron_val][JHneuron_val] = {{-1.5311,   -0.5930,    0.4630,   -0.0598,	-1.2721,    0.4279,    0.2012,   -1.3415,	-0.5526}
										{0.0854,    0.7696,   -1.2435,    0.9705,	-0.7963,    0.5702,   -0.3937,    0.4599, 	 0.3311}
										{-0.6639,    0.8583,   -0.7434,   -0.8245,	 0.5300,   -0.1407,    0.6551,   -0.7644,	 0.8776}};
float W2[JHneuron_val][JOneuron_val]=  {{-0.9257,   -0.5259,    0.4244}
										{0.1466,   -1.3253,    1.0731}
										{1.7374,   -3.6121,   -0.4463}
									   {-6.3358,    5.6348,    1.6755}
									   {-6.3352,    6.2144,   -0.8763}
										{1.6680,   -6.1236,    0.3976}
										{1.7927,    5.7653,   -6.7571}
									   {-0.6205,   -1.8189,    1.6867}
									   {-0.6454,   -1.1958,    0.2055}};
float A1[JHneuron_val];
float A2[JOneuron_val];
float v=0;
void run_JST()
{
unsigned int i,j,jj;
                //CP = TestSet(pp,:)
                //A1 = [];
                //for ii=1:JHneuron,
                for(i=0;i<JHneuron;i++)
                {
                v=0;
                        //v = CP*W1(:,ii);
                        for(j=0;j<JOneuron;j++)
                        {
                                v += ((float)CP[j])*W1[j][i];
                        }
                        //A1= [A1 1/(1+exp(-v))];
                        A1[i] = 1/(1+(exp(-v)));
                //end
                }
                //A2 = [];
                //for jj=1:JOneuron,
                for(jj = 0;jj<JOneuron;jj++)
                {
                v=0;
                        //v = A1*W2(:,jj);
                        for(j=0;j<JHneuron;j++)
                        {
                                v += A1[j]*W2[j][jj];
                        }
                        //A2= [A2 1/(1+exp(-v))];
                        A2[jj] = 1/(1+(exp(-v)));
                //end
                }
                //%===================================================
                //%pemetaan A2 menjadi kelas keputusan
                //%jika A2 < 0.5 maka kelas = 0
                //%===================================================
                //for jj=1:JOneuron,
                for(jj = 0;jj<JOneuron;jj++)
                {
                        //if A2(jj) < 0.5,
                        if(A2[jj] < 0.5)
                        {
                                //Kelas = 0;
                                kelas[jj] = 0;
                        }
                        //else
                        else
                        {
                                //Kelas = 1;
                                kelas[jj] = 1;
                        //end
                        }
                }
}