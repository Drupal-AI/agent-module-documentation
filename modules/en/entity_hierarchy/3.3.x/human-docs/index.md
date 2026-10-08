# Entity Hierarchy — manual setup guide

**Entity Hierarchy** (`entity_hierarchy`) lets you build parent/child trees out of
your content. It adds a special entity‑reference field type,
`entity_reference_hierarchy`, that stores a "parent" reference plus a **weight**
(for ordering siblings). Add that field to a content type — pointing entities of
the same type at each other — and you get a page tree: editors can nest pages
under other pages, reorder siblings by drag‑and‑drop, and query ancestors,
descendants, and siblings efficiently. It's a popular, lightweight alternative to
the core Book module, and it works over any fieldable entity type, not just nodes.

The clever part is how it stores the tree. Behind every hierarchy field the module
maintains a *nested‑set* table (using the `previousnext/nested-set` library), and
it updates that table whenever an entity is saved or deleted. This front‑loads the
expensive bookkeeping onto writes, so reads — "give me all descendants of this
page", "give me the full ancestor chain" — stay cheap. Because those writes are
costly, the module can pause them during large migrations (a State flag) and
rebuild the whole tree afterward with a Drush command.

Entity Hierarchy does not have a global settings page. You configure it entirely
per field, on your content type: add the field, pick a widget (autocomplete or
select, with an optional hidden weight), and optionally expose the "Reorder
children" drag‑and‑drop screen (gated by a permission it provides). It ships rich
**Views** integration — contextual filters for is‑child‑of / is‑parent‑of /
is‑sibling‑of an entity, a root‑ancestor relationship, and a children‑summary
field — so you can build "child pages" listings and section navigation without
code. Its only module dependency is core **Node**; it also needs PHP 8.1+ and pulls
in a couple of Composer libraries.

Three optional submodules build on the tree: **Breadcrumb**
(`entity_hierarchy_breadcrumb`) generates breadcrumbs that follow the hierarchy
instead of the URL, **Microsite** (`entity_hierarchy_microsite`) drives
section/microsites whose pages all descend from one landing node, and **Workbench
Access** (`entity_hierarchy_workbench_access`) scopes editorial sections to the
content hierarchy.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and pick the submodules you need.
2. [Configuration](configuration/index.md) — add the hierarchy field, choose
   widgets and settings, grant the reorder permission, and wire up Views.

## Where it lives in the admin menu

There is no central settings page. You work with Entity Hierarchy in the places
you already manage a content type:

- **Structure → Content types → (your type) → Manage fields** — where you add the
  hierarchy field.
- **Manage form display** / **Manage display** — where you choose the widget and
  formatter.
- Each piece of content gets a **Reorder children** tab (at `<entity>/children`)
  for drag‑and‑drop ordering of its direct children.
- **People → Permissions** — where you grant *Reorder entity_hierarchy children*.

## How to use it

The short version: install the module, add an `entity_reference_hierarchy` field
to a content type that targets the same type (so a page can have a page "Parent"),
then start setting parents on your content. Ordering of siblings is managed either
through the weight sub‑field on the edit form or through the **Reorder children**
screen. For listings — "child pages of this section", breadcrumb trails, and so on
— use the module's Views arguments and relationship. See
[Configuration](configuration/index.md) for the full walkthrough.
