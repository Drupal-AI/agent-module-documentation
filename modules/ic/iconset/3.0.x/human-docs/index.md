# Iconset — manual setup guide

**Iconset** (`iconset`) provides tools for managing and organizing icons into
reusable **sets**, so the same curated collection of icons is available across
your site — in menus, in embedded content, and on fields. It supports SVG
symbols (sprites) and glyph/font icons, and the range of icon types it can
handle is extendable through icon‑handler plugins.

The base module learns about your icons from a small `*.iconset.yml` file that a
module or theme provides, which names the assets in each set and the handler
plugin that renders them. Once Iconset knows about a set, its icons become
selectable through form elements and usable on entities and menu items. Two icon
handlers ship in the box — one for SVG files (`svg`) and one, still in
development, for SVG font files (`svg_font`).

Three optional submodules extend it: **Iconset Custom** (`iconset_custom`) lets
icon sets be declared without editing a YAML file, **Iconset Embed**
(`iconset_embed`) helps place icons in embedded content, and **Iconset Menu**
(`iconset_menu`) adds icons to menu items. Iconset lives in the Media package and
has no dependencies beyond core.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and pick the submodules you need.
2. [Configuration](configuration/index.md) — the Iconset settings page and how
   icon sets are declared and used.

## Where it lives in the admin menu

Iconset adds a settings form (the `iconset.settings` route) under
**Configuration**, in the Media group. That is where you review the icon sets the
site knows about; the sets themselves are declared by modules/themes (or via the
`iconset_custom` submodule) and then used on menus, embeds, and fields. See
[Configuration](configuration/index.md).
