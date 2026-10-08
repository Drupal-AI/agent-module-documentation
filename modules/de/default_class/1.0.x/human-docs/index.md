# Default Class — manual setup guide

**Default Class** (`default_class`) adds informative **CSS classes** to Drupal's
rendered markup, derived from what Drupal already knows about the current page. The
goal is to give themers stable, predictable styling hooks — a class to target a
particular region, a specific node, a content type, a user, or a taxonomy term —
**without writing any preprocess code**. If you have ever added a small
`hook_preprocess_*` just to attach a class so your CSS could target something,
Default Class replaces that busywork with one module.

There is nothing to configure and no routes are added: two preprocess hooks do all
the work. On **blocks**, it adds a `block` class, the block's plugin id (except for
custom `block_content` blocks), the provider (the module that supplies the block), a
`block--REGION` class naming the region the block sits in, and a
`block--block-content--TYPE` class for custom block types. On the **page/`<html>`
element**, it adds `node-{id}` and `node-{type}` on node pages, `user-{id}` and
`user-{name}` on user pages, and `term-{id}`, `term-name-{label}`, and
`term-vid-{vid}` on taxonomy term pages. All class values are rendered safely
through Drupal's Attribute object.

With those classes in place you can, for example, style a single region, scope
styles to one specific node by its id, style every page of a content type, target a
user's pages, or theme term pages by id, name, or vocabulary — all in plain CSS.
The module has no content or access‑control role; it is purely presentational, and
it supports Drupal 8.8 through 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

There is **no configuration page** — the module works with **zero configuration**.
Once enabled, the classes appear in your markup immediately, so there is no separate
Configuration section in this guide.

## Where it lives in the admin menu

Default Class adds no admin page and no menu item. It works silently from the
moment it is enabled; you use the classes it produces from your theme's CSS.

## How to use it

Enable the module, rebuild the cache, and inspect your rendered markup — you will
see the new classes on blocks and on the page element. Then target them from your
theme's stylesheet, for example:

```css
/* Style every block in the sidebar_first region */
.block--sidebar-first { padding: 1rem; }

/* Style all pages of the "article" content type */
.node-article { font-family: Georgia, serif; }

/* Style one specific node */
.node-42 { background: #fffbe6; }
```
