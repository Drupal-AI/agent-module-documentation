# Integrations & extension points

The module is mostly a CKEditor 5 plugin, plus a legacy dialog form alter and a CKEditor 4→5
upgrade path. There is no public service or hook API to call.

## Editor link dialog form alter

`editor_advanced_link.module` implements
`hook_form_editor_link_dialog_alter()` (`editor_advanced_link_form_editor_link_dialog_alter`).
It adds `title`, `aria-label`, `class`, `id`, `target` (checkbox, `_blank`) and `rel` fields to
the classic link dialog, grouping the last four under an **Advanced** details element. Each
field's `#access` is computed from the format's HTML restrictions: a field shows when the
filter is disabled, when the whole `<a>` tag is allowed, or when that specific attribute is
allowed on `<a>`. A `#validate` callback (`_editor_advanced_link_attributes_validate`) strips
empty attribute values so no empty attributes are written to markup.

## Linkit compatibility

`editor_advanced_link_form_linkit_editor_dialog_form_alter()` delegates to the same alter, so
the advanced fields also appear in Linkit 5.x's editor dialog. The Editor File module reuses
`editor_link_dialog` as its base form id, so its dialog picks up the fields too.

## CKEditor 4 → 5 upgrade

`src/Plugin/CKEditor4To5Upgrade/AdvancedLink.php` (plugin id `editor_advanced_link`) maps the
old CKEditor 4 configuration to the CKEditor 5 `editor_advanced_link_link` plugin during the
core upgrade path, so existing sites keep their advanced-link behavior after upgrading.

## Extending the attribute set

The supported attributes are fixed in the plugin class constant
`AdvancedLink::SUPPORTED_ATTRIBUTES` (`aria-label`, `title`, `class`, `id`, `target`, `rel`).
Adding a new attribute requires subclassing/overriding the plugin (both the PHP plugin and the
JS build in `js/ckeditor5_plugins/editorAdvancedLink/`); there is no config hook for it.

## Libraries

- `editor_advanced_link/ckeditor5` — the CKEditor 5 build (`js/build/editorAdvancedLink.js`),
  depends on `ckeditor5/ckeditor5` and `ckeditor5/ckeditor5.link`.
- `editor_advanced_link/editor_advanced_link` — JS for the classic dialog, attached by the
  form alter.
