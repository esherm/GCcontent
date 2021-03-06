source("intSiteRetriever/random_site.R")

reference <- get_reference_genome("hg19")

time_GC <- function() {
    sites <- lapply(c(10, 100, 1000, 10000, 100000), function(num) { 
        site <- get_random_positions(num, reference, 'f')
        site <- makeGRanges(site, soloStart=TRUE,
                    chromCol='chr', strandCol='strand', startCol='position')
        site
    })
    sapply(sites, function(site) { 
        window_size <- c(large=100) 
        GC_time <- system.time(
            getGCpercentage(site, "GC", window_size, reference))['user.self']
        list(length(site), GC_time)
    })
}
