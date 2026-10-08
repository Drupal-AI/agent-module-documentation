# D7 Content Import — manual setup guide

**D7 Content Import** (`d7_import`) imports content exported from a **Drupal 7**
site into **Drupal 11**, without going through the standard, staged
D7 → D8 → D9 → D10 → D11 migration path. Instead of running the full Migrate
pipeline, it works in two moves: you run an included export script on the D7 site
to dump its content to XML, then you import those XML files into D11 with this
module.

It aims to bring across the whole picture, not just node bodies. It **preserves
node, term, and file IDs** (repairing the auto‑increment sequences afterward so
new entities don't collide), **auto‑creates vocabularies and content types** from
the import data, and **auto‑creates fields** based on the D7 field types —
inferring cardinality from real usage, collecting allowed values from list fields,
resolving entity‑reference target types, and registering each imported field on
the default form and view displays. It imports taxonomy terms with their full
hierarchy (topologically ordered so parents exist before children), files and file
references, menus and menu links, and URL aliases.

The module depends on core's **Node**, **Taxonomy**, **File**, and **Path alias**
modules, requires **Drupal 11**, and provides its own permission for reaching the
import UI. Both a web form and a set of Drush commands are available for running
the import.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — export from D7, then run the import
   in the correct order (form and Drush).

## Where it lives in the admin menu

Once enabled, the import form is at **Content → D7 Import**
(`/admin/content/d7-import`), reachable by users with the module's import
permission. There is no ongoing settings form — this is a one‑time (or
occasional) content‑migration tool, described step by step in
[Configuration](configuration/index.md).
