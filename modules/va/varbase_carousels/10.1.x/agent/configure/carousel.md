# Create, place, and tune a Varbase carousel

The module has **no settings form**. Everything is standard block-content + Slick config that ships
in `config/install` and `config/optional`. There is nothing to configure globally; you author
carousels as block-content entities and (optionally) tune the shared Slick optionset.

## What ships

| Config object | Purpose |
|---|---|
| `block_content.type.varbase_carousel_block` | Block type "Carousel" (`revision: 1`). |
| `field.storage.block_content.field_media_carousel_slide` | Media reference field storage (see fields/). |
| `field.field.block_content.varbase_carousel_block.field_media_carousel_slide` | The field on the bundle, label "Carousel slides". |
| `core.entity_form_display…default` | Edit form: `info` textfield, `field_media_carousel_slide` via `media_library_widget`, `langcode`. |
| `core.entity_view_display…default` | View: renders `field_media_carousel_slide` with the **`slick_media`** formatter. Depends on `ds` + `slick`. |
| `slick.optionset.varbase_carousel` | The Slick option set the formatter uses. |
| `core.entity_view_mode.media.slick` (optional) | Media view mode "Slick carousel" (`media.slick`, `cache: true`). |
| `slick.settings` (optional) | Enables `module_css` + `slick_css`. |

## Create and place a carousel (runtime)

1. Add: `/block/add/varbase_carousel_block` — give it an `info` label and add media slides
   (image media) via the media-library widget. The field is multivalue (`cardinality: -1`).
2. Place: `/admin/structure/block` (or Layout Builder / a block region) — the block renders its
   slides through Slick using the `varbase_carousel` optionset.
3. Manage the type/fields/displays: `/admin/structure/block-content/manage/varbase_carousel_block`.

## Tune the Slick optionset

Edit `slick.optionset.varbase_carousel`. Shipped values (`slick.optionset.varbase_carousel.yml`):

- Base `options.settings`: `autoplay: true`, `autoplaySpeed: 5000`, `centerMode: true`,
  `centerPadding: 145px`, `lazyLoad: progressive`, `respondTo: slider`, `slidesToShow: 3`,
  `slidesToScroll: 3`, `swipeToSlide: true`. Top-level: `skin: default`, `breakpoints: 2`, `optimized: true`.
- Responsive overrides: `<= 480px` → `arrows: false`; `<= 766px` → `slidesToShow: 2`.

With `slick_ui` enabled, edit it in the UI at `/admin/config/media/slick`. From the CLI:

```bash
# read the current optionset
drush config:get slick.optionset.varbase_carousel

# change one nested Slick setting (e.g. slides shown at the top breakpoint)
drush config:set slick.optionset.varbase_carousel options.settings.slidesToShow 4 -y
```

The view display's `slick_media` formatter settings (in `core.entity_view_display…default`) pin
`optionset: varbase_carousel`, `view_mode: media_04_03`, `ratio: '4:3'`, `media_switch: rendered`,
`skin: default`, `label: hidden`. Point a display at a different optionset by editing that formatter.

## Install-time behavior

`varbase_carousels_install()` (in `varbase_carousels.install`) uses Vardot tooling:
`ModuleInstallerFactory::installList()`, `importConfigsFromScanedDirectory()` for
`field.storage.*` and `*settings.yml`, then `EntityDefinitionUpdateManager::applyUpdates()` and
`ModuleInstallerFactory::addPermissions('varbase_carousels')` (see permissions/). Update
`varbase_carousels_update_9001()` just re-applies entity-definition updates and clears caches.

## Config-schema note

This module ships **no** `config/schema/` directory. The shipped objects validate against schema
provided by `block_content`, `field`, core `entity_*_display`/`entity_view_mode`, and the `slick`
module (`slick.optionset.*`). So `provides_config_schema` is false.
