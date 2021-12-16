readPLINK = function(prefix){

  # INDS
  INDS = fread(paste(prefix, ".fam", sep = "")) %>%
    as_tibble() %>%
    rename(fam = V1, id = V2, pat = V3, mat = V4, sex = V5, pheno = V6)
  INDS$pat[INDS$pat == 0] = NA
  INDS$mat[INDS$mat == 0] = NA
  INDS$sex[INDS$sex == 0] = NA
  INDS$pheno[INDS$pheno == -9] = NA

  # SNPS
  SNPS = fread(paste(prefix, ".bim", sep = "")) %>%
    as_tibble() %>%
    rename(chr = V1, id = V2, posg = V3, pos = V4, ref = V5, alt = V6)

  # GENO
  GENO = t(read_bed(prefix, names_loci = SNPS$id, names_ind = INDS$id))

  # return results
  return(list(GENO = GENO, SNPS = SNPS, INDS = INDS))
}
