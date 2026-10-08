# Field as Block — manual setup guide

**Field as Block** (`fieldblock`) lets you take a single field of the entity being
viewed — a node's body, its hero image, a "published on" date, a taxonomy term's
description, a user's profile picture — and render it as a **block** you can place
in any region. Normally those fields live inside the entity's template and appear
wherever the theme puts them; with this module you can pull one field out and drop
it into a sidebar, header, or footer instead, without writing a custom preprocess
function or template override, and without Layout Builder.

It works by adding one block type, "Field as Block", that comes in a variant per
entity type — **Content field** (nodes), **User field**, and **Taxonomy term
field** out of the box. You place one of these in Block layout, then pick which
field to show and which formatter to render it with. When someone views an entity
of that type, the block renders that entity's field. On unrelated pages the block
simply disappears — it is smart about only showing up where the field actually
exists and has a value.

The module works after enabling, but only produces something visible once you
**place a block** and choose a field. It depends only on core's **Block** module
and runs on Drupal 9, 10, or 11. There is also a small settings form that controls
**which entity types** get field blocks, in case you want to add media (or another
content entity type) or remove ones you do not need. It provides no submodules.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent — the block plugin id, the
derivative naming, and how the block resolves the entity — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — place a field block and choose its
   field and formatter, and manage which entity types are available.

## Where it lives in the admin menu

You place field blocks from **Structure → Block layout**
(`/admin/structure/block`) like any other block. The module's own settings form —
which entity types expose field blocks — sits at **Configuration → System → Field
as Block settings** (`/admin/config/fieldblock/fieldblockconfig`) and is gated by
the *Administer fieldblock* permission.

## How to use it

The two things you do are: (1) place a field block in a region and tell it which
field and formatter to use, and (2), optionally, adjust which entity types are
available if the default node/user/taxonomy set is not what you need. Both are
covered on the [Configuration](configuration/index.md) page. A nice touch: because
each placement is a normal block, you get all the usual block visibility
conditions (by path, role, content type) for free, and you can place the same
field twice with different formatters.
