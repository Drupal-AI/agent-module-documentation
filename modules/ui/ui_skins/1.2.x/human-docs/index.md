# UI Skins — manual setup guide

**UI Skins** (`ui_skins`) lets a theme expose editable design tokens — brand
colors, spacing, font sizes, radii — as **CSS custom properties** ("CSS
variables") that a site administrator can change from the admin UI without ever
touching a stylesheet. A theme (or a module) declares each variable in a small
YAML file; UI Skins then shows those variables on a per‑theme settings screen and
injects the chosen values into an inline `<style>` block on every page.

Alongside variables, the module supports **themes** — better thought of as
"skins": named presets that toggle a `class` (or any attribute) on the `<body>`
or `<html>` element, optionally attach a CSS/JS library, and can chain to other
presets. That is how you build, say, a light/dark toggle or a "compact" layout
mode that an admin picks from a dropdown.

Everything is gated by core's **Administer themes** permission — there is no
permission, Drush command, or service of its own beyond the two plugin managers.
It requires **PHP 8.3** and **Drupal 11.4+ / 12**, and it has no third‑party
dependencies. Nothing is configured until a theme actually ships variable or skin
plugins, so on its own the module is inert until you (or your theme) declare some.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the per‑theme CSS variables screen
   and the skin selector, field by field, plus where values are stored.

## Where it lives in the admin menu

Once enabled, UI Skins adds a **CSS variables** overview under
**Appearance** (`/admin/appearance/css-variables`) that lists your installed
themes. Each theme that declares at least one variable gets its own settings
screen at `/admin/appearance/css-variables/{theme}`. The skin selector, by
contrast, is added to each theme's regular settings form at
**Appearance → Settings → {theme}** (`/admin/appearance/settings/{theme}`).

## How to use it

For the module to do anything, a variable or skin must be declared in YAML. Those
files live in a theme (or module) root and are named
`{provider}.ui_skins.css_variables.yml` and `{provider}.ui_skins.themes.yml`. A
CSS variable entry gives an id (the id becomes the property name — `color_primary`
→ `--color-primary`), a form widget `type` (`textfield`, `color`, or the module's
own `ui_skins_alpha_color` RGBA picker), a label, an optional `category` that
groups fields into vertical tabs, and `default_values` keyed by "scope" (a CSS
selector such as `:root`). A skin entry gives a label, a `target` of `body` or
`html`, the attribute `key` (default `class`) and `value`, an optional `library`,
and optional `dependencies` on other skins. Authoring those YAML files is a
theming task covered in the [`agent/`](../agent/start.md) docs; this human guide
covers installing the module and using the admin screens those plugins produce.
