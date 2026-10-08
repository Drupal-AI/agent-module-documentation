# Announcement Bar — manual setup guide

**Announcement Bar** (`announcementbar`) displays a site‑wide announcement banner
— a strip along the page used to show an important message, a promotion, or a
notice to visitors. It is a lightweight content‑display feature: it renders as a
**block**, with configurable text and styling, and you decide where it sits by
placing that block in a region.

The module has no content type or access role of its own. It depends only on
core's **Block** module and supports Drupal 9, 10, and 11.

The available documentation for this module is thin, so this guide describes only
what is known for certain: it is a configurable banner shown through a block. For
the exact fields on the block, check the block's own settings once it is placed.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

Because the bar is a block, you manage it from **Structure → Block layout**
(`/admin/structure/block`) rather than from a dedicated settings page.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Go to **Structure → Block layout** and **Place block** in the region where you
   want the banner to appear — typically a header or a region above the main
   content.
3. Choose the Announcement Bar block, set its text and any styling options the
   block exposes, and save.

The banner then shows site‑wide in the region you chose. To remove or hide it
again, disable or remove the block from Block layout.
