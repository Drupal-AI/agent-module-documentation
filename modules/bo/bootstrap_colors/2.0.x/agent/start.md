<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bootstrap Colors (bootstrap_colors) — agent index

Interactive admin color-scheme generator for **Bootstrap Barrio-based themes**. Builds a Material-Design
palette (jQuery + bundled Bootstrap color picker + TinyColor + Colour Lovers gallery) and, on save, writes the
chosen shades into the **active theme's** settings (`bootstrap_barrio_*` keys). Ships no config of its own.

- **Package:** Bootstrap. **Core:** `^9.4 || ^10 || ^11`. **License:** GPL-2.0-or-later. Version `2.0.0`.
- **Composer / module deps:** none declared in `bootstrap_colors.info.yml`. Functionally pairs with the
  Bootstrap Barrio theme + Bootstrap Library module (SASS mode). Bundles third-party JS: bootstrap-colorpicker
  (MIT), TinyColor (MIT) under `assets/`.
- **Provides:** one route, one permission, one form, one controller, one theme hook, one page-attachments hook.
  No entities, plugins, services, or config schema.

## Route & permission
- `bootstrap_colors.content` → `/bootstrap/colors` (`BootstrapColorsController::content`), title "Bootstrap Color
  Scheme Generator". Requires permission `administer bootstrap colors` (`restrict access: TRUE`). Also the
  `configure` route (info.yml) and an admin menu link under `system.admin_config_ui`.

## Key files
- `src/Controller/BootstrapColorsController.php` — renders the `bootstrap_colors` theme hook, embedding
  `ColorForm`.
- `src/Form/ColorForm.php` — the palette form; `submitForm()` writes into `<active_theme>.settings`.
- `bootstrap_colors.module` — `hook_theme()` + `hook_page_attachments_alter()` (exposes primary/accent shade in
  `drupalSettings`).
- `templates/bootstrap-colors.html.twig`, `js/bootstrap_colors.js`, `css/bootstrap_colors.css`,
  `bootstrap_colors.libraries.yml`.

## Solution docs
- [config/settings.md](config/settings.md) — install/enable, the generator page, what the form writes, and how
  it ties into Bootstrap Barrio + Bootstrap Library.
