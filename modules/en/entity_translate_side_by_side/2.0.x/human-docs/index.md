# Entity Translate Side by Side — manual setup guide

**Entity Translate Side by Side** (`entity_translate_side_by_side`) streamlines
Drupal's translation workflow by letting editors edit multiple translations of the
same entity **next to each other** on one screen. Instead of translating each
language on its own separate form, translators see the languages side by side, so
they can work from the original while filling in the translation. It works for any
translatable entity type — nodes, custom entities, and more.

The interface adds a few conveniences: it only saves translations that **actually
changed** (which keeps translation histories and search indexing clean), it
supports drag‑and‑drop to reorder/navigate the languages, and it lets each user
choose which languages to load. It plugs into Drupal's existing entity operations:
on an entity's edit page you'll find a new **"Translate side by side"** option in
the operations dropdown that routes you to the translation screen.

The module needs a little configuration after enabling — you pick the languages to
load by default at its settings page. Access is controlled by a dedicated **Access
Entity Translate Side by Side** permission, which you assign to the roles that
should use the interface.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — choose the default languages and set
   the permission.

## Where it lives in the admin menu

Its settings form is at
`/admin/config/system/entity-translate-side-by-side`, where you select the
languages to be loaded by default. The translation interface itself is reached from
the **"Translate side by side"** option in any entity's operations dropdown.
