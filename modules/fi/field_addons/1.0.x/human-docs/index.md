# Field Addons — manual setup guide

**Field Addons** (`field_addons`) is a small collection of extra field
enhancements — additional formatters, widgets, and behaviours that supplement
Drupal core's field tooling. The project is designed to grow over time; today it
ships a focused set of features aimed at improving how fields are entered and
displayed.

Its current highlights:

- A **Plain Text HTML Formatter** that lets you choose which HTML tag wraps
  plain‑text field content — one of `h1`, `h2`, `h3`, `h4`, `h5`, `h6`, `span`, or
  `div` — so you can give plain text a semantic wrapper without a custom template.
- A **Select2 widget** (via the `field_addons_select2` submodule) that turns a
  plain select list into a nicer, searchable dropdown, which is a real help on
  fields with many options.

It is a content‑editing / fields feature: it affects how fields are entered and
shown, not access. You enable the sub‑features you want and configure them on the
relevant field's *Manage form display* (widgets) or *Manage display* (formatters).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   base module plus any submodule you want.

There is **no central settings page** — everything is configured per field, as
described in "How to use it" below.

## How to use it

- **To wrap plain text in a chosen HTML tag:** go to **Structure → (content type or
  bundle) → Manage display**, and set the field's formatter to the **Plain Text
  HTML Formatter**, then pick the tag (`h1`–`h6`, `span`, or `div`) in the
  formatter settings (gear icon).
- **To use the searchable Select2 dropdown:** enable the `field_addons_select2`
  submodule (see [Installation](installation/index.md)), then go to **Manage form
  display** for the bundle and choose the Select2 widget for the relevant list
  field.

If you have used the [Fences](https://www.drupal.org/project/fences) module, the
Plain Text HTML Formatter will feel familiar — Field Addons lists Fences as a
project with similar wrapper functionality.
