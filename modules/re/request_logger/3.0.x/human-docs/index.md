# Request Logger — manual setup guide

**Request Logger** (`request_logger`) writes **one log entry per HTTP
request/response** to Drupal's logger, recording useful metadata about each
request (method, path, query string, and optionally headers) and its response
(status code, generation duration in milliseconds, size, memory usage, cache
hit/miss, and optionally headers). It works **out of the box** — install it and
every request to the site gets a log entry — and it is invaluable for performance
monitoring, cache-hit-rate tracking, and building site analytics from your logs.

Under the hood it installs an HTTP middleware that assigns each request a **UUID**,
lets the request run, then logs a message plus structured `metadata` to the
`request_logger` logger channel. It can also stamp that request UUID onto *other*
log entries, so all log lines produced during one request can be correlated. On
the settings page you choose exactly which request and response items to capture.

Because entries go through Drupal's logger channel, **where they end up and who can
read them depends on which logger backends you have enabled** — for example the
core Database Logging (dblog) module stores them in the `watchdog` table, readable
by users with the **Access site reports** permission; Syslog sends them to the OS.
An optional submodule, **Request Logger Reports** (`request_logger_reports`), adds
report pages for browsing the logged requests. It supports Drupal 11.

> **Privacy warning — there is no redaction.** The default settings do **not**
> capture request or response headers, which is the safe choice. If an admin
> enables the **Headers** request item, it records every request header verbatim —
> including `Authorization` and `Cookie` (session cookies, bearer tokens,
> basic-auth). The response **Headers** item records `Set-Cookie`. The
> **query-string** item is on by default and can capture secrets passed in query
> strings (reset tokens, API keys). Enable headers only when you truly need them,
> preferably off production, and restrict who can read the logs.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and optionally the reports submodule.
2. [Configuration](configuration/index.md) — the settings form, field by field,
   and where the logged data ends up.

## Where it lives in the admin menu

Request Logger's settings form sits at **Configuration → Development → Request
Logger** (`/admin/config/development/request_logger`), behind the **Administer
site configuration** permission. Logged entries appear wherever your logger
backends surface them (e.g. **Reports → Recent log messages** for dblog).
