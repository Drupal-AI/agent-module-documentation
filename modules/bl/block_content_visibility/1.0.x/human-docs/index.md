# Block Content Visibility — manual setup guide

**Block Content Visibility** (`block_content_visibility`) lets you attach
visibility conditions — such as path, content type, or role — directly to a
**custom (content) block** as you create or edit it, rather than setting those
conditions separately every time you place the block in a region.

Normally in Drupal, visibility rules belong to a block *placement*: if you put
the same custom block in three places, you configure its conditions three times.
This module exposes core's built-in condition UI on the block content add/edit
form and **saves the conditions on the block itself**, so they travel with the
block and are reused wherever it appears. It builds on core's `block_content`
module and the `block_form_alter` helper module, and supports Drupal 10.3 and 11.

As with all visibility features, this controls **when a block is displayed, not
who may access its data**. Hiding a block does not secure its contents — use
Drupal's permission system for that. Managing these conditions is gated behind a
dedicated permission, **Administer block content visibility**, so you can grant
it independently of full block administration.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

The module adds no settings page. It adds a **Visibility** section to the custom
block add/edit forms found under **Content → Blocks**
(`/admin/content/block`) — the same place you create and edit reusable content
blocks.

## How to use it

1. Grant the **Administer block content visibility** permission at
   **People → Permissions** to the roles that should manage these conditions.
2. Go to **Content → Blocks** and add or edit a custom (content) block.
3. Use the **Visibility** section on the form to set conditions — by path,
   content type, role, and so on — just as you would on a block placement.
4. Save the block. The conditions are stored on the block content entity itself,
   so every placement of that block reuses them automatically.
