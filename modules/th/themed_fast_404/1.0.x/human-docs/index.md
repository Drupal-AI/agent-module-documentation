# Themed Fast 404 — manual setup guide

**Themed Fast 404** (`themed_fast_404`) makes Drupal's cheap, high-performance
"fast 404" response actually look like your site. Drupal core can return a canned
HTML snippet for missing URLs without going through the full route-and-render
pipeline — which is far cheaper when bots and scanners hammer non-existent paths —
but that snippet is bare, unstyled markup, so most sites turn it off and pay the
cost of a full themed 404 instead. This module closes the gap: on cron it renders
your 404 page once, saves it as a static HTML file (one per language), and quietly
feeds that HTML into core's fast-404 setting so every missing URL is served from
it, branded, without a full bootstrap.

The practical payoff is performance: you keep core's fast-404 speed benefit *and*
get a 404 that matches your theme, correctly translated on multilingual sites. It
noticeably cuts CPU from broken inbound links and bot traffic probing for
`wp-admin` and similar. Because the page is a **snapshot generated on cron**, a
theme or wording change doesn't appear in 404s until cron runs again (or you press
the rebuild button on the settings form). It's a mature, fairly popular module —
around 1,360 sites use it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead. The module depends on core's **Config**
and **File** modules (both standard), has no submodules, and adds no third-party
libraries.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and
   run cron (required — nothing themed is served until the static file exists).
2. [Configuration](configuration/index.md) — the settings form, field by field,
   plus how and when to regenerate the static page.

## Where it lives in the admin menu

Its settings form is at **Configuration → System → Themed Fast 404**
(`/admin/config/system/themed_fast_404`), reachable by anyone with the
**Administer site configuration** permission.

## How it works, in one paragraph

The module adds a public `/page-not-found` route rendered with your theme. On
cron it fetches that page over HTTP and writes the result to
`public://page-not-found-{langcode}.html` for each enabled language. At runtime a
config override injects that HTML into core's `system.performance` fast-404
setting, and widens the fast-404 match to **all** paths (while excluding
`/styles/` and `/system/files/` so image derivatives and private-file downloads
keep working). One important consequence: the path override takes effect the
moment you enable the module — before the first cron run — so you should
**run cron right after enabling** to make sure a real static page is in place. See
[Configuration](configuration/index.md) for the details and the gotchas.
