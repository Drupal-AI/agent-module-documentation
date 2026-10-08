# Chado Light (chadol) — manual setup guide

**Chado Light** (`chadol`) is a bridge between **Chado** — the modular GMOD schema
for biological and genomics data, implemented on PostgreSQL — and Drupal. It lets
you map Chado content to Drupal entities in a couple of clicks, using the
[External Entities](https://www.drupal.org/project/external_entities) module to
read Chado data live. There's no import, no synchronization, and no indexing:
Drupal reads directly from the Chado database, so what you see is always current.
Chado Light is part of the Tripal ecosystem and is a practical way to serve Chado
data on a modern Drupal 8+ site while a full Tripal 4 solution matures.

Its strengths are flexibility: you map Chado content through a graphical UI,
support multiple databases, and can revise or customize the mapping at any time.
Mapped content can even combine Chado data with non-Chado data (stored in Drupal,
in another database, in the filesystem, or fetched over REST). It's also BrAPI
compatible when used with the BrAPI module.

It depends on **External Entities** together with its **SQL storage / cross-schema
query** submodules (with the PostgreSQL driver enabled) and provides its own
permissions. It supports Drupal 9, 10, and 11. This is a beta release
(`1.0.0-beta4`), and the project is **not covered by Drupal's security advisory
policy**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its External Entities dependencies.

There is **no dedicated settings form** for Chado Light itself. Setup is a
combination of a database connection in `settings.php` and mapping done through the
External Entities admin UI (see "How to use it" below).

## How to use it

The essential setup has two parts:

1. **Connect the Chado database.** If your Chado schema is *not* in the same
   database as Drupal, add its connection credentials to your site's
   `settings.php` as an additional database connection. Treat these credentials as
   **secrets** — keep them in an environment variable and reference them via
   `getenv()` in `settings.php` rather than committing the values. Chado runs on
   PostgreSQL, so the cross-schema query API needs its PostgreSQL driver enabled.
2. **Map Chado content to entities.** Use the External Entities admin UI to map
   the Chado content you want to expose to Drupal entities — Chado Light makes this
   a few-clicks operation rather than the manual, one-field-at-a-time SQL mapping
   that raw External Entities database storage would require. You can adjust the
   mapping later, and include non-Chado fields alongside the Chado data.

**Data-handling note:** because you're reading from an external/secondary
database, expose only the records you intend to publish, and keep those DB
credentials out of version control.

## Recommended companion modules

The maintainers suggest **BrAPI**, **External Entities Manager**, **External
Entities Multiple Storages**, **Imagecache External**, and the **External Entities
Views Plugin** to round out a Chado-backed site.
