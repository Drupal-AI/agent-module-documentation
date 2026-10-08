# Entity Weight — manual setup guide

**Entity Weight** (`entity_weight`) adds a **weight field to any fieldable entity
type** — nodes, taxonomy terms, media, paragraphs, block content, and custom
entities — so you can control their display order by hand. Drupal core can sort by
date, title, or the sticky flag, but there is no built-in way to give taxonomy
terms, media items, or paragraphs a custom "this comes before that" order. Entity
Weight fills that gap with a single, unified interface, no custom code required.

You enable weighting per entity type and bundle from one admin page (a checkbox
each), and reorder items either by **drag-and-drop** or by typing a weight value
directly. Behind the scenes it attaches a `field_entity_weight` field to each
selected bundle, which you can then use as a **sort criterion in Views** to order
any listing.

Some thoughtful touches make it practical at scale: the field widget shows a
number input for large weight ranges and a dropdown for small ones; the ordering
table is paginated (50 per page) so it stays fast with thousands of entities;
saving order changes runs as a batch to avoid memory problems; weights are
translatable and the ordering screen filters by language; and there is a toggle to
include or exclude unpublished entities. By default the weight field is **hidden
on entity edit forms** (its value is preserved), so editors are not distracted by
it — you can reveal it per bundle if you want editors to set weight while editing.

Uninstalling is clean: the weight fields and their storage are removed
automatically. The module provides its own permission and depends only on core's
Field and Field UI.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — enabling weighting per bundle,
   setting the weight range, and reordering entities.

## Where it lives in the admin menu

- **Settings** — **Configuration → Entity Weight** (`/admin/config/entity-weight`),
  where you set the weight range and enable bundles.
- **Reordering** — **Structure → Entity Weights** (`/admin/structure/entity-weight`),
  where you drag or type to order entities within a bundle.
