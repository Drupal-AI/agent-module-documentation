# Raven: Sentry Integration — manual setup guide

**Raven** (`raven`) connects Drupal to [Sentry](https://sentry.io), the
application‑monitoring and error‑tracking platform. Once configured, it captures
uncaught exceptions, fatal PHP errors, JavaScript errors in the browser, Drush
command failures, and selected Drupal log messages, and sends them to your Sentry
project — complete with stack traces — so you find out about problems before your
users report them.

Raven goes well beyond error capture. It integrates with Sentry's performance
tracing and distributed tracing: with a sample rate set, it records a transaction
per request plus spans for HTTP‑client calls, database queries, and Twig template
rendering, and propagates trace headers to the hosts you list. It can emit
lightweight structured logs, monitor cron reliability with Sentry check‑ins,
relay browser events through a tunnel to evade ad blockers, and route
Content‑Security‑Policy violation reports to Sentry.

All of its settings live in a single config object, `raven.settings`, which Raven
adds to the **bottom of core's "Logging and errors" form** — the module has no
admin page of its own. The Sentry DSN, environment, and release can also come from
environment variables, which keeps secrets out of exported configuration.

This guide is written for a **human** setting the module up. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (including the
   Sentry SDK) and enable the module.
2. [Configuration](configuration/index.md) — set your DSN, choose which errors
   and logs to send, turn on tracing, and grant the permissions.

## Where it lives in the admin menu

Raven's settings are folded into core's form at **Configuration → Development →
Logging and errors** (`/admin/config/development/logging`) — look for the Raven /
Sentry section (`#edit-raven`).

## How to use it

Give Raven a Sentry DSN (from your Sentry project's settings), then choose what to
send: tick the log levels you want forwarded as events, optionally enable the
fatal‑error, JavaScript, and Drush error handlers, and — if you want performance
data — set a traces sample rate. Send a quick test event with
`drush raven:captureMessage` to confirm it works. Grant the JavaScript‑errors and
performance‑traces permissions to the roles whose browser activity you want to
monitor.
