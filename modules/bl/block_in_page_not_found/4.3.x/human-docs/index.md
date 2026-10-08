# Block In Page Not Found — manual setup guide

**Block In Page Not Found** (`block_in_page_not_found`) lets you show a block
only on the site's 404 / "page not found" responses. It adds a single block
**visibility condition** named "Page not found", which you turn on from any
block's *Visibility* settings — so you can build a helpful, branded 404
experience out of ordinary blocks (a search box, helpful links, a "report a
broken link" call to action) without writing a custom controller or template.

The condition adds one checkbox, **"Show in page not found"**. When it is ticked,
the block renders only when the current request is a 404; when it is left
unticked (the default) the condition imposes no restriction, so the block behaves
as if the condition were not set. Like every core condition it also supports
*Negate*, so you can invert it to **hide** a block on 404 pages instead. The
setting is stored on the block's own configuration, so it travels with your
exported config. The module depends only on core's **Block** module, ships no
submodules, and has no settings page, permission or Drush command of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

The module adds no page of its own. You use it from core's **Structure → Block
layout** (`/admin/structure/block`), inside each block's configuration under the
*Visibility* section.

## How to use it

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Place a block into a region, or edit an existing block.
3. In the block's configuration open the **Visibility** section and select the
   **Page not found** tab.
4. Tick **"Show in page not found"** and click **Save block**.

That block now renders only on 404 / page-not-found responses. A few things worth
knowing:

- **The block can be anything** — a custom block, a menu, a search block, a Views
  block, and so on. The condition only controls *when* the block is visible, not
  what it contains.
- **Blocks are theme-specific.** Place the block in the theme that actually
  serves your site's pages (for example Olivero), or it won't appear.
- **To hide a block on 404s instead**, tick the same checkbox and also tick the
  **Negate the condition** option, which inverts the rule.
- **Combine it with other visibility conditions** (roles, specific pages) to
  fine-tune exactly who sees the 404 block and where.
