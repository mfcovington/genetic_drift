# binomial simulation of genetic drift
# For BIS181
# Julin Maloof 
# Sept 27, 2012

DoSim <- function(pops, size, generations, freq, out, returnTable = FALSE, writeTable = FALSE) {
  # Simulates genetic drift using binomial sampling at each generation
  # and updating allele frequencies at each genetation.
  #
  # Args:
  #   pops:        number of populations to simulate
  #   size:        number of individuals in each population
  #   generations: number of generations
  #   freq:        starting allele frequency
  #   out:         output directory
  #   returnTable:
  #
  # Returns:
  #
  size <- size * 2  # assume individuals are diploid but there are 2n chromosomes
  results <- matrix(nrow = generations + 1, ncol = pops)  # create matrix to hold results
  results[1, ] <- freq  # populate first row with initial frequencies
  for (g in 2:(generations + 1)) {  # loop through the generations
    results[g, ] <- rbinom(pops, size, prob = results[g - 1, ]) / size  # calculate the next generations frequencies
  }
  setwd("public")  # hard-coded for now, because not working any other way
  png("gen_drift.png")
  print(matplot(results,
                type = "l",
                lwd  = 2,
                main = paste("n = ", size, ", generations = ", generations),
                ylab = " frequency",
                ylim = c(0, 1)))
  dev.off()
  if (returnTable) results  # return results if requested
  if (writeTable) write.csv(results, file = "gen_drift.csv")
}
