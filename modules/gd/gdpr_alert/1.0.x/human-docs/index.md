# GDPR Alert — manual setup guide

**GDPR Alert** (`gdpr_alert`) displays a configurable GDPR consent alert bar that
informs visitors about your data and cookie usage and records their
acknowledgement in a cookie (using the JS Cookie library). You can place the bar at
the top or bottom of the page, decide whether it can be dismissed, set how long the
acknowledgement cookie lasts, and provide different alert text per language.

The module ships with base styling, but you'll almost certainly want to add some
CSS of your own to match your theme.

> **Please read this — a banner is not compliance.** GDPR Alert is a *consent
> presentation* tool. It shows a notice and remembers that the visitor saw it, but
> it does **not** stop tracking or cookie‑setting scripts from firing. Real
> compliance depends on you actually gating those trackers behind consent so they
> don't run before the visitor accepts. Treat this module as the visible half of
> the job, not the whole of it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and the JS Cookie
   dependency with Composer, then enable it.
2. [Configuration](configuration/index.md) — write the alert message and set its
   position, dismissibility, and cookie lifetime.

## Where it lives in the admin menu

The settings form is at `/admin/config/gdpr-alert`. After you save, the render
cache is flushed automatically.
