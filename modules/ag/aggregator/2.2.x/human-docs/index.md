# Aggregator — manual setup guide

**Aggregator** (`aggregator`) pulls syndicated content — RSS, RDF, and Atom feeds
— from external sites into your Drupal site and displays it at `/aggregator` and
in a block. Each source you add is stored as a feed, and each article it imports
is stored as an item, so you can build a "news river" or planet‑style page from
many sources (this is the very module that powers Drupal Planet). It was part of
Drupal core for years, was deprecated in core 9.4 and removed in 10.0, and now
lives on as this contributed module.

Administrators add feeds — a title, URL, and refresh interval — or bulk‑import
them from an OPML file. On each cron run, feeds whose refresh interval has elapsed
are queued and imported through a three‑stage pipeline: a **fetcher** downloads
the raw feed, a **parser** turns it into a common item structure, and one or more
**processors** act on the parsed items (the default processor stores them and
trims old ones). All three stages are swappable plugins, so developers can replace
how feeds are fetched, parsed, or handled. Global settings — the active
fetcher/parser/processors, how many items to show per listing, and how long to
keep old items — live on one settings form.

The module works once you enable it and add a feed; there's a bit of configuration
to add sources and tune retention. Two permissions gate it: **"View news feeds"**
to read and **"Administer news feeds"** to manage. It depends on core's **File**,
**Filter**, and **Options** modules and pulls in the `laminas/laminas-feed`
library via Composer. One security note up front: because the site fetches feed
URLs server‑side, the admin permission can be used for low‑threat SSRF — grant it
only to trusted roles.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent — including the pipeline
plugin interfaces, services, and alter hooks — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer
   (which pulls in laminas‑feed) and enable it.
2. [Configuration](configuration/index.md) — add feeds, import OPML, tune the
   global settings, and grant the permissions.

## Where it lives in the admin menu

The feed overview and settings are under **Configuration → Web services →
Aggregator** (`/admin/config/services/aggregator`); the settings form is at
`/admin/config/services/aggregator/settings`. Imported content is shown publicly
at `/aggregator`, and an "Aggregator feed" block is available on **Structure →
Block layout**.

## How to use it

Enable the module, add one or more feeds (or import an OPML file), let cron import
them, and place the "Aggregator feed" block if you want a sidebar list. The
step‑by‑step, including retention settings and permissions, is on the
[Configuration](configuration/index.md) page.
