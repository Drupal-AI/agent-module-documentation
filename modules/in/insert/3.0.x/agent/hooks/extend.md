<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Extending Insert (hooks)

Insert invites six hooks (documented in `insert.api.php`). Implementing them is how you add a new
*insert type* (a new kind of source widget), new *styles*, or custom rendering — exactly what the
bundled submodules do. All hooks are ordinary `hook_*` functions in your `.module`.

## The hooks

| Hook | Returns / does | Used by |
|---|---|---|
| `hook_insert_widgets()` | `['<type>' => ['<widget_plugin_id>', ...]]` — declares which widgets are Insert sources, keyed by insert type. Core Insert returns the `insert.config` `widgets` value (`file`/`image`); `insert_media` returns `['media' => ['media_library_widget']]`. | insert, insert_media |
| `hook_insert_styles($insertType)` | list of styles to offer for that type: `['<name>' => ['label' => .., 'weight' => ..]]` or `['<name>' => <ImageStyle>]`. | insert, insert_colorbox (`colorbox__*`), insert_responsive_image (`responsive_image__*`), insert_media (view modes) |
| `hook_insert_process(&$insertType, &$element)` | runs before Insert builds an element; return `FALSE` to skip, a string to descend into a multi-value sub-key, or `[]` to continue. May attach libraries and stash vars on `$element['#insert']`. | insert |
| `hook_insert_variables($insertType, &$element, $styleName, &$vars)` | add/alter template vars for a style; return `[FALSE]` to hide that style from the select box. | insert, insert_colorbox, insert_responsive_image, insert_media |
| `hook_insert_render($styleName, $vars, $insertElement)` | return a rendered template string to override Insert's built-in templates for a style. | insert (`link`/`audio`/`video`/`insert_image`), insert_colorbox |
| `hook_insert_config_form($form)` / `hook_insert_config_submit_form($form_state)` | add fields to (and save them from) the global Insert settings form. | insert_colorbox |

## Ordering gotcha

Style-provider/variable submodules use `hook_module_implements_alter()` to push their
`hook_insert_variables` (or `hook_field_widget_third_party_settings_form`) implementation **after**
Insert's own, so they see the file/vars Insert has already prepared. Follow the same pattern when
adding a submodule.

## Minimal "new insert type" recipe

1. `hook_insert_widgets()` → map your widget plugin id under a new type key.
2. `hook_insert_styles($type)` → return the styles your type offers.
3. `hook_insert_variables()` → populate the template vars per style.
4. Optionally `hook_insert_render()` for custom markup, and a `hook_theme()` template.

See the nested submodules for worked examples: `insert_media` (media view-modes as a new `media`
type), `insert_colorbox` (adds `colorbox__*` image styles + a config form), `insert_responsive_image`
(adds `responsive_image__*` styles).

## Other integration points

- **CKEditor 5**: `insert.ckeditor5.yml` ships an `insert_extend_allowed_html` plugin
  (`insert.ExtendAllowedHtml`) that keeps Insert's `<img>/<a>/<audio>/<video>` attributes
  (`data-insert-attach`, `data-insert-type`, `srcset`, `sizes`, …) from being stripped by the editor.
  Add its toolbar item / enable it on the text format's CKEditor 5 config.
- **Rotation controller**: route `insert.rotate` (`/admin/insert/rotate`, permission
  `administer nodes`) → `RotateController::rotate` backs the image rotation controls.
- **Migration**: `hook_migration_plugins_alter()` / `hook_migrate_prepare_row()` map Drupal 7 insert
  widget settings onto the new `third_party_settings.insert` structure (tag `insert`).
