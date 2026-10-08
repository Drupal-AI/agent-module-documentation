<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Hooks

Documented in `responsive_menus.api.php`. In this Drupal 10/11 release the primary way to add a
style is a `@ResponsiveMenus` **plugin** (see plugins/styles.md); the hooks below remain for
altering and for the legacy declaration path.

## `hook_responsive_menus_styles_alter(array &$styles)`

The plugin-definition alter hook (alter id `responsive_menus_styles`, registered by the plugin
manager's `alterInfo()`). Use it to reshape any registered style — e.g. bypass a style's Libraries
module requirement, swap in your own JS/CSS files, change its settings-form callback, or add a
style definition. Runs on all plugin definitions.

## `hook_responsive_menus_style_info()`

Legacy declaration hook: return an array of style definitions keyed by id, each with `name`,
`form` (FAPI callback), `js_files`/`css_files` or `js_folder`/`css_folder`, `js_settings` callback,
`use_libraries`, `library`, and `jquery_version`. Prefer a plugin for new styles.

## `hook_responsive_menus_execute(array &$js_settings)`

Alter hook invoked in `responsive_menus_page_attachments()` right before the JS settings are
attached — lets a module tweak the per-instance settings array (keyed by execute index) that goes
into `drupalSettings.responsive_menus`.

There are **no Drush commands** in this module.
