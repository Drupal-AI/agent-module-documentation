# Collapsiblock — manual setup guide

**Collapsiblock** (`collapsiblock`) makes individual Drupal blocks **collapsible**:
click a block's title and its content folds away with a smooth slide animation.
Each visitor's open/closed choice can be remembered from page to page. It is aimed
at site-builders with relatively simple needs who want tidier sidebars and footers
without writing theme code or JavaScript.

The classic problem it solves is a long stack of blocks in a sidebar or footer —
especially on small screens, where all that stacked content pushes the real page
content far down. Making blocks collapsible lets visitors fold away what they are
not using, and lets you ship some blocks collapsed by default. Doing this by hand
would be a per-block theme-and-JavaScript job; Collapsiblock turns it into a simple
per-block setting.

The collapse behaviour is configured **per block**, right on each block's own
configuration form — there is no central settings page. For each block you choose a
default state: always open, always collapsed, collapsed on load, or "remember per
user." The remembering is handled through its **js_cookie** dependency, which stores
the state in a cookie. For menu blocks there is an option to keep the active trail
open, so a block containing a link to the current page stays expanded. The slide
animation is powered by a lightweight bundled library (no jQuery required).

Collapsiblock has **no permissions** — it changes how blocks behave for everyone who
sees them. Its main compatibility consideration is the theme: because the collapse
behaviour attaches to block markup, it is worth confirming it works cleanly with your
theme's block structure.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

There is **no central configuration page** — collapse behaviour is set per block,
described in "How to use it" below.

## How to use it

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Click **Configure** on the block you want to make collapsible.
3. In the block's configuration form you will find Collapsiblock's options. Choose
   the **default state** for this block:
   - **Always open** — the block behaves normally (no collapse).
   - **Always collapsed** — the block starts collapsed every time.
   - **Collapsed on load** — starts collapsed but can be opened.
   - **Remember per user** — the visitor's last choice is stored in a cookie and
     restored on later pages.
4. For **menu blocks**, optionally keep the **active trail** open so a block linking
   to the current page stays expanded. Uncheck it if you would rather the block
   behave like any other.
5. Save the block.

Repeat for each block you want to be collapsible. Visitors can then click a block's
title to fold or reveal its content.
