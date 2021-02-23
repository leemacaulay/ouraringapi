# Oura Ring API (unofficial)

## Work in progress - YMMV

An R package to get personal Oura Ring data [available via API](https://cloud.ouraring.com/oauth/developer). 

Requires a [Personal Access Token](https://cloud.ouraring.com/personal-access-tokens) to be set as an environment variable i.e. `Sys.setenv(OURARING_ACCESS_TOKEN="YOUR-ACCESS-TOKEN-HERE")`

### Usage

`ouraring_api(path = "userinfo", start = NULL, end = NULL, verbose = FALSE)`

### Arguments

`path`  method to get data from ("sleep", "activity", "readiness" or leave blank for userinfo).

`start` (optional) first date to retrieve data. If not given, it will be set to one week ago.

`end` (optional) last date to retrieve data (inclusive). If not given, it will be set to the current date.

`verbose` (defaults to FALSE) return HTTP response as well as data in a list.

### Examples 

```
ouraring_api()
ouraring_api("sleep")
ouraring_api("activity", start="2021-02-19", end="2021-02-21")
```
