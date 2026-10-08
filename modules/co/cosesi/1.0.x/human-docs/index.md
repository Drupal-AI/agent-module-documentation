# Color Scheme Switcher — manual setup guide

**Color Scheme Switcher** (`cosesi`) gives your Drupal 11 site a frontend
light / dark / auto mode switcher. It provides both a frontend API and a
ready‑made block that lets visitors flip between **Light**, **System (Auto)**, and
**Dark** color schemes — without a page reload — and remembers their choice.

Behind the scenes it does the careful parts for you. It injects a small inline
snippet early in the page so the correct `color-scheme` is set on `:root` before
the page paints, which minimizes the "flash of the wrong theme" that plain
dark‑mode toggles suffer from. It adds a configurable CSS class to the `<html>`
element (for example `color-scheme-dark`) so your theme can target the active
scheme with ordinary CSS selectors, and it persists the visitor's choice in
`localStorage` so it survives reloads and hard refreshes. In **Auto** mode it
follows the operating system's preference. It can also optionally hide elements
carrying a "hide class" (e.g. `color-scheme-only-dark`) when the opposite scheme is
active — useful for scheme‑specific images or banners.

The switcher is a placeable **block** with two widget styles: **Buttons** (one per
state) or a **Dropdown**. All the CSS variable names and HTML classes it uses are
configurable per active frontend theme, so it adapts to how your theme is built
rather than forcing a convention on you.

Use it when you want visitors to manually override the system color‑scheme
preference, and your frontend theme applies its styles via the CSS `color-scheme`
property or via HTML classes on `<html>`. It depends on core's `config` module.

> **Requirements to note:** the project states it needs **PHP 8.4+** and a recent
> **Drupal 11** (the module's own metadata records core `^11`, and the project page
> recommends Drupal 11.3+). It also needs a **frontend theme that actually
> responds** to the `color-scheme` property or the configured HTML classes —
> without that, the switch has nothing to change.
>
> **Known limitation:** the block does not render on batch‑process pages (e.g.
> `/batch`), because Drupal's batch system uses a minimal page that skips the
> normal block layer.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — configure the CSS variable and HTML
   classes per theme, and place the switcher block.

## Where it lives in the admin menu

- Module settings: **Configuration → Color Scheme Switcher**
  (`/admin/config/cosesi/theme-settings`).
- The switcher block is placed from **Structure → Block layout**
  (`/admin/structure/block`).
