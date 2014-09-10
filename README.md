rtools-ngrams
=============

R code for querying and parsing results from Google n-grams. This code is very much a work in progress and should only be used as a reference point for writing your own.

I've used these to query noun-verb co-occurrence patterns, with the final goal of creating pseudo-sentences with a range of probability values. Here's a brief overview:

1. run_queries.R: specify the server address or local path for your rotated ngrams database, then run this query. Variables not declared in this script are found in ngrams.RData.

2. preproc_query.R: basically adds line breaks to a continuous stream of text.

3. parse_query_output.R: counts the occurrences of target words in query results and saves these counts in some data frames.

4. calc_freq.R: co-occurrence counts and pointwise mutual information (PMI) for noun-verb pairs.

5. make_proto_sentences.R: put together sentences with desired 
