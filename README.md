Code accompanying the Kershenbaum *et al.* (2025) paper 'Gene conversion limits the cost of asexuality in somatically immortal worms' (add DOI). The folders include:
- **asex_with_conversion**: a model of obligate / facultative asexual reproduction with gene conversion (here, an equivalent model of gene conversion is implemented during sexual reproduction). The simulations were run within a simple Snakemake pipeline.
- **sex_with_crossovers**: a model of sexual reproduction with crossovers.
  
Both models are written in SLiM4, implementing Wright-Fisher-like dynamics using a nonWF model (see chapter 15.13 of the SLiM manual; https://github.com/MesserLab/SLiM/releases/download/v4.3/SLiM_Manual.pdf).
