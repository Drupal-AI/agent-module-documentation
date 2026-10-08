# Curated Colors — manual setup guide

**Curated Colors** (`curated_colors`) replaces free‑form color pickers and plain
select lists with a visual swatch popover backed by **named, reusable palettes**.
Editors choose from an approved set of colors — organized into groups, with a live
preview — rather than typing arbitrary hex values. It works on standard Drupal
entities through a field, and on **Drupal Canvas** components.

The clever part is what gets stored. A field saves the color **key**
(`brand-primary`), not the hex value (`#0678be`). The actual color lives in your
stylesheet, so a brand refresh becomes a CSS change instead of a content
migration. Palettes themselves are **config entities**, so they are exportable and
tracked in git like any other configuration.

The module needs setup before editors can use it: you define one or more palettes,
then add a **Curated color** field (or annotate a Canvas component prop) that
points at a palette. It provides its own permissions and ships an example
submodule (`curated_colors_example`) with a sample palette, a working
Single‑Directory Component, and a CSS‑class example showing the full pattern
end‑to‑end. It requires no third‑party libraries.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and optionally turn on the example submodule.
2. [Configuration](configuration/index.md) — create and manage palettes, then add
   a Curated color field or wire it into a Canvas component.

## Where it lives in the admin menu

Palettes are managed at **Configuration → Content authoring → Curated Colors**
(`/admin/config/content/curated-colors`), which is the module's configure route
(`entity.curated_color_palette.collection`). Fields are added on each entity
bundle's **Manage fields** screen as usual.
