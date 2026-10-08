# JSNLog — manual setup guide

**JSNLog** (`jsnlog`) forwards JavaScript log messages from the browser into
Drupal's own logging system (watchdog / the Recent log messages report). It
implements the JSNLog JavaScript library: when a JavaScript error occurs on the
front end, the event triggers an AJAX callback and the error is recorded in
watchdog, right alongside your server‑side log entries. Beyond automatic error
capture, your own front‑end code can send deliberate messages too — `JL().warn()`,
`JL().info()`, `JL().fatal()` — and they'll be logged according to the level you
configure.

This is a developer and site‑builder tool for getting visibility into client‑side
problems without wiring up an external service. A settings form lets you decide
when it's active, what it logs, which browsers and roles it applies to, and which
pages it runs on.

> **Privacy note:** Log messages come from real visitors' browsers and land in
> your watchdog log, potentially including error text and details about the pages
> and browsers involved. Treat the log as containing visitor information and keep
> your privacy and retention obligations in mind.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (plus the JSNLog
   JavaScript library) and enable the module.
2. [Configuration](configuration/index.md) — the settings form, option by option.

## Where it lives in the admin menu

Once enabled, the settings form sits at **Configuration → Development → JSNLog**
(`/admin/config/development/jsnlog`). Logged messages appear in **Reports → Recent
log messages** (watchdog).
