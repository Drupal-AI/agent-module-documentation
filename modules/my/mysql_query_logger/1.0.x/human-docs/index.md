# MySQL Query Logger — manual setup guide

**MySQL Query Logger** (`mysql_query_logger`) is a development‑only tool that
records **every** database operation your Drupal site performs to a plaintext
log file. It ships a custom MySQL database *driver* — a thin wrapper around
Drupal's standard MySQL driver — that times and logs each `SELECT`, `INSERT`,
`UPDATE`, `DELETE`, `MERGE`/`UPSERT`, `TRUNCATE`, and transaction boundary. Each
log line records a timestamp, the operation type, how long it took, and a
JSON dump of the query text and its bound arguments.

It is the tool you reach for when you want to see exactly which queries run on a
given page request, hunt down slow or duplicate (N+1) queries, or confirm that a
cache layer is actually preventing database hits. Unlike most modules, it has
**no admin UI, no routes, and no permissions** — you turn it on by pointing a
database connection at its driver in `settings.php`, not by enabling anything in
the Drupal interface.

**Two important cautions.** First, this is strictly a development and debugging
aid — do **not** leave it active in production. The log grows quickly on a busy
site, and because it serializes the full query text plus every bound parameter,
it can capture sensitive values that pass through the database layer (password
hashes, session identifiers, private field data, and any secrets stored in
config). Treat the log file as sensitive, keep it out of any web‑accessible
directory, and remove the driver before you deploy. Second, while the custom
driver is active some Drush and configuration import/export utilities may behave
unexpectedly, since they assume the standard MySQL driver — switch back to the
normal driver for those tasks.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and wire the
   driver into your `settings.php`.

There is **no configuration page** and no settings form — everything is done in
`settings.php`, described in Installation.

## How it works, at a glance

Once the driver is active, every database call is timed against the parent MySQL
driver and a line is appended to your chosen log file. A log line looks like:

```
[2024-06-27 16:38:15] INSERT (0.003521 s): ["users",{"fields":{"name":"testuser"}}]
```

The log path defaults to `/tmp/mysql_query_logger.txt`; you can point it
anywhere writable with the connection's `output` option (see Installation). To
stop logging, remove or comment out the custom database settings so the
connection reverts to the standard `mysql` driver, then delete the log file.
