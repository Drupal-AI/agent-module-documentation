# The two fields: WYSIWYG `body` and the `ebt_settings` design options

`ebt_text` adds no field types or widgets of its own. It ships two fields on the `ebt_text` block
bundle: the required rich-text **`body`** (core `text`), and **`field_ebt_settings`** whose type,
widget, formatter and schema all belong to `ebt_core`. There is no settings page — all styling is
per-block, entered on the block's **Settings** tab.

## `body` — the rich text

| | |
|---|---|
| Field name | `body` |
| Field type | `text_with_summary` (storage `field.storage.block_content.body`, core `text`) |
| Required | **Yes** (`field.field.block_content.ebt_text.body.yml` and `ebt_text_update_9101`) |
| Form widget | `text_textarea_with_summary` (`rows: 9`, `summary_rows: 3`, `show_summary: false`) |
| View formatter | `text_default` (label hidden) |

Output security is the standard Drupal text-format model: the `text_default` formatter renders the
stored value through **`check_markup()`** with the **text format** the editor selected, so the allowed
HTML/filters are whatever that format permits. A user can only pick formats their roles are granted, so
raw-HTML injection depends on the site's format/role configuration, not on this module. The template
prints the formatter output, not the raw field value.

## `field_ebt_settings` — the shared design options

| | |
|---|---|
| Field name | `field_ebt_settings` |
| Field type | `ebt_settings` (`Drupal\ebt_core\Plugin\Field\FieldType\EbtSettingsItem`) — a single `blob`/serialized `map` column `ebt_settings`; storage owned by `ebt_core` |
| Required | No |
| Form widget | `ebt_settings_default` (`Drupal\ebt_core\Plugin\Field\FieldWidget\EbtSettingsDefaultWidget`) |
| View formatter | `ebt_settings_default` (theme `ebt_settings_default`) |
| Config schema | none in this module (`ebt_core` owns the `ebt_settings` schema) |

`ebt_text` uses `ebt_core`'s **base** widget unchanged (heavier siblings subclass it to add
component-specific knobs; this one does not). All values are stored under
`field_ebt_settings[0]['ebt_settings']['design_options']`. The widget keeps a hidden
`pass_options_to_javascript` flag **FALSE**, so a text block emits no `drupalSettings` JS options (it
only produces inline CSS via the preprocess described in
[../configure/block-type.md](../configure/block-type.md)).

### Design option keys (all under `design_options`)

Box model — **numeric only** (validated by `validateBoxElement`; non-numeric is a form error):

- `box1.{margin_top,margin_right,margin_bottom,margin_left}`
- `box1.box2.{border_top,border_right,border_bottom,border_left}`
- `box1.box2.box3.{padding_top,padding_right,padding_bottom,padding_left}`

`other_settings.*`:

| Key | Element | Default | Notes |
|---|---|---|---|
| `border_color` | textfield | — | Hex; validated by `Color::validateHex` (`validateColorElement`). |
| `border_style` | select | `solid` | solid/dashed/dotted/none/hidden/initial/inherit/double/groove/ridge/inset/outset. |
| `border_radius` | select | `none` | `none` or `1px`…`35px` (fixed list). |
| `background_color` | textfield | — | Hex; validated. |
| `background_media` | `media_library` | — | Allowed bundles: media sources `image`, `oembed:video`, `video_file` (only those that exist). |
| `background_image_style` | select | `default` | default(no repeat)/parallax/cover/contain/repeat. |
| `edge_to_edge` | checkbox | `0` | Full-viewport width. |
| `container_width` | select | `auto` | auto/xxsmall/xsmall/small/default/large/xlarge/xxlarge; description links the `ebt_core.settings` form for the pixel values. |

`other_settings.background_image_settings.*`: `background_position` (select; `custom` enables free
text), `background_position_custom` (textfield), `background_size_custom` (textfield), `addOverlay`
(checkbox), `overlayColor` (hex textfield, default `#000000`), `overlayAlpha` (number 0–1, default
`0.3`).

`other_settings.background_video_settings.*` (used only when the background media is a video):
`autoPlay`, `showControls`, `mute`, `startAt`, `opacity`, `addOverlay`, `overlayColor`, `overlayAlpha`,
`loop`, `stopMovieOnBlur`, `playOnlyIfVisible`, `coverImage` (media_library, if an `image` media type
exists), `useOnMobile`, `mobileFallbackImage` (media_library, if `image` exists).

The free-text options (`background_position_custom`, `background_size_custom`) are not validated in the
widget, but `GenerateCSS::generateFromSettings()` passes them through `Html::escape()` before writing
them into the inline `<style>`, so they cannot break out into markup.

### Assigning the widget from code

The shipped form display already assigns `ebt_settings_default`. To (re)assign it — or on another
`ebt_settings` field:

```php
\Drupal::service('entity_display.repository')
  ->getFormDisplay('block_content', 'ebt_text', 'default')
  ->setComponent('field_ebt_settings', [
    'type' => 'ebt_settings_default',
    'settings' => [],
    'third_party_settings' => [],
  ])->save();
```

Per-block values are entered on the block's **Settings** tab and saved into the block's
`field_ebt_settings` value (e.g. `design_options.other_settings.background_color = #f5f5f5`,
`design_options.box1.box2.box3.padding_top = 40`, `design_options.other_settings.container_width =
small`).
