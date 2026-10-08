# Syslog Watcher — manual setup guide

**Syslog Watcher** (`syslog_watcher`) gives you a dblog-style *Recent log messages*
screen for sites that log to **Syslog** instead of the database. When you turn off
core's Database Logging (dblog) and rely on Syslog, you normally lose the in-browser
log view; Syslog Watcher recovers it by reading the configured syslog file, parsing
each line, and rendering a paginated table with a detail page for every entry.

It adds two admin pages: an overview table at `/admin/reports/syslog-watcher` and a
per-line detail page at `/admin/reports/syslog-watcher/line/{line_number}` that shows
the raw entry. Both are gated by the core **Access site reports**
(`access site reports`) permission — a restricted admin permission — so the log
contents are not exposed to anonymous visitors. The module depends on core's Syslog
module. It ships no submodules.

Rather than adding a settings screen of its own, Syslog Watcher **reuses Drupal's
core logging settings**, so you tell it which file to read (and, if needed, the field
separator) on the standard *Logging and errors* page. It works once you point it at
the right file — see [Configuration](configuration/index.md). The module is covered
by the security advisory policy.

This guide is written for a **human** setting the module up through the admin UI. If
you are an AI coding agent, read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — point the viewer at your syslog file
   (and separator) on the core Logging and errors page.

## Where it lives in the admin menu

The report itself lives under **Reports → Syslog Watcher**
(`/admin/reports/syslog-watcher`), with each entry linking to its own detail page.
Its configuration is on the core **Configuration → Development → Logging and errors**
page (`system.logging_settings`) rather than a separate screen.
