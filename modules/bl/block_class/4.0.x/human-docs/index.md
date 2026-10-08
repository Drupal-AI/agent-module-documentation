# Block Class — manual setup guide

**Block Class** (`block_class`) lets you add custom CSS classes — and, optionally,
other HTML attributes and a custom HTML `id` — to any block directly from that
block's configuration form. Instead of writing a preprocess function or a Twig
template override to get a hook for your styles, you type a class such as `hero`
or `bg-dark` into the block's config form and Block Class adds it to the block's
wrapper markup at render time. This lets themers and site builders target
individual blocks with predictable selectors, without touching code.

Block Class extends core's **Block** module, so it works with any block placed in
your theme's regions. A single settings page controls how the class field
behaves site-wide, and every block's configuration form gains a **CSS class(es)**
field once the module is enabled.

This guide is written for a **human** clicking through the admin UI. It walks you,
step by step and with screenshots, from installing the module to configuring its
global options and adding a class to a block. If you are looking for terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

![The Block Class Settings page](images/settings.png)

## Where it lives in the admin menu

The module's global options sit under **Configuration → Content authoring →
Block Class → Settings**
(`/admin/config/content/block-class/settings`). That page is organised into tabs:

- **Settings** (`/admin/config/content/block-class/settings`) — the global
  options that control the class field, covered in this guide.
- **Block List** — an admin list of blocks showing which ones carry classes or
  attributes.
- **Bulk Operations** — a tool to add, rename, or delete a class or attribute
  across many blocks at once.
- **Help** — the module's built-in help text.

The class, ID, and attribute fields themselves are not on this page — they appear
on each individual block's own configuration form.

## Contents

1. [Installation](installation/index.md) — install Block Class with Composer and
   enable it.
2. [Configuration](configuration/index.md) — tune the global settings that control
   the class field, then add a class to a block.
