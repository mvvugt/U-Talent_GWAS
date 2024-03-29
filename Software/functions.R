## Script information ---------------------------
##
## Script name: functions.R
##
## Purpose of script: Provide functions oftenly used in R to prevent confusion
## in the scripts.
##
## Author: M. van Vugt
##
## Date Created: 2021-06-11
##
## Copyright (c) M. van Vugt, 2021
## Email: m.vanvugt-2@umcutrecht.nl
##

## Options ---------------------------

options(scipen = 6, digits = 4) # view outputs in non-scientific notation

## Loading packages ---------------------------


## Loading functions ---------------------------

# QQ-plots ----------------------------------------------------------------

plotQQ <- function(z, color, cex){
  p <- 2*pnorm(-abs(z))
  p <- sort(p)
  expected <- c(1:length(p))
  lobs <- -(log10(p))
  lexp <- -(log10(expected / (length(expected)+1)))

  # plots all points with p < 1e-3
  p_sig = subset(p,p<0.001)
  points(lexp[1:length(p_sig)], lobs[1:length(p_sig)], pch=23, cex=.3, col=color, bg=color)
  
  # samples 5000 points from p > 1e-3
  n=5001
  i<- c(length(p)- c(0,round(log(2:(n-1))/log(n)*length(p))),1)
  lobs_bottom=subset(lobs[i],lobs[i] <= 3)
  lexp_bottom=lexp[i[1:length(lobs_bottom)]]
  points(lexp_bottom, lobs_bottom, pch=23, cex=cex, col=color, bg=color)
}

plotQQ2 <- function(z,color,cex){
  p <- 2*pnorm(-abs(z))
  p <- sort(p)
  expected <- c(1:length(p))
  lobs <- -(log10(p))
  lexp <- -(log10(expected / (length(expected)+1)))
  
  # plots all points
  points(lexp[1:length(p)], lobs[1:length(p)], pch=23, cex=.3, col=color, bg=color)
  
}

QQ <- function(data) {
  z = qnorm(data$P/2)
  z_lo00 = subset(data, data$MAF < 0.01 )
  z_lo01 = subset(data, data$MAF > 0.20 )
  z_lo02 = subset(data, data$MAF < 0.20 & data$MAF > 0.05 )
  z_lo03 = subset(data, data$MAF < 0.05 & data$MAF > 0.01 )
  
  z_lo0 = qnorm(z_lo00$P/2)
  z_lo1 = qnorm(z_lo01$P/2)
  z_lo2 = qnorm(z_lo02$P/2)
  z_lo3 = qnorm(z_lo03$P/2)
  
  # Calculate lambda
  lambda = round(median(z^2) / qchisq(0.5, df = 1), 3)
  l0 = round(median(z_lo0^2) / qchisq(0.5, df = 1), 3)
  l1 = round(median(z_lo1^2) / qchisq(0.5, df = 1), 3)
  l2 = round(median(z_lo2^2) / qchisq(0.5, df = 1), 3)
  l3 = round(median(z_lo3^2) / qchisq(0.5, df = 1), 3)
  
  # Plot axes and null distribution
  plot(c(0, 8), c(0, 8), col = "red", lwd = 3, type = "l",
       xlab = "Expected Distribution (-log10 of P value)",
       ylab = "Observed Distribution (-log10 of P value)",
       xlim = c(0, 8), ylim = c(0, 8), las = 1, 
       xaxs = "i", yaxs = "i", bty = "l",
       main = c(substitute(paste("QQ plot: ",lambda," = ", lam),
                           list(lam = lambda)), expression()))
  
  # Plot data
  plotQQ(z, "black", 0.4);
  plotQQ(z_lo1, "olivedrab1", 0.3);
  plotQQ(z_lo2, "orange", 0.3);
  plotQQ(z_lo3, "lightskyblue", 0.3);
  plotQQ(z_lo0, "purple", 0.3);
  
  # Provide legend
  legend(.25,8,legend = c("Expected (null)","Observed",
                        substitute(paste("MAF > 0.20 [", lambda," = ", lam, "]"), 
                                   list(lam = l1)), expression(),
                        substitute(paste("0.05 < MAF < 0.20 [", lambda," = ", lam, "]"),
                                   list(lam = l2)), expression(),
                        substitute(paste("0.01 MAF < 0.05 [", lambda," = ", lam, "]"),
                                   list(lam = l3)), expression(),
                        substitute(paste("MAF < 0.01 [", lambda," = ", lam, "]"),
                                   list(lam = l0)), expression()),
         pch = c((vector("numeric",6)+1)*23), 
         cex = c((vector("numeric",6)+0.8)), 
         pt.bg = c("red","black","olivedrab1","orange","lightskyblue","purple"))
  
}

manhattan <- function(data) {
  data$BP <- data$BP/100
  offset <- 0
  color = "red"
  pos <- c()
  pos_odd <- c()
  p_odd <- c()
  pos_even <- c()
  p_even <- c()
  xAT <- c()
  xE <- c(0)
  xO <- c(0)
  xEND <- c(0)
  cols<-rainbow(22)
  
  maxX = 0
  for (i in 1:22){
    pos_i <- subset(data$BP, data$CHR == i)
    maxX = maxX + max(pos_i)
  }
  
  p1 <- subset(data, data$P >= 1e-7)
  p2 <- subset(data, data$P < 1e-7)
  
  for (i in 1:22){
    pos_i <- subset(p1$BP, p1$CHR == i)
    p_i <- subset(p1$P, p1$CHR == i)
    
    pos_j <- subset(p2$BP, p2$CHR == i)
    p_j <- subset(p2$P, p2$CHR == i)
    
    
    if (i == 1){
      plot(pos_i, -log10(p_i), pch = 15, cex = .5, col = "#1E90FF",
           ylim = c(0,15), xlim = c(0,maxX), xlab = "Chromosome" ,ylab = "",
           main = paste("Genome-wide results",sep = ""), axes = F)
      points(pos_j + offset, -log10(p_j), pch = 18, cex = 1, 
             col = "#1E90FF", axes = F)
    }
    if (i %% 2 == 0){
      points(pos_i + offset,-log10(p_i), pch = 15, cex = .5, 
             col = "#104E8B",axes = F)
      points(pos_j + offset,-log10(p_j), pch = 18, cex = 1, 
             col = "#104E8B",axes = F)
    }
    if (i %% 2 == 1){
      points(pos_i + offset,-log10(p_i), pch = 15, cex = .5, 
             col = "#1E90FF",axes = F)
      points(pos_j + offset,-log10(p_j), pch = 18, cex = 1, 
             col = "#1E90FF",axes = F)
    }
    
    if (color == "red"){
      color <- "blue"
      pos_odd <- c(pos_odd, pos_i + offset)
      p_odd<- c(p_odd, p_i)
      xO <- c(xO, (max(pos_i) + min(pos_i))/2 + offset)
    } else {
      color <- "red"
      pos_even <- c(pos_even, pos_i + offset)
      p_even <- c(p_even, p_i)
      xE <- c(xE, (max(pos_i) + min(pos_i))/2 + offset)
    }
    
    pos <- c(pos, pos_i + offset)
    xAT <- c(xAT, (max(pos_i) + min(pos_i))/2 + offset)
    xEND <- c(xEND, max(pos_i) + offset)
    
    offset <- max(pos)
  }
  
  lines(c(min(pos), max(pos)), c(7,7), lty = "dashed", lwd = 1, col = "black")
  mtext("-log10 of P value", side = 2, at = 7.5, line = 1)
  for (i in 1:22) {
    axis(1, at = xAT[i], labels = c(i), cex = 1, cex.axis = .8, tick = FALSE)
  }
  
  axis(1, at = xEND, 
       labels = rep("", 23), tick = TRUE, cex.axis = 0.5, cex = .5)
  axis(2, at = seq(0, 40, 5), labels = seq(0, 40, 5), pos = c(0,0), las = 1, 
       cex = 1, cex.axis = .8)
  
}
