<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Layout Paragraphs Theme Extension makes the Layout Paragraphs builder render paragraphs with the site's default (front-end) theme templates and optionally attach a default-theme CSS/JS library, so the editing experience matches the published output even when an admin theme is active.
---
The module implements `hook_theme_registry_alter()` (via an OOP `#[Hook]` class) that, when the `display_default_theme` setting is on, builds a theme registry for the configured default theme and copies its `paragraph`, `paragraph__<type>` (for every paragraph bundle) and any admin-listed additional template entries over the active (admin) theme's registry. A static guard prevents recursive re-entry while the default theme's registry is built through the internal `Registry` class. A second hook, `hook_element_info_alter()`, adds a pre-render callback to the `layout_paragraphs_builder` element that attaches the configured `default_theme_library` to the builder UI. The class is registered as a `TrustedCallbackInterface` for that pre-render.

Configuration is a simple `ConfigFormBase` at `/admin/config/content/layout_paragraphs/default-theme` (route + local task, permission `administer site configuration`), storing three values: `display_default_theme` (checkbox), `default_theme_library` (a theme library machine name like `mytheme/layout-paragraphs-editor`), and `additional_templates` (newline-separated template machine names). After changing settings you must rebuild caches for theme-registry changes to take effect. The library machine name and template names are trusted admin input; the module attaches the named library as-is and only copies registry entries that already exist in the default theme, so there is no arbitrary file loading from user-supplied paths. There are no runtime endpoints, mutating routes, or external calls.
---
- Enable "Display default theme in admin" at `/admin/config/content/layout_paragraphs/default-theme`.
- Make the Layout Paragraphs builder use front-end paragraph templates.
- Attach a theme editor library (e.g. `mytheme/layout-paragraphs-editor`) to the builder.
- List additional templates (node teasers, custom blocks) to load into the builder.
- Achieve visual parity between the editor and the published page.
- Scope theme CSS to the builder with the `.lp-builder` wrapper class.
- Keep an admin theme active while editing with front-end paragraph styling.
- Rebuild caches after changing settings to apply theme-registry changes.
- Pull `paragraph.html.twig` from the default theme into the editor.
- Pull `paragraph--<type>.html.twig` overrides per paragraph bundle.
- Hide contextual links inside the builder via scoped editor CSS.
- Import theme variables/typography into a builder-scoped SCSS file.
- Toggle the extension off to revert to admin-theme rendering.
- Support Drupal 11 and 12 sites using Layout Paragraphs.
- Provide editors a WYSIWYG-accurate layout preview.
- Load custom block templates into the builder via additional templates.
- Restrict configuration to users with `administer site configuration`.
- Reference a library that must exist in the default theme's `*.libraries.yml`.
- Combine with Paragraphs and Layout Paragraphs configured content types.