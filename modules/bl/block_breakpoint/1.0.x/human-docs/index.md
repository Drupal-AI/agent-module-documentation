# Block Breakpoint — manual setup guide

**Block Breakpoint** (`block_breakpoint`) conditionally loads blocks based on
responsive breakpoints, so a block appears only at certain screen sizes — for
example a block that shows only on desktop, or one that shows only on mobile. It
builds on Drupal core's Breakpoint module.

Use it to tailor which blocks appear per device without duplicating content: rather
than maintaining two versions of a region for large and small screens, you place one
block and tell it which breakpoint(s) it belongs to.

This is a presentation/responsive feature — it changes block **visibility** by
screen size only. It does not grant access to anything: the block's own access
rules still apply, and this module never overrides them.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

> **Note:** the current release is an alpha (1.0.0-alpha7). Test it before relying
> on it in production.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

There is no separate settings page. You set the breakpoint condition on the block
itself, on the block's configuration form under **Structure → Block layout**
(`/admin/structure/block`).

## How to use it

1. Go to **Structure → Block layout** and edit (or place) a block.
2. In the block's configuration, set the **breakpoint condition** — choose the
   screen size(s) at which the block should appear.
3. Save the block.

The block now renders only at the breakpoints you selected. Adjust or clear the
condition later by editing the block again.
