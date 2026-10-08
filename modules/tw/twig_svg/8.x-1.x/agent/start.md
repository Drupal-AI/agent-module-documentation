<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Twig svg (twig_svg) — agent index

Adds a Twig function, **`icon()`**, that emits an inline SVG *reference* — `<span class="icon__wrapper"><svg ...><use xlink:href="#NAME"></use></svg></span>` — so a template can drop in an icon from an SVG sprite by its symbol id. The function itself reads no file: it only builds a render array (`#theme => 'twig_svg'`) whose `#name` becomes the `<use xlink:href="#NAME">` fragment. For that reference to resolve, the SVG **sprite** (a document of `<symbol id="…">` entries) must already be present in the page.

The module puts the sprite there in `hook_preprocess_html()`: for every path listed in the `icon_locations` config (set on the admin settings form, one path per line, relative to the site root) and for `{theme}/images/icons.svg` of the active theme plus each of its base themes, it reads the file and appends its contents to `page_bottom` as a hidden `<span>`. So the typical setup is: build a sprite into your theme's `images/icons.svg` (or list its path in config), then call `icon('arrow')` wherever you need it.

- Depends on: nothing (no `dependencies` in info.yml). Core: `^10 || ^11`. Package: `Others`.
- Settings page: yes — route `twig_svg.settings_form` at `/admin/config/twig_svg/config` (menu link under *Configuration › System*), gated by the permission `administer twig svg configuration`. One config key: `twig_svg.settings:icon_locations`.
- Provides: 1 Twig function (`icon`), 1 theme hook (`twig_svg`) with a template, 2 services, 1 permission, config schema. No drush, no plugin types, no fields, no dependencies.

## What you'd do → where

- **Call `icon()` in a template / understand its arguments, the theme hook and template** → [api/twig-function.md](api/twig-function.md)
- **Make icons resolve — provide the sprite (config `icon_locations` or theme `images/icons.svg`), the settings form, the permission** → [configure/settings.md](configure/settings.md)

## Key facts (real machine names)

- Twig function: `icon($name, $title = '', array $classes = [], array $attributes = [], array $wrapper_classes = [])` — callback `Drupal\twig_svg\TwigExtension\TwigSvg::getInlineSvg` → `Drupal\twig_svg\TwigSvgHelper::buildSvg`.
- Services: `twig_svg.twig.extension` (`…\TwigExtension\TwigSvg`, tagged `twig.extension`), `twig_svg.twig_svg_helper` (`…\TwigSvgHelper`).
- Theme hook: `twig_svg` (variables: `classes`, `attributes`, `title`, `name`, `wrapper_classes`); template `templates/twig-svg.html.twig`.
- Hooks implemented: `hook_theme` (`twig_svg_theme`), `hook_preprocess_html` (`twig_svg_preprocess_html` — injects sprite files into `page_bottom['icons']`).
- Route: `twig_svg.settings_form` → `/admin/config/twig_svg/config`, form `Drupal\twig_svg\Form\TwigSvgSettingsForm`, `_permission: 'administer twig svg configuration'`, `_admin_route: TRUE`. Menu link `twig_svg.settings_form` (parent `system.admin_config_system`).
- Permission: `administer twig svg configuration`.
- Config: object `twig_svg.settings`, key `icon_locations` (string; newline-separated paths relative to site root). Schema `config/schema/twig_svg.schema.yml`.
- Theme convention: `{active_theme + base themes}/images/icons.svg` is auto-inlined when present.
