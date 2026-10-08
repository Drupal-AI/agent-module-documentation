# Site Guardian Server Benchmarks — manual setup guide

**Site Guardian Server Benchmarks** (`sgd_server_benchmarks`) runs simple
performance benchmarks against your server on demand and surfaces the most recent
results on Drupal's Status report. It measures three things: raw PHP compute (math,
string handling, loops, if/else, a prime sieve, and N-Queens), database throughput
(connect, select and query timing plus a `SELECT BENCHMARK(...)`), and file I/O
(reading, writing, zipping and unzipping a small file in the temp directory). Every
result is timed in seconds.

Crucially, the benchmarks only run when an administrator visits the report page and
submits the form with a chosen iteration count. They deliberately tax the server,
so they are **never** run automatically during a normal page load, a Status report
render, or an API call. The last set of results is stored and then read back in two
places: it adds PHP/DB/I/O summary lines (with the last-run date and iteration
count) to the Status report, and it hands the full result set to the *Site Guardian*
API when that companion module is installed.

The module needs no configuration and has no settings of its own. The report page is
restricted to users with the *Administer site configuration* permission. If the
`mysqli` PHP extension is not present, the database benchmark is skipped gracefully
and you will see a notice instead of an error.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

The benchmark page sits at **Reports → Server benchmarks**
(`/admin/reports/server-benchmarks`).

## How to use it

Go to **Reports → Server benchmarks**, choose an iteration count, and submit the
form. A higher iteration count makes the run heavier but the measurement more
stable — useful when you want a reliable baseline. Once a run finishes, its results
are recorded and appear as summary lines on the **Status report**
(`/admin/reports/status`), so you can glance at server health at any time. Re-run
the benchmarks after an infrastructure change (a new server, a moved database tier,
a different disk) and compare the seconds to spot a regression or confirm an
improvement.
