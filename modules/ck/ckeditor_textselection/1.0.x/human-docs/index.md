# CKEditor Text Selection — manual setup guide

**CKEditor Text Selection** (`ckeditor_textselection`) is a small CKEditor 5
plugin that makes the editor **keep your cursor position and text selection when
you switch between the WYSIWYG view and Source (HTML) mode** — and it scrolls the
selection back into view so you never lose your place. It brings back a
convenience that many editors remember from the popular CKEditor 4 Text Selection
plugin.

Under the hood, when you switch from WYSIWYG to Source it maps your cursor or
selection to the matching position in the raw HTML, and when you switch back it
restores it in the rich-text view. All failures are handled silently — the plugin
never crashes the editor. It depends only on core's CKEditor 5 module.

One requirement matters: this plugin only does its job when **Source Editing** is
also enabled on the text format (it works alongside the CKEditor CodeMirror Source
Editing plugin as well). Beyond enabling the plugin and Source Editing, there is
**no configuration** — it simply works once switched on.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module, and no settings to tune. Setup
is a per-format step described below.

## Where it lives in the admin menu

CKEditor Text Selection adds no admin page. You enable it per text format at
**Administration → Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`):

1. **Configure** a format that uses CKEditor 5.
2. Under **CKEditor 5 plugin settings**, enable the **Text Selection** plugin.
3. Make sure **Source Editing** is also enabled in the toolbar — Text Selection
   only takes effect when Source mode is available.
4. Save.

That is all; there is no additional configuration.
