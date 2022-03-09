
# -- QMSim Read Function -------------------------------------------------------
#' Read Output File of QMSim
#'
#' @param ps_path path to QMSim output file
#'
#' @return tibble with QMSim output
#' @export read_qmsim
#'
#' @examples
#' s_qmsim_path <- system.file("extdata", "qmsim", "p1_data_001.txt", package = "qzwsmix99rt")
#' tbl_qmsim <- read_qmsim(ps_path = s_qmsim_path)
read_qmsim <- function(ps_path){
  # check existence of ps_path
  if (!file.exists(ps_path)){
    stop("*** ERROR: Cannot find qmsim output file")
  }
  # read the qmsim output file
  n_nr_lines <- as.integer(system(command = paste0("wc -l ", ps_path, " | cut -d ' ' -f1", collapse = ""), intern = TRUE))
  # read qmsim data
  tbl_qm_data <- readr::read_table(file = ps_path, na = '---', guess_max = n_nr_lines)

  # return
  return(tbl_qm_data)
}


# -- Conversion Functions ------------------------------------------------------


#' Convert QMSim Output to MiX99 Input
#'
#' @param ptbl_qm tibble with QMSim output
#' @param ps_qm_path QMSim output file
#' @param ps_out_dir Output directory for Mix99 files
#' @param ps_file_stem File stem for Mix99 files
#' @param pn_mvc numeric missing value code
#'
#' @export convert_qmsim_to_mix99
#'
#' @examples
#' s_qm_path <- system.file("extdata", "qmsim", "p1_data_001.txt", package = "qzwsmix99rt")
#' s_tmp_dir <- tempdir()
#' convert_qmsim_to_mix99(ps_qm_path = s_qm_path, ps_out_dir = file.path(s_tmp_dir, 'mix99_work'))
#' fs::dir_delete(s_tmp_dir)
convert_qmsim_to_mix99 <- function(ptbl_qm      = NULL,
                                   ps_qm_path   = NULL,
                                   ps_out_dir   = '.',
                                   ps_file_stem = paste0(format(Sys.time(), "%Y%m%d%H%M%S"),
                                                         "_mix99", collapse = ""),
                                   pn_mvc       = -99999.0,
                                   pl_vcmp){
  # get QMSim into tibble
  tbl_qm <- ptbl_qm
  if (is.null(tbl_qm))
    tbl_qm <- read_qmsim(ps_path = ps_qm_path)

  # data input file
  if (!dir.exists(ps_out_dir)) dir.create(path = ps_out_dir, recursive = TRUE)
  s_data_path <- file.path(ps_out_dir, paste(ps_file_stem, '.dat', sep = ""))
  tbl_data <- dplyr::select(tbl_qm, Progeny, Sex, Phen)
  tbl_data <- dplyr::mutate(tbl_data, Sex = dplyr::recode(Sex, `M` = 1, `F` = 2))
  tbl_data <- dplyr::mutate(tbl_data, Phen = tidyr::replace_na(Phen, pn_mvc))
  readr::write_delim(tbl_data, file = s_data_path, delim = " ", col_names = FALSE)

  # pedigree input file
  s_ped_path <- file.path(ps_out_dir, paste(ps_file_stem, '.ped', sep = ""))
  tbl_ped <- dplyr::select(tbl_qm, Progeny, Sire, Dam)
  readr::write_delim(tbl_ped, file = s_ped_path, delim = " ", col_names = FALSE)

  # var file
  s_var_path <- file.path(ps_out_dir, paste(ps_file_stem, '.var', sep = ""))
  cat("1 1 1 ", pl_vcmp$genetic_variance, "\n",
      "2 1 1 ", pl_vcmp$residual_variance, "\n", file = s_var_path, sep = "")

  # clim file
  s_clim_path <- file.path(ps_out_dir, paste(ps_file_stem, '.clm', sep = ""))
  cat("DATAFILE", s_data_path, "\n", file = s_clim_path)
  cat("MISSING", pn_mvc, "\n", file = s_clim_path, append = TRUE)
  cat("INTEGER animal sex\n", file = s_clim_path, append = TRUE)
  cat("REAL      phen\n", file = s_clim_path, append = TRUE)
  cat("PEDFILE", s_ped_path, "\n", file = s_clim_path, append = TRUE)
  cat("PEDIGREE  animal am\n", file = s_clim_path, append = TRUE)
  cat("PARFILE", s_var_path, "\n", file = s_clim_path, append = TRUE)
  cat("PRECON b f\n", file = s_clim_path, append = TRUE)
  cat("MODEL\n", file = s_clim_path, append = TRUE)
  cat("  phen = sex animal\n", file = s_clim_path, append = TRUE)

  return(invisible(NULL))
}
