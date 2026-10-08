<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Sticky — agent index

Makes one site-wide element stay visible on scroll by applying the **garand/sticky** jQuery
plugin to a **DOM selector** you configure. One global settings form; the chosen selector +
options are stored in `sticky.settings` and pushed to `drupalSettings.sticky` on every page.
Targets Drupal core `^11 || ^12`.

- **All settings keys, defaults, config name, route/permission, how it attaches, the external library** →
  [configure/settings.md](configure/settings.md)

Key facts:
- Config object: **`sticky.settings`** (schema in `config/schema/sticky.schema.yml`). Admin form:
  `/admin/config/system/sticky` (route `sticky.sticky_settings_form`, permission
  `administer sticky`). `configure` = `sticky.sticky_settings_form`.
- The **`selector`** key (default `.menu--main`) chooses which element becomes sticky. It is
  global — one selector for the whole site; no per-page/per-block UI.
- Other keys: `top_spacing` (0), `bottom_spacing` (0), `class_name` (`is-sticky`),
  `wrapper_class_name` (`sticky-wrapper`), `center` (false), `get_width_from` (''),
  `width_from_wrapper` (true), `responsive_width` (false), `z_index` (`auto`).
- Delivery: `StickyHooks::pageAttachments()` (`hook_page_attachments`, `src/Hook/StickyHooks.php`)
  → `StickyManager::getJsSettings()` → `drupalSettings.sticky` + attach `sticky/sticky` library,
  which needs the external file `/libraries/sticky/jquery.sticky.js` (download garand/sticky
  yourself, or via composer with `composer/installers`).
- No plugins, no Drush, no module dependencies. `hook_help` renders README on `help.page.sticky`.
