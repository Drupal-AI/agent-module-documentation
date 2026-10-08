<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bootstrap Colors — the color-scheme generator

## Install & enable
Standard module: `drush en bootstrap_colors`. No dependencies are declared in `bootstrap_colors.info.yml`, but
it is only useful with a **Bootstrap Barrio-based (sub)theme** active, plus the **Bootstrap Library** module
configured to serve **SASS-compiled** files so Bootstrap recompiles with the variables written here. It ships
no `config/install` or `config/schema` — there is no `bootstrap_colors.settings` config object to export.

## The page
- Route `bootstrap_colors.content` → `/bootstrap/colors`, controller
  `BootstrapColorsController::content()`. It builds `ColorForm`, renders it, and passes it into the
  `bootstrap_colors` theme hook (`bootstrap_colors_theme()`), template
  `templates/bootstrap-colors.html.twig`.
- Access: permission **`administer bootstrap colors`** (`bootstrap_colors.permissions.yml`,
  `restrict access: TRUE`). Menu link `bootstrap_colors.content` sits under Configuration » User interface
  (`system.admin_config_ui`).
- Front-end assets (`bootstrap_colors.libraries.yml` → library `bootstrap_colors/bootstrap_colors`): bundled
  `assets/bootstrap_colorpicker` (MIT), `assets/tinycolor/tinycolor.js` (MIT), `js/bootstrap_colors.js`,
  `css/bootstrap_colors.css`, plus `core/drupalSettings`.

## What the JS does (client-side only)
`js/bootstrap_colors.js` (Drupal.behaviors.bootstrap_colors): reads `drupalSettings.bootstrap_colors`
(primary/accent shade, injected by `hook_page_attachments_alter()`), computes lighten/darken variations with
**TinyColor**, wires the **bootstrap-colorpicker** widgets, populates the 50–900 / A100–A700 swatch tables, and
handles the Material Design swatch grid and the **Colour Lovers** gallery. The Colour Lovers buttons fetch
palettes from `https://www.colourlovers.com/api/palettes*` via JSONP and render them into the modal. All of this
is preview/selection UI in the admin's browser; nothing is persisted until the form is submitted.

## What Save writes (server-side)
`ColorForm::submitForm()` does NOT save to a `bootstrap_colors.*` config. It resolves the **active theme**
(`theme.manager` → `getActiveTheme()->getName()`) and writes into `<active_theme>.settings` via an editable
config, then `save()`s each key:

- `bootstrap_barrio_enable_color` = TRUE
- `bootstrap_barrio_base_primary_color`   ← the form's **accent** shade value
- `bootstrap_barrio_base_secondary_color` ← the form's **primary** shade value
- `bootstrap_barrio_body_color`   ← Text color
- `bootstrap_barrio_body_bg_color` ← Body Background
- `bootstrap_barrio_h1_color` / `_h2_color` / `_h3_color` ← H1/H2/H3

Note the primary/accent values are stored swapped (primary field → `base_secondary_color`, accent field →
`base_primary_color`) — a quirk of the submit handler, not a configurable option. Form field defaults are read
back from the active theme via `theme_get_setting('bootstrap_barrio_*')`, so the page reflects the theme's
current palette. Each field is a hex textfield (`#type textfield`, `#maxlength 7`, required); the light/dark
fields are display-only (`#disabled`). The "Cancel" action is a client button.

## Operating notes
- These keys are Bootstrap Barrio theme settings; a Barrio subtheme (with Bootstrap Library in SASS mode) is
  what actually consumes them and recompiles CSS. On a non-Barrio active theme the written keys have no effect.
- To reset, edit the active theme's settings (or clear those `bootstrap_barrio_*` keys) — the module has no
  uninstall cleanup of theme settings.
- The `bootstrap_colors.settings` object read in `hook_page_attachments_alter()` (`primary_shade`,
  `accent_shade`) is never written by this module, so those `drupalSettings` values are typically null unless
  set elsewhere.
