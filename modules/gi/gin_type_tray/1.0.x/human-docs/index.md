# Gin Type Tray — manual setup guide

**Gin Type Tray** (`gin_type_tray`) restyles the **Type Tray** module's
content-creation screen so it matches the **Gin** administrative theme — including
full dark-mode support.

Type Tray turns Drupal's plain `/node/add` list into a categorized "tray" of
content-type cards, which is great for editors but ships with styling aimed at the
Claro theme. On a site that uses Gin, that can look out of place. Gin Type Tray is
a pure presentation-layer bridge that closes the gap: it swaps Type Tray's
templates and stylesheet for Gin-aware versions built on Gin's own CSS custom
properties, so the "choose a content type" screen visually belongs to Gin in both
light and dark mode. It even inlines the content-type SVG icons so they recolor
with the theme, and replaces Type Tray's default icon with a Gin-styled document
icon.

Because it's a theming bridge, all the actual content-type grouping, icons,
descriptions, and thumbnails still come from **Type Tray's own configuration**
(set on each content type). Gin Type Tray only changes how that output looks — it
doesn't add any settings of its own.

**There is nothing to configure.** Enabling the module — with the Type Tray module
present and the Gin theme active — is the entire setup. It carries no settings
page, permissions, entities, or Drush commands.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the Gin theme, Type Tray, and
   this module with Composer, then enable them.

## Where it lives in the admin menu

Gin Type Tray has **no settings page**. Its effect shows up on the content-creation
screen at **Content → Add content** (`/node/add`) — that page now renders with
Gin's styling. The categories and icons shown there are configured on each content
type via Type Tray (under **Structure → Content types → (edit a type)**), not here.

## How to use it

1. Make sure the **Type Tray** module is enabled and configured (assign your
   content types to categories, and optionally give them icons/thumbnails, on each
   content type's edit form).
2. Make sure the **Gin** theme is set as your **administration theme** at
   **Appearance** (`/admin/appearance`). The Gin styling only applies while Gin is
   the active admin theme.
3. Enable Gin Type Tray (see [Installation](installation/index.md)).
4. Visit **Content → Add content** (`/node/add`) — the Type Tray screen now matches
   Gin, with dark mode and recolored icons. No further configuration is needed.
