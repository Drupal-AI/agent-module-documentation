# Grouper — manual setup guide

**Grouper** (`grouper`) makes Drupal's log analysis simple. Drupal's built‑in
dblog (watchdog) viewer shows you the raw fire hose: a single PHP error might
appear thousands of times, once for every page view that triggered it, and finding
the problems that matter means scrolling through pages of noise. Grouper turns that
chaotic log into an organized dashboard, consolidating similar messages into
"Issues" ranked by frequency, so 10,000 identical errors become one Issue with a
count of 10,000.

It groups PHP errors by their actual error signature — not just the raw message
text — so errors from different pages that share a root cause appear together. From
there it offers several analysis views: a PHP summary and detail, non‑PHP messages,
a distribution breakdown, severity, grouping by originating module, by page, by user,
and by host (handy for spotting bad bots).

Grouper also works from the command line via Drush (see, for example,
`drush grouper:php-summary`), which is useful on SSH‑only servers, in monitoring
scripts, and in CI/CD. It can drop timestamped **markers** into the log so you can
see exactly what happened between two points in time (say, before and after a module
update), and it offers selective log‑trimming commands so you can prune the log
without wiping everything.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and
   pick the optional submodules you need.

There is **no settings form** to configure — Grouper works from its analysis views
and Drush commands as soon as it's enabled.

## How to use it

Once enabled, browse to Grouper's analysis views to see your log grouped into
Issues, ranked by frequency, with one‑click drill‑down to when, where, and who
triggered each. The available views include:

- **PHP Summary** — PHP errors grouped by issue, sorted by frequency.
- **PHP Detail** — every occurrence of a specific error, with timestamps, URLs, and
  IPs.
- **Other Summary** — non‑PHP messages (access denied, page not found, and so on).
- **Distribution** — a breakdown of all log types with percentages.
- **Severity** — errors organized by severity level.
- **Module** — PHP errors grouped by the module that raised them.
- **Pages** — which pages generate the most errors.
- **People** — which users trigger the most errors.
- **Host** — errors by IP address, to help you find misbehaving bots.

For command‑line work, Grouper provides Drush commands such as
`drush grouper:php-summary --limit=10` (top PHP errors),
`drush grouper:php-detail <id>` (drill into one issue), `drush grouper:types` (all
log types), and `drush grouper:marker "Before module update"` to drop a marker. It
also adds selective log‑trimming commands (for example,
`drush watchdog-trim-before` and `drush watchdog-trim-range`) so you can prune the
log by ID or range.
