# Calculator — manual setup guide

**Calculator** (`calculator`) provides a block that displays an interactive
calculator on your site — a simple on-page calculator widget you place through
Drupal's block system. It is a small content-display feature: the calculator
runs client-side in the browser and is entirely self-contained.

There is nothing to integrate and no data to manage. It has no content type, no
permissions, and no special access role — you place the block where you want the
calculator to appear, and visitors can use it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

Calculator does not add a settings page of its own. You place its block from
**Structure → Block layout** (`/admin/structure/block`), the standard Drupal
block administration screen.

## How to use it

1. Enable the module.
2. Go to **Structure → Block layout**.
3. Click **Place block** in the region where you want the calculator, and choose
   the **Calculator** block.
4. Configure the standard block options (title, visibility conditions) and save.

The calculator then appears in that region for visitors to use.
