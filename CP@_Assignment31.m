#include <iostream>
#include <chrono>
#include <random>
//Compuational Physics II William Jones- Comparing the RANLUX RNG and LCG
int main(){
//*********************     RANLUX   **********************
//starting clock time
auto begin1 = std::chrono::high_resolution_clock::now();
//creating the seed 
unsigned seed = chrono::system_clock::now().time_since_epoch().count;
//calling RANLUX generator
std::discard_block_engine<std::ranlux24_base, 223, 23> generator (seed);
//setting up the array
int rlx[10000];
//calling the generator to produce 10,000 numbers 
for (int i = 0; i <= 10000; i++){
  rlx[i] = generator();
}
//ends counter
auto end1 = std::chrono::high_resolution_clock::now();
//figures out the time elapsed
auto elapsed1 = std::chrono::duration_cast<std::chrono::nanoseconds>(end1 - begin1);
//prints statement 
printf("Execution Time for the RANLUX: $.6f seconds\n", elapsed1.count() * 1e-9);
//************************************************************
//starts counter 
auto begin2 = std::chrono::high_resolution_clock::now();
//park miller parameters
int a = pow(7, 5);
int c = 0;
int m = pow(2, 31) - 1;
//setting the array
int lcg[10000];
for (int i = 0; i <= 10000; i++){
  //had problems with seed not being random so calling it each time creates a different seed value
  unsigned seed1 = chrono::system_clock::now().time_since_spoch().count();
  //LCG FORMULA
  lcg[i] = (a*seed1+c)% m;
}
auto end2 = std::chrono::high_resolution_clock::now();
//calculates time elapsed
auto elapsed2 = std::chrono::duration_cast<std::chrono::nanoseconds>(end2 - begin2);
//prints statement
printf("Execution Time for LCG from 2.2: %.6f seconds\n", elapsed.count() * 1e-9);
return 0;
}
