# Dblog JSON Viewer — manual setup guide

**Dblog JSON Viewer** (`dblog_json_viewer`) turns the raw, hard-to-read JSON that
often ends up in Drupal's log messages into a tidy, interactive viewer. When a log
entry contains JSON — an API response, a webhook payload, a structured error
context — core's Database Logging normally dumps it as a wall of plain text. This
module detects that JSON in the log entry's *Details* screen and replaces the plain
text with a syntax-highlighted, collapsible, searchable view.

The niceties are aimed squarely at debugging: it uses a complexity-scoring
heuristic to pick out the most relevant JSON object on the page, gives you a
real-time search box (with configurable debounce and regex support) plus
Previous/Next navigation through matches, lets you expand or collapse all sections
at once, toggle between the formatted and raw views, and copy either with one
click. It's mobile-responsive and integrates cleanly with the Gin admin theme's
light and dark modes, though it works with any admin theme.

The module works automatically the moment you enable it — no configuration is
required. It only changes how existing log entries are displayed, so it depends on
core's Database Logging (`dblog`) module and nothing else. An **optional** settings
form lets you fine-tune behaviour (such as the search debounce delay). The settings
page is gated by the *Administer site configuration* permission.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.
2. [Configuration](configuration/index.md) — the optional settings form for
   fine-tuning the viewer.

## Where it lives in the admin menu

The enhanced viewer appears automatically on any log entry that contains JSON —
open **Reports → Recent log messages** (`/admin/reports/dblog`) and click into an
event (`/admin/reports/dblog/event/*`). Its optional settings live at
**Configuration → Development → Database Log JSON Viewer**
(`/admin/config/development/dblog-json-viewer`).

## How to use it

1. Go to **Reports → Recent log messages** and click a log entry that contains JSON
   data.
2. The *Messages* field renders as an interactive, syntax-highlighted JSON viewer
   instead of plain text.
3. Use the search box to find a key or value, expand/collapse sections, toggle
   between JSON and raw views, and copy the content with the on-screen buttons.

Because log entries can contain sensitive data (API payloads, tokens, personal
information in error contexts), remember that this only *displays* what is already
in your log — restrict who can view logs, and be mindful of what your site logs in
the first place.
