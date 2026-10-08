# Choices.js — manual setup guide

**Choices.js** (`choices`) brings the lightweight, jQuery-free
[Choices.js](https://github.com/Choices-js/Choices) JavaScript library to Drupal,
turning plain `<select>` drop-downs into searchable, tag-style selects. Long
option lists become type-to-filter, multi-value selects gain removable "chips",
and the whole thing looks and feels far nicer than a native select — a good
modern alternative to Select2 or Chosen.

There are two independent ways to use it, both controlled from one settings page:

- **Global mode** attaches Choices to every `<select>` that matches a list of CSS
  selectors you configure (the default is `select[multiple]`). You can scope it to
  admin pages, front-end pages, or both. This is the quickest way to enhance
  selects site-wide without touching any field configuration.
- **Field-widget mode** gives you a **Choices** widget you can pick on
  *Manage form display* for entity-reference and List (text/integer/float) fields,
  so only that one field is enhanced. Each widget instance can carry its own
  options.

Both modes accept a block of **Choices options** entered as JSON (for example
`removeItemButton`, `searchFields`, or `allowHTML`), so you can fine-tune the
behaviour. When both apply to the same field, the per-field widget options win,
then the global options, then the library's own defaults.

Choices needs the actual Choices.js library present — either self-hosted under
`/libraries/choices.js/` or loaded from the jsDelivr CDN via a checkbox in the
settings. An optional submodule, **Choices Facets** (`choices_facets`), exposes
Choices as a widget for the Facets module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   provide the Choices.js library, and enable it.
2. [Configuration](configuration/index.md) — the settings page, global vs.
   widget mode, JSON options, and the CDN toggle.

## Where it lives in the admin menu

The settings page is at **Configuration → User interface → Choices**
(`/admin/config/user-interface/choices`).
