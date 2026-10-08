# Error Reporting — manual setup guide

**Error Reporting** (`error_reporting`) improves the way Drupal presents errors, so
they're easier to read and quicker to act on. Instead of the terse, sometimes
cryptic default messages, it renders errors in a cleaner, more organised layout and
surfaces more context about what went wrong — helpful whether you're a developer
tracking down a bug or a site administrator trying to understand a problem.

The module positions itself as an instant upgrade: it integrates into your Drupal
environment and improves error display **without requiring any additional
configuration**. Enable it and the improved presentation is in effect. It's a
development and diagnostics tool and supports Drupal 10 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

The module works as soon as it's enabled. There is a small settings page at
**Configuration → System → Error Reporting Settings**
(`/admin/config/system/error-reporting`) with a single **Enable custom error
reporting** checkbox — turn it off (and clear the cache) to fall back to Drupal's
default error handling, for example on production.

## A word on where to run it

Detailed, readable error output is exactly what you want in **development** — and
exactly what you *don't* want exposed to anonymous visitors on **production**, since
verbose errors can leak internal paths, queries and other implementation detail
(an information-disclosure risk). Treat this as a tool for development and staging
environments, and on production keep Drupal's core error-display setting
(**Configuration → Development → Logging and errors**) set so that error messages
are hidden from the public.
