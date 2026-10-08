<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Layout Builder Claro is an opinionated CSS/theming module that styles Drupal's Layout Builder, its off-canvas tray, media library, and entity forms to look like the Claro admin theme when the front-end (canvas) theme is a custom theme.

---

The module ships four theme-weighted CSS libraries (`layout_builder`, `off_canvas`, `media_library`, `entity_forms`) and attaches them, together with several core Claro libraries, to every Layout Builder editing form via `hook_form_alter()` (the defaults form, overrides form, and the `layout_layout_builder_form` layout-library save form; that save form also gets a `layout-builder-form` wrapper class). On `layout_builder.*` routes it runs `hook_css_alter()` to strip out most of Claro's own CSS (keeping only a small allowlist: variables, toolbar, icon-link, dialog, media-library), the Stable/Stable9 layout-builder and off-canvas reset stylesheets, and two jQuery UI dialog stylesheets, so its own rules win without a reset fight. `hook_theme_registry_alter()` re-points several media-library view/template hooks (widget views, unformatted rows, wrapper, container, media item) at Claro's own templates so the media library inside Layout Builder renders with Claro markup. It also registers a `ServiceModifierInterface` service provider (`LbClaroServiceProvider`) that swaps core's `main_content_renderer.off_canvas` service for its own `OffCanvasRenderer` subclass; that renderer reads the single config value `lb_claro.settings:off_canvas_initial_width` (default 800) and applies it as the off-canvas dialog's initial width, giving a wider tray than core's default. There is no admin UI, no permissions, no routes, and no plugins — configuration is the one integer, set via config/drush. Requirements are Layout Builder, Claro, and Media Library (documented in the README; not hard `dependencies` in the info file).

---

- Make Layout Builder pages look like the Claro admin theme when using a custom front-end theme.
- Get a wider off-canvas tray for editing blocks/sections in Layout Builder.
- Set the off-canvas tray's initial width via configuration.
- Style the media library inside Layout Builder to match Claro.
- Style Layout Builder entity forms (defaults and overrides forms) with Claro-like cards.
- Remove Claro's conflicting CSS on Layout Builder routes so the module's styles apply cleanly.
- Remove Stable/Stable9 off-canvas reset CSS that fights with custom themes.
- Work around the CKEditor-in-off-canvas reset issue (core #2952390) by dropping the reset file.
- Give the layout-library save form the `layout-builder-form` wrapper styling.
- Theme the media library widget views (grid and table) with Claro templates.
- Theme the media library wrapper and content container with Claro markup.
- Provide a consistent admin editing experience across sites with different canvas themes.
- Attach Claro global styling and dialog libraries to Layout Builder forms automatically.
- Avoid writing custom Layout Builder CSS by dropping in a ready-made stylesheet set.
- Widen the block-configuration tray for forms with many fields.
- Match media-library exposed filters and managed-file widgets to Claro styling.
- Keep the admin toolbar and dialog visuals intact while restyling Layout Builder.
- Set a project-wide default off-canvas width in a config-management workflow.
- Override the off-canvas dialog width per environment via config split.
- Improve readability of Layout Builder forms rendered on top of a minimal custom theme.
- Standardize Layout Builder look-and-feel across a multisite where themes differ.
