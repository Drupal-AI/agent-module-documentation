# Defer JS — manual setup guide

**Defer JS** (`deferjs`) helps you lazy‑load JavaScript so that non‑critical
scripts are deferred until the page has loaded and rendered, rather than blocking
the initial paint. It is a front‑end performance module, built on the tiny
[deferjs](https://github.com/shinsenter/defer.js) library.

Render‑blocking JavaScript is one of the most common reasons a page feels slow:
the browser has to fetch and execute scripts before it can finish drawing the
page, which inflates metrics like Total Blocking Time. Defer JS delays those
scripts so the DOM can render first, then loads and runs the JS afterwards. The
module automates the deferring of JS files specifically; the underlying library
can also delay CSS and do other lazy‑loading tricks, which you can explore from
the library's own documentation.

Because deferring changes *when* scripts run, it is worth testing after you
enable it: some scripts depend on load order or on running at a particular point
in the page lifecycle. Turn it on, then click through your site's interactive
features and confirm everything still behaves as expected before shipping to
production.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the settings form and how to tune
   the deferring behavior.

## Where it lives in the admin menu

Its settings form is at **Configuration → Development → Performance → Defer JS**
(`/admin/config/performance/deferjs`). Adjust the options there to suit your site
after installing.
