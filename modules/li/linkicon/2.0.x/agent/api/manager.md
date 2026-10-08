<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `linkicon.manager` service, hooks & mechanism

## Service `linkicon.manager` → `Drupal\linkicon\LinkIconManager`

Implements `LinkIconManagerInterface`. Constructor args: `@config.factory`, `@module_handler`.
Procedural shortcut `linkicon()` returns it.

Public methods:

- `getSetting($setting_name)` — read a value from `linkicon.settings`.
- `extractAllowedValues($values, $is_tooltip = FALSE): array` — parse the `key|value[|tooltip]`
  allowed-titles text into an options array (keys = icon suffix, values = labels/tooltips). This is
  what turns the field's `title_predefined` text into the widget `<select>` options.
- `libraryInfoBuild(): array` — builds a dynamic library from `linkicon.settings:font`
  (backs `hook_library_info_build`).
- `simplifySettings(array $settings): array` — trims formatter settings down to the non-default ones.

Constant: `LinkIconManagerInterface::LINKICON_PREDEFINED = 5` (the field `title` value that enables
predefined titles).

## Hooks the module implements (why it works without a field type)

- `hook_field_info_alter()` — swaps the `link` field-type class to `Drupal\linkicon\LinkIconItem`,
  which adds the *Predefined* option and its `title_predefined` setting to the link field.
- `hook_field_widget_single_element_link_default_form_alter()` — when *Predefined* is enabled,
  converts the link widget's Title textfield into a `<select>` of the allowed values and attaches
  `LinkIconItem::elementValidateLinkIcon` validation.
- `hook_preprocess_field()` — adds `label_class` to title attributes.
- `hook_theme()` — registers `linkicon` and `linkicon_item` templates (`linkicon.theme.inc`,
  `templates/*.html.twig`).
- `hook_library_info_build()` — exposes the configured icon-font CSS as a library.

## Rendering

`LinkIconFormatter` (extends core `LinkFormatter`) builds, per link, an icon class of
`linkicon_prefix` + `-` + the predefined key (e.g. prefix `icon` + key `facebook` → `icon-facebook`)
and wraps text/icon per the formatter settings. No icons ship with the module — it emits classes
only, so a font (FontAwesome/Fontello/custom) must provide the glyphs.
