# Feeds — manual setup guide

**Feeds** (`feeds`) imports content into Drupal from external sources — CSV files,
RSS/Atom feeds, XML sitemaps, OPML, and (with companion modules) JSON and XML —
and maps the incoming data onto the fields of Drupal entities such as nodes,
users, and taxonomy terms. You can run an import once, on demand, or on a
schedule via cron.

Feeds is built around two things:

- A **feed type** defines the import *pipeline*: a **fetcher** (where the data
  comes from) → a **parser** (how the raw data is read) → a **processor** (what
  entity type and bundle gets created or updated), plus the **field mappings**
  that connect each piece of source data to a target field. You build a feed type
  once and reuse it.
- A **feed** is a concrete instance of a feed type — it points at an actual
  source (a specific URL or uploaded file) and is the thing you actually run to
  perform the import.

This guide is written for a **human** clicking through the admin UI. It walks you,
step by step and with screenshots, from installing the module to building your
first feed type and running an import. If you are looking for terse, token-cheap
references for an AI coding agent, read the sibling [`agent/`](../agent/start.md)
docs instead.

![The Feed types list at Structure → Feed types](images/types.png)

## Where it lives in the admin menu

Feed types are managed under **Structure → Feed types**
(`/admin/structure/feeds`). That page lists every feed type you have defined and
provides an **+ Add feed type** button. The feeds themselves (the concrete
sources you import) live under **Content → Feeds** (`/admin/content/feed`).

## Contents

1. [Installation](installation/index.md) — install Feeds with Composer and enable
   it, plus optional companion modules.
2. [Configuration](configuration/index.md) — the Feed types list and the
   fetcher → parser → processor concept.
3. [Creating a feed type](creating-a-feed-type/index.md) — build a feed type,
   map your source data onto fields, and run your first import.
