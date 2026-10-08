# Field as Block — manual setup guide

**Field as Block** (`fieldblock`) lets you take a single field of the entity you
are currently viewing — a node's body, a hero image, a "published on" date, a
user's picture, a taxonomy term's description — and render it as a **placeable
block** in any region of your theme, instead of leaving it locked inside the
entity's own template.

It is meant as a lightweight alternative to heavier layout tools like Panels,
Display Suite, or a one-field View: rather than defining a display mode elsewhere,
you configure the formatter and its settings right in the block's configuration
form. It adds no blocks of its own until you place them, and it depends only on
core's **Block** module.

The module works as soon as you enable it, but it needs a little setup before the
blocks appear. First you tell it which entity types should be exposed as field
blocks (nodes, users and taxonomy terms are the defaults), then you place the
field blocks you want from the normal Block layout screen. A field block quietly
disappears on any page where its entity or field is not present, so you never get
an empty wrapper on unrelated pages.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — choose which entity types are exposed
   as field blocks, then place and configure a field block.

## Where it lives in the admin menu

Field as Block has two touch points in the admin UI:

- **Configuration → Field as block** (`/admin/config/fieldblock/fieldblockconfig`)
  — the settings form where you choose which entity types are exposed as field
  blocks, and where you can clean up orphaned blocks. This is the page the
  module's "Configure" link points at.
- **Structure → Block layout** (`/admin/structure/block`) — where you actually
  place a field block into a region, using the *Place block* buttons.

## How to use it

Once you have enabled an entity type (see [Configuration](configuration/index.md)),
each type gets its own block in the block library — labelled **Content field**,
**User field**, **Taxonomy term field**, and so on. Place one of these into a
region and its block form asks you for four things: whether to use the field's own
label as the block title, which **field** to render, which **formatter** to use,
and that formatter's settings (for example an image style, a trim length, or a
date format).

At render time the block finds the entity being viewed on the current route,
renders your chosen field through the chosen formatter, and shows it in the region.
It only appears on the entity's own canonical page (and its revision pages), in the
page's content language, and it hides itself automatically when the field is empty
or the visitor lacks access to it. Because you can place the same field twice with
different formatters, or give each placement its own block visibility conditions
(path, role, content type), it is an easy way to move one field into a sidebar,
header, or footer without writing a custom template.
