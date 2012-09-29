#binomial simulation of genetic drift
#For BIS181
#Julin Maloof 
#Sept 27, 2012

#A function to simulate genetic drift
#use binomial sampling at each generation
#update allele frequencies at each genetation
dosim <- function(pops,size,generations,freq,returnTable=F) {
  size = size*2 #assume individuals are diploid but there are 2n chromosomes
  results <- matrix(nrow=generations+1,ncol=pops) #create matrix to hold results
  results[1,] <- freq               #populate first row with initial frequencies
  for (g in 2:(generations+1)) {    #loop through the generations
    results[g,] <- rbinom(pops,size,prob=results[g-1,])/size #calculate the next generations frequencies
  }
 print( matplot(results,type="l",lwd=2,main=paste("n = ",size,", generations = ",generations),ylab = " frequency", ylim = c(0,1)))
  if (returnTable) results#return results if requested
}

pops <- 10 #number of populations to simulate
size <- 5000 # number of individuals in each population
generations <- 50 #number of generations
frequency <- 0.5 #starting allele frequency

dosim(pops,size,generations,frequency)

size <- 100
dosim(pops,size,generations,frequency)
