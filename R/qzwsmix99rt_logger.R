### #
### #
### #
### #   Purpose:   Functions Related to Logging
### #   started:   2019-10-03 (pvr)
### #
### # ############################################## ###

#' @title Create log4r Logger for package
#'
#' @param ps_logfile name of the logfile
#' @param ps_level logger level
#'
#' @return qzwsmix99rt_logger
#' @export get_qzwsmix99rt_logger
#'
#' @examples
#' \dontrun{
#' qzwsmix99rt_logger <- get_qzwsmix99rt_logger()
#' }
get_qzwsmix99rt_logger <- function(ps_logfile = 'qzwsmix99rt.log', ps_level = 'FATAL'){
  qzwsmix99rt_logger <- log4r::create.logger(logfile = ps_logfile, level = ps_level)
  return(qzwsmix99rt_logger)
}


#' @title Wrapper for log4r info
#'
#' @param plogger log4r logger object
#' @param ps_caller function from which we are called
#' @param ps_msg logging message
#'
#' @export qzwsmix99rt_log_info
#'
#' @examples
#' \dontrun{
#' qzwsmix99rt_logger <- get_qzwsmix99rt_logger()
#' qzwsmix99rt_log_level(qzwsmix99rt_logger, 'INFO')
#' qzwsmix99rt_log_info(qzwsmix99rt_logger, 'Examples', 'test message')
#' }
qzwsmix99rt_log_info <- function(plogger, ps_caller, ps_msg){
  s_msg <- paste0(ps_caller, ' -- ', ps_msg, collapse = '')
  log4r::info(logger = plogger, message = s_msg)
}


#' @title Wrapper for log4r debug
#'
#' @param plogger log4r logger object
#' @param ps_caller function from which we are called
#' @param ps_msg logging message
#'
#' @export qzwsmix99rt_log_debug
#'
#' @examples
#' \dontrun{
#' qzwsmix99rt_logger <- get_qzwsmix99rt_logger()
#' qzwsmix99rt_log_level(qzwsmix99rt_logger, 'DEBUG')
#' qzwsmix99rt_log_debug(qzwsmix99rt_logger, 'Examples', 'test message')
#' }
qzwsmix99rt_log_debug <- function(plogger, ps_caller, ps_msg){
  s_msg <- paste0(ps_caller, ' -- ', ps_msg, collapse = '')
  log4r::debug(logger = plogger, message = s_msg)
}


#' @title Wrapper for log4r warn
#'
#' @param plogger log4r logger object
#' @param ps_caller function from which we are called
#' @param ps_msg logging message
#'
#' @export qzwsmix99rt_log_warn
#'
#' @examples
#' \dontrun{
#' qzwsmix99rt_logger <- get_qzwsmix99rt_logger()
#' qzwsmix99rt_log_level(qzwsmix99rt_logger, 'WARN')
#' qzwsmix99rt_log_warn(qzwsmix99rt_logger, 'Examples', 'test message')
#' }
qzwsmix99rt_log_warn <- function(plogger, ps_caller, ps_msg){
  s_msg <- paste0(ps_caller, ' -- ', ps_msg, collapse = '')
  log4r::warn(logger = plogger, message = s_msg)
}


#' @title Wrapper for log4r error
#'
#' @param plogger log4r logger object
#' @param ps_caller function from which we are called
#' @param ps_msg logging message
#'
#' @export qzwsmix99rt_log_error
#'
#' @examples
#' \dontrun{
#' qzwsmix99rt_logger <- get_qzwsmix99rt_logger()
#' qzwsmix99rt_log_level(qzwsmix99rt_logger, 'ERROR')
#' qzwsmix99rt_log_error(qzwsmix99rt_logger, 'Examples', 'test message')
#' }
qzwsmix99rt_log_error <- function(plogger, ps_caller, ps_msg){
  s_msg <- paste0(ps_caller, ' -- ', ps_msg, collapse = '')
  log4r::error(logger = plogger, message = s_msg)
}


#' @title Wrapper for log4r fatal
#'
#' @param plogger log4r logger object
#' @param ps_caller function from which we are called
#' @param ps_msg logging message
#'
#' @export qzwsmix99rt_log_fatal
#'
#' @examples
#' \dontrun{
#' qzwsmix99rt_logger <- get_qzwsmix99rt_logger()
#' qzwsmix99rt_log_level(qzwsmix99rt_logger, 'FATAL')
#' qzwsmix99rt_log_fatal(qzwsmix99rt_logger, 'Examples', 'test message')
#' }
qzwsmix99rt_log_fatal <- function(plogger, ps_caller, ps_msg){
  s_msg <- paste0(ps_caller, ' -- ', ps_msg, collapse = '')
  log4r::fatal(logger = plogger, message = s_msg)
}


#' @title Wrapper to set the level of a logger
#'
#' @param plogger log4r logger object
#' @param ps_level new level of plogger
#'
#' @export qzwsmix99rt_log_level
#'
#' @examples
#' \dontrun{
#' qzwsmix99rt_logger <- get_qzwsmix99rt_logger()
#' qzwsmix99rt_log_level(qzwsmix99rt_logger, 'INFO')
#' }
qzwsmix99rt_log_level <- function(plogger, ps_level = c('DEBUG', 'INFO', 'WARN', 'ERROR', 'FATAL')){
  if (!missing(ps_level) & length(ps_level) > 1) stop(" *** ERROR in level(): only one 'level' allowed.")
  ps_level <- match.arg(ps_level)
  log4r::level(plogger) <- ps_level
}
