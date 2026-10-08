# Bootstrap Theme Toggler — manual setup guide

**Bootstrap Theme Toggler** (`bootstrap_color_modes_toggler`) adds a switch block
that lets visitors toggle a Bootstrap‑based theme between **light and dark color
modes**, and remembers their choice. It is aimed at Bootstrap 5 themes that
support color modes and want a ready‑made toggle UI instead of building one by
hand.

It is a pure theming enhancement: it switches color modes on the client side and
persists the visitor's preference, applies site‑wide once the block is placed,
and has no content or access role. It supports Drupal 10 and 11. You use it by
placing its block — there is no separate admin settings page.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

There is no settings form of its own. You place its toggle block at **Structure →
Block layout** (`/admin/structure/block`).

## How to use it

1. Use a **Bootstrap 5 theme that supports color modes** (light/dark).
2. Go to **Structure → Block layout** and place the module's toggle block into a
   region — typically the header, so visitors can reach it from anywhere.
3. Visitors click the switch to flip between light and dark modes; their choice
   is persisted so it sticks on their next visit.
