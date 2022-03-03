


#' Run MiX99 Evaluation
#'
#' @description
#' Given a working directory with data file, pedigree file and clim file, the
#' mix99 program is executed using the system() function. The output is captured
#' and written to a log file
#'
#' @param ps_work_dir working directory containing data, pedigree and clim file
#' @param ps_log_file log file to which mix99 output is written
#'
#' @examples
#' \dontrun{
#' tdir <- prepare_example_p1()
#' run_mix99(ps_work_dir = tdir)
#' fs::dir_delete(tdir)
#' }
#' @export run_mix99
run_mix99 <- function(ps_work_dir,
                      ps_log_file = paste0(format(Sys.time(), "%Y%m%d%H%M%S"), "_mix99.log", collapse = "")){
  # determine clim file
  s_clm_file <- list.files(path = ps_work_dir, pattern = ".clm")
  # setup command
  s_mix99_cmd <- paste0("cd ", ps_work_dir, " && mix99i_pro ", s_clm_file, " && mix99s_pro -s ")
  vec_mix99_log <- system(command = s_mix99_cmd, intern = TRUE)
  # write log to log file
  cat(paste0(vec_mix99_log, collapse = "\n"), "\n", file = ps_log_file)

  return(invisible(NULL))
}
