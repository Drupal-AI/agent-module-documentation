# Hooks implemented

All in `iconify_icons.module`.

## `hook_icon_pack_alter(array &$icon_pack_definitions)`

The core mechanism: turns each configured collection (`iconify_icons.settings:collections`) into a
UI icon pack using the `iconify` extractor. Documented in full in
[plugins/icon-extractor.md](../plugins/icon-extractor.md). Skips collections whose pack id already
exists; calls `plugin.manager.icon_pack->processDefinition()` on each new definition.

## `hook_form_field_config_edit_form_alter()`

Only when **`ui_icons_field`** is enabled. When the field being edited exposes an
`allowed_icon_pack` setting, appends a "Add Iconify Icons Packs" link (to `iconify_icons.settings`)
to that element's `#description`, so a site builder can jump to the collection picker.

## `hook_form_alter()`

Only when **`ui_icons_text`** is enabled. On the filter-format form, if
`filters.settings.icon_embed.allowed_icon_pack` is present, appends the same
"Add Iconify Icons Packs" link to its `#description`.

Both links are produced by `_iconify_icons_get_iconify_icons_pack_link()`
(`Url::fromRoute('iconify_icons.settings', …, ['absolute' => TRUE])`).

## `hook_help()`

For route `help.page.iconify_icons`, prints an About blurb and the live **Iconify API version**
(`iconify_icons.iconify_api->getApiVersion()`).
