# Block Component Library — manual setup guide

**Block Component Library** (`block_component_library`) lets custom (content) blocks
be treated as reusable **components** — a way to organize and reuse your custom
blocks as building-block components across the site, for a component-driven build
approach (for example when working in Layout Builder or block layout).

Use it when you build pages from reusable pieces and want your custom blocks to act
as a library of components you can drop in repeatedly, rather than one-off blocks
placed by hand.

This is a content-editing / site-building feature. It affects how blocks are
organized and reused; the blocks keep their own access rules, and the module plays
no role in access control of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

The module works through Drupal's existing block and layout tooling rather than
adding a dedicated settings page. You manage your custom blocks in the block library
(**Content → Blocks**, `/admin/content/block`) and reuse them as components where you
build layouts — for example in Layout Builder or **Structure → Block layout**.

## How to use it

1. Create the custom (content) blocks you want to reuse as components.
2. Use them as reusable components across your site — for instance placing them in
   Layout Builder or block layout wherever the component is needed.

The module's role is to make those custom blocks usable as reusable building-block
components; the blocks themselves are authored and placed through Drupal's normal
block tools.
