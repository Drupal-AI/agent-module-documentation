# Entity Attributes — manual setup guide

**Entity Attributes** (`entity_attributes`) gives you a UI for adding HTML
attributes — `id`, `class`, `data-*`, and anything else — to entities, so those
attributes flow through into the rendered markup and templates. It scratches a very
common Drupal itch: highlighting one link in a menu, adding an anchor to a specific
block, or attaching a class that triggers some behaviour, without hand-crafting a
template for each case. Drupal's templates already support attributes; what has
been missing is a consistent, content-level UI to manage them and the "glue" that
connects them to the templates. That is what this module provides.

Its selling point is breadth and consistency. Rather than installing a separate
per-type helper (one for blocks, one for menus, one for nodes, one for
paragraphs…), Entity Attributes handles many entity types through one consistent
experience: **nodes, taxonomy terms, blocks, menus, content menu links, static
menu links, paragraphs, and ECK entities**, and it is designed to be easy to extend
to more. Attributes are entered in **YAML** and converted into an attributes object
passed to the entity's template. It also understands multiple **attribute sets** per
template — `attributes` (the main container: `id`, `class`, `data-*`),
`title_attributes`, `content_attributes`, and plugin-specific sets.

The module is a theming / site-building tool. It has no access-control role beyond
its own permissions, and because attribute values are rendered into markup, treat
what you enter as output that must be safe. It depends on core's **Field** and
**System** modules and requires **Drupal 11**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no central settings page** for this module. You enable and edit
attributes on the individual entities themselves, as described in "How to use it"
below. For the full list of features and per-entity-type details, see the module's
own README.

## Where it lives in the admin menu

Entity Attributes adds no dedicated admin configuration page. You work with it
directly on the supported entities — for example when editing a node, block, menu
link, taxonomy term, or paragraph — where the attributes field appears. Which roles
may see and edit that field is governed by the permissions the module provides, set
at **People → Permissions** (`/admin/people/permissions`).

## How to use it

1. On a supported entity's edit form (a node, block, menu link, taxonomy term,
   paragraph, ECK entity, and so on), locate the attributes field the module adds.
2. Enter your attributes in **YAML**, keyed by attribute set. For example, the main
   container's `class` and a `data-*` attribute go under the `attributes` set;
   title-specific attributes go under `title_attributes`; content-wrapper
   attributes under `content_attributes`.
3. Save the entity. The attributes are converted into an attributes object and
   passed to that entity's template, so they appear on the rendered element.

Because the module imposes no restriction on attribute names or values, keep in
mind that whatever you enter is rendered into the page markup — enter only values
you trust, and grant the editing permission accordingly.
