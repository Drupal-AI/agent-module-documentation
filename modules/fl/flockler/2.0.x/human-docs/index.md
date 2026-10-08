# Flockler feed — manual setup guide

**Flockler feed** (`flockler`) displays a social-media feed from
[Flockler.com](https://flockler.com) inside a Drupal block. Flockler is a social
aggregation and content-curation service; this module lets you embed one of its
feeds — a curated "social wall" of posts drawn from your social channels — on your
site without building your own aggregation pipeline. You give the block the
identifier of the Flockler feed you want to show, and it renders that feed on the
page.

Because the heavy lifting (collecting and curating posts) happens on Flockler's
side, the Drupal module stays small: it is essentially a configurable block plus
the permission to place it. The feed identifier you enter is a **public embed
value**, the same kind Flockler gives you for embedding a feed on any website — it
is not a private API secret.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.
2. [Configuration](configuration/index.md) — place the block and point it at your
   Flockler feed.

## Where it lives in the admin menu

You place and configure the Flockler feed from **Structure → Block layout**
(`/admin/structure/block`). Placement is governed by the module's permission under
**People → Permissions**.
