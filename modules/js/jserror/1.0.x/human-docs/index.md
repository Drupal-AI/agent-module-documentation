# JSerror — manual setup guide

**JSerror** (`jserror`) records the JavaScript errors your visitors actually hit
and stores them in your own database. Code that works in your browser doesn't
always work in everyone's — errors that only show up on one browser, device, or
locale are hard to find because nobody reports them and you can't reproduce them
locally. JSerror catches those errors as they happen and puts them somewhere you
can look. Everything stays on your own server; no third‑party service sees your
users or the pages they were on.

It works by placing a tiny script at the very top of the page, ahead of every
other script, so it's already listening when the errors that break a page hardest
occur — the ones thrown while your own JavaScript is still loading. A second
reporting script loads after the page finishes and posts what was collected back
to the site in batches, so capturing errors never delays rendering. For each error
it records the message, script, line and column, the page, the browser and OS, the
stack trace when one is available, whether it happened before or after load, and
even unhandled promise rejections (which never reach the usual error handler).

You read the results at **Reports → Recent JavaScript errors**, where distinct
errors are grouped by message with the most frequent first — so one broken line
hit by ten thousand visitors is a single row with a count, not ten thousand rows.
A settings form makes it safe to leave switched on in production: sampling, per‑page
and per‑client caps, log trimming on cron, and an option to keep captured errors
out of the visitor's console.

> **Privacy note:** JSerror stores information about real visitors — the pages
> they were on, their browser and platform, and error messages/stack traces that
> can occasionally contain incidental data. Treat the error log as containing
> visitor information, restrict who can read it, and keep your data‑retention and
> privacy obligations in mind.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.
2. [Configuration](configuration/index.md) — the settings that make it safe to
   run on a live site, and where to read the reports.

## Where it lives in the admin menu

- **Settings:** **Configuration → Development → JSerror**.
- **Reports:** **Reports → Recent JavaScript errors**.
