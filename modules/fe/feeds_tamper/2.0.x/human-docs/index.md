# Feeds Tamper — manual setup guide

**Feeds Tamper** (`feeds_tamper`) bridges the [Feeds](https://www.drupal.org/project/feeds)
and [Tamper](https://www.drupal.org/project/tamper) modules, letting you clean up
and transform imported data *before* it's mapped onto your Drupal fields and
saved. Feeds pulls in raw data from CSV, XML, JSON, or RSS, but that data is
often messy — wrong case, stray whitespace, comma‑separated values that should be
split into several, dates in an unusable format, or text that needs
find‑and‑replace. Feeds Tamper lets you fix all of that as the feed runs.

It works by adding a **Tamper** operation to each Feeds feed type. There you
attach one or more **Tamper plugins** to any source field and put them in the
order you want (by weight). When the import runs, Feeds Tamper intercepts each
parsed item and passes every source value through its configured chain of tampers
before Feeds maps it. The transformation plugins themselves — trim, convert case,
explode/implode, find & replace, regular‑expression replace, default value,
required, unique, and many more — come from the separate **Tamper** module;
Feeds Tamper's job is simply to wire Tamper into the Feeds pipeline.

There is **no global settings page** — you configure tampers per feed type,
right where you manage that feed type. The configuration is stored as third‑party
settings on the feed type, so it exports and deploys alongside the rest of your
Feeds configuration. Feeds Tamper requires both **Feeds** (`^3.0`) and **Tamper**
(`^1.0-alpha3`), and it adds a global *administer feeds_tamper* permission plus a
dynamically generated per‑feed‑type permission so you can let an editor tamper
just one specific feed.

This guide is written for a **human** setting the module up and using it. If you
want a terse, token‑cheap reference for an AI coding agent — including the Tamper
manager service API — read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer alongside Feeds
   and Tamper, and enable it.

## Where it lives in the admin menu

There's no central page. Feeds Tamper adds a **Tamper** tab to each feed type at
**Structure → Feed types → *(your feed type)* → Tamper**
(`/admin/structure/feeds/manage/{feed_type}/tamper`). Everything you configure
lives there, scoped to that one feed type.

## How to use it

1. Make sure you have a working Feeds **feed type** with its source fields mapped.
2. Go to **Structure → Feed types**, and on the feed type you want, open the
   **Tamper** tab.
3. For a given source field, add a Tamper plugin — for example *Trim* to strip
   whitespace, *Convert case* to normalize casing, or *Explode* to split a
   comma‑separated cell into multiple values.
4. Add more tampers to the same field if needed and drag them into the order they
   should run — chains are applied top to bottom.
5. Run the feed. Each source value now passes through its tamper chain before
   being saved.

Typical jobs include trimming and upper‑casing product SKUs before a Commerce
import, splitting a full‑name column, converting date strings into a parseable
format, find‑and‑replacing a domain in imported URLs, stripping HTML from scraped
text, and marking a source as required so incomplete items are skipped. Because
the rules live in the feed type's configuration, they deploy across environments
with the rest of your Feeds config.
