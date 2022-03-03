#' @title Prepare Example Evaluation with p1 Data
#'
#' @description
#' The example data which are part of this package are copied into a working
#' directory. The example files can be used to run genetic evaluation
#'
#'
#' @param ps_work_dir working directory for example files
#' @param ps_source_dir source directory from where example files are copied
#' @param pb_force forcing copy by first deleting any existing working directory
#' @param pb_debug run in debugging mode and producing log messages
#' @param plogger logr logger object
#'
#' @export prepare_example_p1
prepare_example_p1 <- function(ps_work_dir   = file.path(tempdir(), "work_p1"),
                               ps_source_dir = system.file("extdata", "mix99", package = "qzwsmix99rt"),
                               pb_force      = FALSE,
                               pb_debug      = FALSE,
                               plogger       = NULL){
  # debugging message at the beginning
  if (pb_debug) {
    if (is.null(plogger)){
      lgr <- get_qzwsmix99rt_logger(ps_logfile = paste0(format(Sys.time(), "%Y%m%d%H%M%S"),
                                                    'prepare_example_p1.log',
                                                    collapse = ""),
                                ps_level = 'INFO')
    } else {
      lgr <- plogger
    }
    qzwsmix99rt_log_info(plogger = lgr, ps_caller = 'prepare_example_p1',
                   ps_msg = " Start of function prepare_example_p1 ... ")
    qzwsmix99rt_log_info(plogger = lgr, ps_caller = "prepare_example_p1",
                   ps_msg    = paste0(" * Working directory: ", ps_work_dir))
    qzwsmix99rt_log_info(plogger = lgr, ps_caller = "prepare_example_p1",
                   ps_msg    = paste0(" * Source directory: ", ps_source_dir))
  }

  # if working dir exists and pb_force is TRUE, remove existing version of working direcory
  if (fs::dir_exists(ps_work_dir) && pb_force) {
    if (pb_debug)
      qzwsmix99rt_log_info(plogger = lgr, ps_caller = "prepare_example_p1",
                       ps_msg    = paste0(" * Found work dir: ", ps_work_dir,
                                          " - option pb_force ==> delete work dir", collapse = ""))
    fs::dir_delete(path = ps_work_dir)

  }
  # if working directory does not exist, create it
  if (!fs::dir_exists(ps_work_dir)){
    # create working directory
    fs::dir_create(path = ps_work_dir)
    if (pb_debug)
      qzwsmix99rt_log_info(plogger = lgr, ps_caller = "prepare_example_p1",
                       ps_msg    = paste0(" * Work dir: ", ps_work_dir, " created ...", collapse = ""))

  }
  # copy content of source directory to working directory
  vec_example_files <- list.files(path = ps_source_dir, full.names = TRUE)
  if (pb_debug)
    qzwsmix99rt_log_info(plogger = lgr, ps_caller = "prepare_example_p1",
                     ps_msg    = paste0(" * Example files to be copied: ", paste0(vec_example_files, collapse = "\n"), "\n", collapse = ""))
  for (f in vec_example_files){
    bnf <- basename(f)
    s_trg_path <- file.path(ps_work_dir, bnf)
    if (!fs::file_exists(path = s_trg_path)){
      if (pb_debug)
        qzwsmix99rt_log_info(plogger = lgr, ps_caller = "prepare_example_p1",
                         ps_msg    = paste0(" * Copy file: ", bnf, collapse = ""))
      fs::file_copy(path = f, new_path = ps_work_dir)
    } else {
      if (pb_debug)
        qzwsmix99rt_log_info(plogger = lgr, ps_caller = "prepare_example_p1",
                         ps_msg    = paste0(" * Found File: ", bnf, collapse = ""))

    }
  }
  if (pb_debug){
    qzwsmix99rt_log_info(plogger = lgr, ps_caller = "prepare_example_p1",
                     ps_msg    = paste0(" * Returning workdir: ", ps_work_dir, collapse = ""))
    qzwsmix99rt_log_info(plogger = lgr, ps_caller = "prepare_example_p1",
                     ps_msg    = paste0(" * End of function prepare_example_p1 ... ", collapse = ""))

  }
  # return nothing
  return(ps_work_dir)
}

