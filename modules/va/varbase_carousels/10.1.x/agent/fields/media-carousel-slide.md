# The carousel-slides field, widget & formatter

The module does not define a new field TYPE — it attaches one core entity-reference field to the
`varbase_carousel_block` block-content bundle and wires a widget + Slick formatter via display config.

## Field storage — `field.storage.block_content.field_media_carousel_slide`

| Key | Value |
|---|---|
| `field_name` | `field_media_carousel_slide` |
| `entity_type` | `block_content` |
| `type` | `entity_reference` (`module: core`) |
| `settings.target_type` | `media` |
| `cardinality` | `-1` (unlimited slides) |
| `translatable` | `true` |
| `locked` | `false` |

## Field instance — `field.field.block_content.varbase_carousel_block.field_media_carousel_slide`

| Key | Value |
|---|---|
| `bundle` | `varbase_carousel_block` |
| `label` | "Carousel slides" |
| `required` | `false` |
| `settings.handler` | `default:media` |
| `settings.handler_settings.target_bundles` | `image` (only the `image` media type is selectable) |
| `settings.handler_settings.auto_create` | `false` |

Depends on config `media.type.image`, so the site must have the `image` media type (Varbase Media
supplies it).

## Widget (form display)

`media_library_widget` (core Media Library) with `media_library_edit` third-party setting
`show_edit: "1"`, so editors can add and edit media inline from the block add/edit form. The `info`
field uses `string_textfield`; `langcode` uses `language_select`.

## Formatter (view display)

`slick_media` (provided by the **slick** module's `SlickMediaFormatter`). Notable settings:
`optionset: varbase_carousel`, `view_mode: media_04_03`, `ratio: '4:3'`, `media_switch: rendered`,
`skin: default`, `label: hidden`, `lazy` empty (Slick's own `lazyLoad: progressive` from the
optionset applies). The view display also depends on the `ds` module.

## Change it

Add/remove slide media types by editing the field's `handler_settings.target_bundles`
(`/admin/structure/block-content/manage/varbase_carousel_block/fields`). Swap the render style by
editing the `slick_media` formatter (optionset, view mode, ratio) on the block-content view display.
