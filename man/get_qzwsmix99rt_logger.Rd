% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/qzwsmix99rt_logger.R
\name{get_qzwsmix99rt_logger}
\alias{get_qzwsmix99rt_logger}
\title{Create log4r Logger for package}
\usage{
get_qzwsmix99rt_logger(ps_logfile = "qzwsmix99rt.log", ps_level = "FATAL")
}
\arguments{
\item{ps_logfile}{name of the logfile}

\item{ps_level}{logger level}
}
\value{
qzwsmix99rt_logger
}
\description{
Create log4r Logger for package
}
\examples{
\dontrun{
qzwsmix99rt_logger <- get_qzwsmix99rt_logger()
}
}
