# Raven: Sentry Integration — manual setup guide

**Raven** (`raven`) connects your Drupal site to **Sentry**, the application
monitoring and error-tracking platform. Once configured, it sends log events and
errors to Sentry with full stack traces and customizable metadata — including the
kinds of failures Drupal normally can't log itself, such as fatal PHP errors
(memory-limit exceeded), fatal JavaScript errors, and exceptions thrown by Drush
commands.

Beyond error capture, Raven can send Drupal log (watchdog) messages, JavaScript
exceptions from the browser, Content Security Policy reports, and Monitoring sensor
changes. It also integrates with Sentry **performance tracing** (transactions and
spans for HTTP requests, database queries, rendered Twig templates, and more),
optional CPU **profiling** (with the Excimer PHP extension), release health
monitoring, cron monitoring, and a user-feedback dialog. You can use Sentry's
hosted service or self-host Sentry (or lighter backends like GlitchTip or
Bugsink).

The essential setup is small: install the module (which pulls in the Sentry PHP
SDK), then set your Sentry **DSN** and turn on the handlers/levels you care about.
**Nothing is sent to Sentry until a DSN is configured and a handler or log level is
enabled**, so the module is inert until you switch it on. Because a DSN is a
credential, Raven supports supplying it (and the environment/release tags) through
environment variables so it stays out of exported configuration.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and Sentry SDK with
   Composer and enable it.
2. [Configuration](configuration/index.md) — set the DSN, choose which events and
   traces to send, and keep the DSN out of config.

## Where it lives in the admin menu

Raven has no settings page of its own — instead it injects its fields into core's
**Logging and errors** form at **Configuration → Development → Logging and errors**
(`/admin/config/development/logging`, route `system.logging_settings`), in a
"Raven" section. Everything is stored in the single `raven.settings` config object.

## How to use it

Set your DSN, enable the handlers and log levels you want (for example, capture
errors and above as events), optionally turn on performance tracing with a sample
rate, and save. From then on, matching events flow to your Sentry project where you
can search, group, and alert on them. Raven also provides Drush commands and a CSP
reporting handler for the CSP module.
