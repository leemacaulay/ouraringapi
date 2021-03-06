% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ouraring_api.R
\name{ouraring_api}
\alias{ouraring_api}
\title{Retrieves data from Oura Ring API}
\usage{
ouraring_api(path = "userinfo", start = NULL, end = NULL, verbose = FALSE)
}
\arguments{
\item{path}{method to get data from (\code{"sleep"}, \code{"activity"}, \code{"readiness"} or leave blank for userinfo).}

\item{start}{(optional) first date to retrieve data. If not given, it will be set to one week ago.}

\item{end}{(optional) last date to retrieve data (inclusive). If not given, it will be set to the current date.}

\item{verbose}{(defaults to FALSE) return HTTP response as well as data in a list.}
}
\value{
A data.frame of sleep, activity, readiness or userinfo data.
}
\description{
Gets sleep, activity, readiness or userinfo data using \code{\link{ouraring_api}}.
}
\examples{
ouraring_api()
ouraring_api("sleep")
ouraring_api("activity", start="2021-02-19", end="2021-02-21")

}
