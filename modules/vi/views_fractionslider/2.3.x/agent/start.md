<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# FractionSlider (fractionslider) — agent index

Integrates the **FractionSlider** jQuery plugin — a multi-layer / parallax slideshow whose
distinguishing trait is that elements *within* a slide animate independently (a heading arriving from
one direction, an image from another). The drupal.org **project** is `views_fractionslider`, but the
module it ships is **`fractionslider`** — `drush en views_fractionslider` fails; enable
`fractionslider` (and, optionally, the `views_fs` submodule). Two ways to build a slider: (1) a
**block** plugin `fractionslider_configurable_text` that renders an admin-entered HTML blob as a
slider, and (2) an optional submodule **`views_fs`** that adds a **Views style plugin** so a view's
rows become animated slides (inheriting the view's filtering, sorting, access and language handling).

The mechanism is entirely client-side. PHP emits the slider markup plus a `drupalSettings` bag and
attaches one library (`fractionslider/global-styles-and-scripts` — the vendored *jQuery Fraction
Slider v0.9.9.6* plus a Drupal behavior). `js/fractionslider.js` (`Drupal.behaviors.fractionslider`)
reads the settings and calls `$('…​.slider').fractionSlider(options)`. There are **no routes,
controllers, services, permissions, drush commands or external HTTP calls** — all configuration lives
in the block config form or the Views style options form.

- Depends on: `block` (core). The `views_fs` submodule depends on `fractionslider:fractionslider`
  (and needs core **Views** enabled to be useful — the style plugin extends `StylePluginBase`).
- Core: `^10 || ^11`. Package: `Others` (submodule package: `Views`). Version **2.3.0**.
- No dedicated settings page / `configure` route. Provides config **schema**
  (`config/schema/fractionslider.schema.yml`); no permissions, no drush, and defines **no PHP plugin
  types of its own** (it supplies one core Block plugin and one core Views-style plugin).

## What you'd do → where

- **Place / configure the ready-made slider block** → [plugins/block.md](plugins/block.md)
- **Drive an animated slider from a view + set per-field in/out animations** (the more useful half) →
  [plugins/views-style.md](plugins/views-style.md)

## Key facts (real machine names)

- Block plugin: **`fractionslider_configurable_text`** — `src/Plugin/Block/FractionsliderConfigurableTextBlock.php`,
  `admin_label` "Fractionslider Block", extends `BlockBase`.
- Views style plugin: **`views_fs`** (submodule `views_fs`) —
  `modules/views_fs/src/Plugin/views/style/ViewsFs.php`, title "Views Fractionslider",
  `theme = "views_view_views_fs"`, `display_types = {"normal"}`, `usesFields`/`usesRowPlugin` = `TRUE`,
  extends `StylePluginBase`.
- Theme hooks: `fractionslider_block` (template `fractionslider-block.html.twig`, variable `data`,
  in `fractionslider.module`); the view style renders through `views_view_views_fs`
  (template `modules/views_fs/templates/views-view-views-fs.html.twig`, preprocess
  `template_preprocess_views_view_views_fs()` in `views_fs.theme.inc`). The submodule's own
  `hook_theme()` also registers a `views_fs` hook, but the style plugin's `theme` key is what renders.
- Library: **`fractionslider/global-styles-and-scripts`** — css `css/fractionslider.css`; js
  `js/jquery.fractionslider.js` + `js/fractionslider.js`; deps `core/drupal`, `core/jquery`.
- JS behavior: `Drupal.behaviors.fractionslider` reads `drupalSettings.fractionslider` (block) and
  `drupalSettings.view_fs_fractionslider` (view), then calls jQuery `.fractionSlider()`.
- Config schema: `block.settings.fractionslider_configurable_text` → mapping `fractionslider_string`
  (type `text`). (Only that one key is in schema; the block stores several more — see plugins/block.md.)
- Block config keys: `fractionslider_string`, `fractionslider_dimensions`, `fractionslider_controls`,
  `fractionslider_pager`, `fractionslider_fullwidth`, `fractionslider_responsive`,
  `fractionslider_pausehover`, `fractionslider_increase`.
- Views style option keys: `class`, `pager`, `controls`, `views_dimensions`, `views_fullwidth`,
  `views_responsive`, `views_increase`, plus per-field
  `data-in` / `data-out` / `data-step` / `data-ease-in` / `data-ease-out` / `data-time` / `space` / `lspace`.
