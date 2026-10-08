# Layout Builder Title Link — manual setup guide

**Layout Builder Title Link** (`layout_builder_title_link`) adds a **URL field** to a
block's title in core **Layout Builder**, so a block title can become a link — for
example a section heading that links to a landing page — without writing any custom
templating. When you configure a block in a layout, you set an optional URL, and the
module renders the title as a link to it.

It is a content‑display / layout convenience: the link is admin‑configured on the
block, and the module has no access‑control role. For themers, it also provides a
Twig template suggestion, `block--layout-builder-title-link.html.twig`, so you can
customize how the linked title renders. To use it you only need core Layout Builder
enabled.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no admin configuration page** for this module. You set the title link per
block in the Layout Builder UI, described below.

## How to use it

This module extends core Layout Builder, so you use it wherever Layout Builder is
active:

1. Edit a page's layout in **Layout Builder**.
2. Add or configure a block whose title you want to make into a link.
3. In the block configuration form, fill in the new **URL** field the module adds.
4. Save the block, then save your layout. The block's title now renders as a link to
   the URL you entered.

Leave the URL field empty to keep the title as plain text.
