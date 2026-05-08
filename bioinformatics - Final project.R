# Install required libraries
BiocManager::install(Biostrings)
BiocManager::install(DECIPHER)

# Load required libraries
library(Biostrings)
library(DECIPHER)

getwd()

# Read in megahit assembly results for each sample
allcontigs <- c()
  for(i in 1:6){
    contigs <- readDNAStringSet(paste0('C:/Users/katej/Downloads/kate/t', i, '_out/final.contigs.fa'))
    allcontigs <- c(allcontigs, contigs)
  }

# This loop outputs a list, so we flatten the list
allcontigs <- do.call(c, allcontigs)

# There are some small fragments of genomes in the assmebly; we are only going 
# to align the biggest parts (aka the ones that are bigger than 5 kbp; the 
# genome itself is around 18 kbp).
toalign <- allcontigs[which(nchar(allcontigs) > 5000)]
names(toalign) <- 1:length(toalign)

# Aligns the sequence and retrieve the html file of the sequence
alignment <- AlignSeqs(toalign)
BrowseSeqs(alignment, htmlFile = 'final_project.html')

# Plot the tree
tree <- Treeline(alignment)
plot(tree)

# Rearrange the tree using ML method
tree <- Treeline(alignment, method = 'ML', showPlot = TRUE)
