# Status Block — manual setup guide

**Status Block** (`status_block`) provides a customizable block — a compact status
bar — that surfaces useful information about the current site and environment: the
project version, the active theme, a custom message you write, and which
environment you are on (dev, stage, prod). The environment can be color-coded, so
anyone glancing at the bar can tell instantly whether they are looking at
production or a staging copy.

The problem it solves is orientation. On teams that juggle several environments,
it is easy to forget which one a browser tab is showing — and to make a change in
the wrong place. A always-visible, color-coded status bar removes that doubt. The
bar is fixed-positioned by default so it stays on screen as you browse, and you can
choose which items appear, drag to reorder them, and tuck less-used items into a
"More" dropdown to keep it tidy.

It has no dependencies beyond Drupal core and works on Drupal 10 and 11. Some
minimal, theme-friendly styling ships with it, exposed through CSS variables so you
can adapt colors, spacing, and typography to match your theme. Viewing the bar is
gated by a **view status blocks** permission, so you decide which roles see it.
Developers can extend it with new data widgets (deploy info, monitoring links,
feature flags) through its plugin system.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — the Composer command and enabling the
   module.
2. [Configuration](configuration/index.md) — placing the block, choosing and
   ordering items, setting environment colors, and the permission.

## How to use it

There is no global settings form — everything is configured on the block itself.
You add the block through **Structure → Block layout**, place it in a region, then
open its configuration to pick which items to show, reorder them, edit the custom
message, and set up environment names and colors. Then grant the *view status
blocks* permission to the roles that should see it. The full walkthrough is in
[Configuration](configuration/index.md).
