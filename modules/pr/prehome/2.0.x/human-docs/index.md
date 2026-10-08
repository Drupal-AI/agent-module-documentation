# Prehome — manual setup guide

**Prehome** (`prehome`) displays a **pre-home page** — a splash, intro, or landing
screen shown before (or in place of) your site's normal homepage. It is the tool
you reach for when you want a campaign splash, a language chooser, an age gate, or
a short intro experience to greet visitors before they arrive at the front page.

Rather than hard-coding a splash template, Prehome adds a **`prehome` entity** that
you customize like any other Drupal entity — add fields, arrange its form, and
configure its display. Out of the box it ships with a single WYSIWYG field, but you
can add images, plain text, links, or whatever your splash needs. You then author
one or more prehome items as content and control when and how often they appear.

It uses a cookie (`prehome_display_count`) to track how many times a visitor has
seen the splash, so you can show it once, a limited number of times, or on every
visit. The module also provides its own permissions for managing prehome content
and settings.

One thing to keep in mind: a prehome page is **presentation, not enforcement**. If
you use it as an "age gate" or similar, treat it as a soft gate — it controls what
visitors see first, but it is not an access-control mechanism.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — set up the prehome entity's fields
   and display, author a prehome, and configure when it shows.

## Where it lives in the admin menu

Prehome spreads across a few admin locations:

- **Structure → Prehome → Settings** (`/admin/structure/prehome/settings`) — the
  entity's fields, form, and display settings.
- **Content → Prehome** (`/admin/structure/prehome`) — where you create and manage
  the prehome items themselves.
- **Configuration → Prehome** (`/admin/config/prehome/settings`) — the display
  settings that control when and where the prehome appears (the `prehome.settings_form`
  route).
