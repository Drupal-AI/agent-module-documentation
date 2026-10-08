# Rater8 Reviews Block — manual setup guide

**Rater8 Reviews Block** (`rater8_review_block`) is a block plugin that embeds
aggregated reviews and star ratings from the third-party
[Rater8](https://www.rater8.com/) platform onto your Drupal site. You place the
**Rater8 Reviews** block wherever you want the reviews to appear and give it the
Rater8 ID for the physician (or entity) whose reviews you want to show; the block
then displays that entity's Rater8-collected rating summary and review content.

The reviews are loaded **client-side from Rater8's public API** using a **public
widget ID** — this ID is a public identifier, not a secret credential, so there
is nothing sensitive to store on the Drupal side. The result is a low-effort way
to show real social proof in your site's layout.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — place the block and set its Rater8
   ID.

## Where it lives in the admin menu

The module adds no settings page of its own. You configure it entirely through
the **Block layout** system at **Structure → Block layout**
(`/admin/structure/block`), where you place and configure the **Rater8 Reviews**
block.
