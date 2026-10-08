# Block Subtitle — manual setup guide

**Block Subtitle** (`block_subtitle`) adds a second line of text — a strapline —
to a block, on top of its normal title. Design work often calls for a heading
with a supporting line beneath it, like "Latest news" with "Updates from across
the organisation" underneath. Drupal blocks only have one title, so this module
adds the extra line as part of the block's configuration.

The clever part is *where* it stores the subtitle. Rather than requiring a custom
block type with a subtitle field — which can't help with a Views block or a system
block, since those have no fields — Block Subtitle saves the subtitle as **block
configuration**. That means it works on **any block plugin**: system blocks, Views
blocks, menu blocks, and custom blocks alike, and it exports with the block's
configuration when you deploy between environments.

The module is deliberately small: a settings value on the block form, a
configuration schema, and a dedicated permission, **Administer block subtitle**,
which usefully separates "may set a subtitle" from full block administration. It
depends only on core's Block module and supports a wide core range (Drupal 8
through 11). One note for themers: the subtitle is made available to the block
template, so exactly how and where its markup appears remains a theme decision.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

The module adds no page of its own. The **Subtitle** field appears on each block's
configuration form under **Structure → Block layout**
(`/admin/structure/block`).

## How to use it

1. Grant the **Administer block subtitle** permission at
   **People → Permissions** to the roles that should set subtitles (this can be
   given without full block-administration rights).
2. Go to **Structure → Block layout** and configure any block — system, Views,
   menu, or custom.
3. Enter text in the **Subtitle** field and save. The subtitle is stored with the
   block's configuration and exports with it.
4. If the subtitle doesn't appear where you want, make sure your theme's block
   template outputs the subtitle variable — its markup and placement are a theme
   decision.
