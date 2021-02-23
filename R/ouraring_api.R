# ua <- user_agent("user_agent")

ouraring_pat <- function() {
  pat <- Sys.getenv('OURARING_ACCESS_TOKEN')
  if (identical(pat, "")) {
    stop("Please set env var OURARING_ACCESS_TOKEN to your Oura Ring personal access token (https://cloud.ouraring.com/personal-access-tokens)",
         call. = FALSE)
  }

  pat
}

#' Retrieves data from Oura Ring API
#'
#' Gets sleep, activity, readiness or userinfo data using \code{\link{ouraring_api}}.
#'
#' @param path method to get data from (\code{"sleep"}, \code{"activity"}, \code{"readiness"} or leave blank for userinfo).
#' @param start (optional) first date to retrieve data. If not given, it will be set to one week ago.
#' @param end (optional) last date to retrieve data (inclusive). If not given, it will be set to the current date.
#' @param verbose (defaults to FALSE) return HTTP response as well as data in a list.
#'
#' @return A data.frame of sleep, activity, readiness or userinfo data.
#'
#' @examples
#' ouraring_api()
#' ouraring_api("sleep")
#' ouraring_api("activity", start="2021-02-19", end="2021-02-21")
#'
#' @export
#'
ouraring_api <- function(path = "userinfo", start = NULL, end = NULL, verbose = FALSE) {
  url <- httr::modify_url("https://api.ouraring.com/v1/", path = c("v1", path))
  resp <- httr::GET(url, query = list(access_token = ouraring_pat(),
                                start = start,
                                end = end))
  if (httr::http_type(resp) != "application/json") {
    stop("Oura RingAPI did not return json", call. = FALSE)
  }

  parsed <- jsonlite::fromJSON(httr::content(resp, "text"), simplifyDataFrame = TRUE)

  if (httr::http_error(resp)) {
    stop(
      sprintf(
        "Oura Ring API request failed [%s]\n%s\n<%s>",
        httr::status_code(resp),
        parsed$title,
        parsed$detail
      ),
      call. = FALSE
    )
  }

  if (isTRUE(verbose) && path == "userinfo") {
    result <- list(
        content = parsed,
        path = path,
        response = resp
      )
  } else if ( path == "userinfo" ) {
    result <- parsed
  } else if ( isTRUE(verbose) ) {
    result <- list(
        content = parsed[[path]],
        path = path,
        response = resp
      )
  } else {
    result <- parsed[[path]]
  }

return(result)

}
