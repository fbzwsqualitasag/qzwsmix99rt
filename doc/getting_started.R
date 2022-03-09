## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
# library(qzwsmix99rt)
devtools::load_all()

## -----------------------------------------------------------------------------
test_dir <- prepare_example_p1()

## -----------------------------------------------------------------------------
list.files(path = test_dir)

## -----------------------------------------------------------------------------
s_log_file = file.path(test_dir, 
                       paste0(format(Sys.time(), "%Y%m%d%H%M%S"),
                              "_mix99.log", collapse = ""))
run_mix99(ps_work_dir = test_dir, ps_log_file = s_log_file)

## -----------------------------------------------------------------------------
list.files(path = test_dir)

## -----------------------------------------------------------------------------
con_log <- file(description = s_log_file)
vec_log <- readLines(con = con_log)
close(con = con_log)
head(vec_log, 10)

## -----------------------------------------------------------------------------
tail(vec_log)

## -----------------------------------------------------------------------------
fs::dir_delete(test_dir)

## -----------------------------------------------------------------------------
s_qm_path <- system.file("extdata", "qmsim", "p1_data_001.txt", package = "qzwsmix99rt")
(s_tmp_dir <- tempdir())
s_out_dir <- file.path(s_tmp_dir, 'mix99_work')
s_file_stem = paste0(format(Sys.time(), "%Y%m%d%H%M%S"),
                                                         "_mix99", collapse = "")
convert_qmsim_to_mix99(ps_qm_path = s_qm_path, 
                       ps_out_dir = s_out_dir, 
                       ps_file_stem = s_file_stem,
                       pl_vcmp      = list(genetic_variance = 0.1, residual_variance = 0.9))
list.files(path = s_out_dir)

## -----------------------------------------------------------------------------
s_data_path <- file.path(s_out_dir, paste(s_file_stem, ".dat", sep = ""))
con_data <- file(s_data_path)
vec_data <- readLines(con = con_data)
close(con = con_data)
head(vec_data)
tail(vec_data)

## -----------------------------------------------------------------------------
s_ped_path <- file.path(s_out_dir, paste(s_file_stem, ".ped", sep = ""))
con_ped <- file(s_ped_path)
vec_ped <- readLines(con = con_ped)
close(con = con_ped)
head(vec_ped)
tail(vec_ped)

## -----------------------------------------------------------------------------
s_var_path <- file.path(s_out_dir, paste(s_file_stem, ".var", sep = ""))
con_var <- file(s_var_path)
vec_var <- readLines(con = con_var)
close(con = con_var)
cat(paste0(vec_var, collapse = "\n"), "\n")

## -----------------------------------------------------------------------------
s_clm_path <- file.path(s_out_dir, paste(s_file_stem, ".clm", sep = ""))
con_clm <- file(s_clm_path)
vec_clm <- readLines(con = con_clm)
close(con = con_clm)
cat(paste0(vec_clm, collapse = "\n"), "\n")

## -----------------------------------------------------------------------------
s_mix99_log_path <- file.path(s_out_dir,
                              paste0(format(Sys.time(), "%Y%m%d%H%M%S"),
                                     "_mix99.log", collapse = ""))
run_mix99(ps_work_dir = s_out_dir, ps_log_file = s_mix99_log_path)

## -----------------------------------------------------------------------------
list.files(path = s_out_dir)

## -----------------------------------------------------------------------------
con_mix99_log <- file(s_mix99_log_path)
vec_mix99_log <- readLines(con = con_mix99_log)
close(con = con_mix99_log)
cat(paste0(vec_mix99_log, collapse = "\n"), "\n")

## -----------------------------------------------------------------------------
tbl_qm <- read_qmsim(ps_path = s_qm_path)

## -----------------------------------------------------------------------------
(tbl_data <- dplyr::select(tbl_qm, Progeny, Sex, Phen))

## -----------------------------------------------------------------------------
(tbl_data <- dplyr::mutate(tbl_data, Sex = dplyr::recode(Sex, `M` = 1, `F` = 2)))

## -----------------------------------------------------------------------------
pn_mvc       = -99999.0
(tbl_data <- dplyr::mutate(tbl_data, Phen = tidyr::replace_na(Phen, pn_mvc)))


## -----------------------------------------------------------------------------
fs::dir_delete(s_tmp_dir)

