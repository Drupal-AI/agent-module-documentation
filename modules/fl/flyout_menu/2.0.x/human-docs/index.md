# Flyout Menu — manual setup guide

**Flyout Menu** (`flyout_menu`) adds a responsive **off‑canvas navigation menu** — a
panel that slides in from the side of the screen when a visitor taps a toggle, and
slides back out when they close it. It is the classic "hamburger" / drawer pattern for
mobile navigation, secondary menus, filters, or any slide‑in panel you want to keep out
of the way until it is needed.

The module ships as **two blocks** you place independently:

- a **toggle block** — the open/close control you put where visitors expect it (a
  header, for example), and
- a **menu block** — the panel itself that holds your navigation.

Because they are separate blocks, you can put the toggle in one region and the panel
content in another, and reuse the pattern across regions. Flyout Menu works out of the
box with its default styling, but it was built with theme developers in mind: it comes
with front‑end libraries (CSS/JS) that animate the panel, and its templates are
overridable so you can supply your own markup.

This is a presentational navigation enhancement — it adds no content entities and no
permissions of its own beyond the standard configuration permission.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the module.
2. [Configuration](configuration/index.md) — the settings form and how to place the two
   blocks.

## Where it lives in the admin menu

The settings form is at **Configuration → User interface → Flyout Menu**
(`/admin/config/user-interface/flyout-menu`, route `flyout_menu.settings`). You place
the blocks from **Structure → Block layout**. See
[Configuration](configuration/index.md) for both.
