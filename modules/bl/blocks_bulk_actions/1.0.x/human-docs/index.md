# Blocks Bulk Actions — manual setup guide

**Blocks Bulk Actions** (`blocks_bulk_actions`) adds bulk operations to Drupal's
Block Layout page. Out of the box, managing placed blocks is a one‑at‑a‑time
affair: to delete, enable or disable several blocks you click into each one
separately. This module lets you select many blocks and apply an action to all
of them at once.

That is a real time‑saver on sites that have accumulated a lot of blocks — for
example when cleaning up after a theme change, or disabling a group of blocks
during maintenance. The bulk operations respect your existing block
administration access, so users can only act on blocks they were already allowed
to manage.

It is a pure administration convenience for site builders and works on Drupal 9,
10 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Select the blocks you want to act on using the checkboxes the module adds.
3. Choose a bulk action — such as delete, enable or disable — and apply it to all
   the selected blocks at once.

Bulk operations follow the same permissions as normal block administration, so
this does not grant anyone extra rights over blocks.
