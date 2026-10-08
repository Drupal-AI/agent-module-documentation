<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Layout Builder Claro (lb_claro) — agent index

An **opinionated CSS/theming module**: it makes **Layout Builder**, its **off-canvas tray**,
the **media library**, and **entity forms** look like the **Claro** admin theme, even when the
front-end (canvas) theme is a custom minimal theme. Pure styling + one config value; **no admin
UI, no routes, no permissions, no plugins, no drush**.

How it works (all in `lb_claro.module` + one service provider):
- `hook_form_alter()` attaches four in-module CSS libraries plus core Claro libraries to Layout
  Builder editing forms (`OverridesEntityForm`, `DefaultsEntityForm`, `layout_layout_builder_form`);
  the layout-library save form also gets a `layout-builder-form` wrapper class.
- `hook_css_alter()` on `layout_builder.*` routes strips most Claro CSS (keeps a small allowlist),
  the Stable/Stable9 layout-builder + off-canvas reset stylesheets, and two jQuery UI dialog CSS
  files, so the module's own styles win.
- `hook_theme_registry_alter()` re-points media-library view/template hooks at Claro's own templates.
- `LbClaroServiceProvider` (a `ServiceModifierInterface`) replaces core's
  `main_content_renderer.off_canvas` service with `OffCanvasRenderer`, which sets the off-canvas
  dialog width from config `lb_claro.settings:off_canvas_initial_width` (default **800**).

- Requirements (README, not hard info-file deps): **Layout Builder**, **Claro**, **Media Library**.
- Core: `^10 || ^11`. PHP: `8.1`. Package: `Other`. License: `GPL-2.0-or-later`.
- `configure`: **null** (no settings form — set the one value via drush/config).
- Provides config schema. No permissions, no plugin types, no drush commands, no submodules.

## What you'd do → where

- **Set the off-canvas tray width / understand the off-canvas renderer decorator** →
  [configure/settings.md](configure/settings.md)
- **Understand the CSS libraries, css_alter stripping, and media-library template overrides (and how
  to override them in your theme)** → [theming/theming.md](theming/theming.md)

## Key facts (real machine names)

- Config object: `lb_claro.settings`, single key `off_canvas_initial_width` (integer, default `800`).
- Libraries (`lb_claro.libraries.yml`): `lb_claro/layout_builder`, `lb_claro/off_canvas`,
  `lb_claro/media_library`, `lb_claro/entity_forms` — each a single theme CSS file at `{ weight: 1000 }`.
- Service provider: `Drupal\lb_claro\LbClaroServiceProvider` → sets `main_content_renderer.off_canvas`
  class to `Drupal\lb_claro\OffCanvasRenderer` (extends core `OffCanvasRenderer`), adds args
  `'side'` and `@config.factory`.
- Hooks implemented: `hook_form_alter`, `hook_css_alter`, `hook_theme_registry_alter`
  (no `lb_claro.api.php` — the module invites no hooks of its own).
- Media-library theme hooks re-pointed to Claro templates: `views_view__media_library__widget`,
  `views_view__media_library__widget_table`, `views_view_unformatted__media_library`,
  `media_library_wrapper`, `container__media_library_content`, `media__media_library`.
- CSS files: `css/layout-builder.css`, `css/off-canvas.css`, `css/media-library.css`,
  `css/entity-forms.css`. Spinner images: `images/spinner-{ltr,rtl}.gif`.
