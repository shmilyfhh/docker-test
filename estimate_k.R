#Use this file for the cloud-platform


args <- commandArgs(TRUE)
fileName <- args[1]
saveFileName <- ""
if (length(args)>1) { saveFileName <- args[2] }
require('scater')
d <- readRDS(fileName)
nGenes <- dim(d)[2]
thres <- round(nGenes*.05)
keepGeneInds <- which((rowSums(exprs(d)>0)>thres) & (rowSums(exprs(d)>0)<(nGenes - thres)))
#d <- d[keepGeneInds,]
y <- log2(1 + exprs(d))
x <- t(scale(y[keepGeneInds,]))
#Calculate the parameters for the Tracy-Widom distribution
p <- dim(x)[1];
n <- dim(x)[2];
muTW <- (sqrt(n-1) + sqrt(p))^2
sigmaTW <- (sqrt(n-1) + sqrt(p))*(1/sqrt(n-1) + 1/sqrt(p))^1/3

sigmaHatNaive <- x%*%t(x)
es <- eigen(sigmaHatNaive, only.values=T, symmetric=T)$values
k <- length(which(es>3*3*sigmaTW+muTW))
cat(paste0(fileName, "\t", toString(k)), file=saveFileName, append=T, sep="\n")

##################################################################


