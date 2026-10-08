# Canvas Full HTML — manual setup guide

**Canvas Full HTML** (`canvas_full_html`) gives content editors a **fuller
rich-text toolbar inside Drupal Canvas** (Experience Builder). Canvas normally
uses two locked-down text formats for its rich-text component fields, which strip
out most HTML tags and CKEditor features. This module swaps those restricted
formats for a dedicated, unrestricted `canvas_full_html` format, so editors get
bold, italic, underline, headings, links, lists, block quotes, source editing and
more — right where they build pages in Canvas.

It installs its own text format (`canvas_full_html`) and a matching CKEditor 5
configuration, then quietly substitutes that format for Canvas's restricted ones
wherever a component field expects HTML. It also smooths over a couple of Canvas
quirks: it fixes clipped toolbar dropdowns inside the Canvas React UI, and it
makes sure any contrib CKEditor 5 plugins (icon packs, plugin packs, and the like)
load in time to work inside the Canvas editor.

The whole feature is governed by a **single checkbox** — turn it on and Canvas
gets the richer editor; turn it off and Canvas falls back to its own restricted
formats. Because the enhanced format is just a normal CKEditor 5 configuration,
you can customise exactly which buttons appear without touching any other text
format on your site. It supports Drupal 10.3+ and 11, and requires Drupal Canvas
along with core's Filter, Editor and CKEditor 5 modules.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, the Canvas
   dependency, and enable the module.
2. [Configuration](configuration/index.md) — the on/off setting, editing the
   Canvas toolbar, and what to know before uninstalling.

## Where it lives in the admin menu

The one setting is at **Configuration → Content authoring → Canvas Full HTML**
(`/admin/config/content/canvas-full-html`). The text format itself — where you
tune the CKEditor toolbar — is edited among your other formats at **Configuration
→ Content authoring → Text formats and editors → Canvas Full HTML**
(`/admin/config/content/formats/manage/canvas_full_html`).

## How to use it

Enable the module and the enhanced format is on by default — Canvas WYSIWYG
component fields immediately get the fuller toolbar. If you want to change which
buttons appear, edit the `canvas_full_html` text format like any other. To turn
the whole feature off, untick the single checkbox on the settings page. After
toggling the setting, clear caches and add new component instances — existing
instances keep whichever format they were created with. See
[Configuration](configuration/index.md) for details.
