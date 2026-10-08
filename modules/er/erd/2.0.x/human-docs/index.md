# Entity Relationship Diagrams — manual setup guide

**Entity Relationship Diagrams** (`erd`) draws your site's entity types and the
references between them as an **interactive diagram**, so you can *see* the data
model instead of reconstructing it one bundle at a time in Field UI. It's one of the
first things a developer or agency reaches for when inheriting an unfamiliar Drupal
site — the whole model appears at once, and because it is generated live from the
entity definitions, the diagram cannot drift out of date.

You view and rearrange the diagram at **Structure → Entity Relationship Diagrams**;
an AJAX-backed layout means the arrangement you set survives a page reload. It
supports Drupal 9.4, 10 and 11.

Two things are worth weighing before you rely on it:

- **jQuery UI dependencies.** The module needs four contributed jQuery UI modules
  (`jquery_ui`, `jquery_ui_menu`, `jquery_ui_autocomplete`, `jquery_ui_resizable`)
  that carry components Drupal removed from core after Drupal 9. jQuery UI is in
  long-term maintenance rather than active development — fine for a developer tool,
  but something to be aware of.
- **JavaScript is loaded from a CDN.** For ease of installation the module pulls its
  JavaScript libraries in over a CDN, which means it will **not work offline**
  without modifying the module's `erd.libraries.yml` to point at local copies.

It's a learning and documentation aid rather than a full ERD-authoring tool. For
diagrams that need to leave the site (Mermaid/CSV export), look at
*Content Model Documentation*; ERD is the interactive, in-site view.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (including the
   jQuery UI dependencies) and enable the module.
2. [Configuration](configuration/index.md) — the settings form that controls what
   the diagram includes.

## Where it lives in the admin menu

The diagram is at **Structure → Entity Relationship Diagrams**
(`/admin/structure/erd`), and its settings form at `/admin/structure/erd/settings`.
All of the module's pages are gated by the **Administer ERD** permission — worth
keeping tight on production, since the diagram exposes every entity type and bundle
on the site.
