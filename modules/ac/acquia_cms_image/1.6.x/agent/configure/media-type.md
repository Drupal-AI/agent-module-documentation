# The Image media type and installed config

This module has **no settings form**. Everything is shipped as config in `config/optional/` (installed when
the module and each dependency are present) plus `config/pack_acquia_cms_image*` (Site Studio packages, only
used when `acquia_cms_site_studio` is enabled). To change any of it after install, edit the config entity in
the UI or export/override with `drush config:export` / `config:set`.

## The media type

`media.type.image` — id `image`, label "Image", source plugin `image`, `source_configuration.source_field: image`,
`new_revision: true`, `queue_thumbnail_downloads: false`. Enforced dependency on `acquia_cms_image`.

## Fields on the `image` bundle

| Field | Config file | Type | Notes |
|---|---|---|---|
| `image` | `field.storage.media.image` + `field.field.media.image.image` | image | The source field. Required, translatable, `uri_scheme: public`, `file_extensions: 'png gif jpg jpeg'`, `file_directory: '[date:custom:Y]-[date:custom:m]'`, `alt_field: true` (`alt_field_required: false`), cardinality 1. |
| `field_categories` | `field.field.media.image.field_categories` | entity_reference → taxonomy `categories` | Field **instance** only; the field **storage** (`field.storage.media.field_categories`) and the `categories` vocabulary are provided by `acquia_cms_common`. |
| `field_tags` | `field.field.media.image.field_tags` | entity_reference → taxonomy `tags` | Same: instance here, storage/vocabulary from `acquia_cms_common`. |

Because `field_categories`/`field_tags` depend on config owned by `acquia_cms_common`, those field instances
and any display region referencing them only install when `acquia_cms_common` is present.

## Form displays

Two, both using the Focal Point widget and a field_group fieldset:

- `core.entity_form_display.media.image.default`
- `core.entity_form_display.media.image.media_library` (for the Media Library form mode)

Both set the `image` field widget to `image_focal_point` (offsets `50,50`, preview style `medium`, IMCE
disabled on the widget), put `field_categories` (options_select) + `field_tags` (autocomplete tags) inside a
`field_group` fieldset labelled **Taxonomy**, and hide `created`/`path`/`status`/`uid`. Requires the
`field_group`, `focal_point`, and `imce` modules.

## View displays and image styles

Twelve `core.entity_view_display.media.image.*` displays — modes `default`, `embedded`, `full`, `large`,
`large_landscape`, `large_super_landscape`, `medium`, `medium_landscape`, `small`, `small_landscape`,
`teaser`, `x_small_square`. Each renders the `image` field with the core `image` formatter, `image_loading:
lazy`, mapped to a `coh_*` image style (e.g. `full` → `coh_x_large`, `embedded` → `coh_medium`).

Eighteen image styles are installed:

- `coh_*` family (16): `coh_xx_small`, `coh_x_small`, `coh_small`, `coh_small_square`, `coh_medium`, `coh_large`,
  `coh_x_large`, plus landscape/super-landscape variants (`coh_small_landscape`, `coh_medium_landscape`,
  `coh_large_landscape`, `coh_x_large_landscape`, `coh_xx_small_landscape`, `coh_xx_large_landscape`,
  `coh_medium_super_landscape`, `coh_large_super_landscape`, `coh_x_large_super_landscape`).
- `x_small_landscape` (480×298) and `x_small_square` — installed fresh with a `focal_point_scale_and_crop`
  effect.

Plain-size styles (e.g. `coh_large` = `image_scale` to W1024) use `image_scale`; the landscape/super-landscape
crops use `focal_point_scale_and_crop` (crop_type `focal_point`). See `hooks/roles.md` for the update hook
(`_update_8001`) that converts the older `image_scale_and_crop` effects to focal-point crops.

## View modes and translation

- View modes provided by this module (`core.entity_view_mode.media.*`): `teaser`, `x_small_square`,
  `large_super_landscape`. The other referenced modes (`embedded`, `large`, `medium`, `small`, …) come from
  core/`acquia_cms_common`.
- `language.content_settings.media.image` enables content translation for the `image` bundle
  (`default_langcode: site_default`, `language_alterable: true`). Requires `content_translation`.

## Overriding

There is nothing to configure through code — adjust the shipped config entities directly. To add a field to
the type, add it as you would to any media bundle (`admin/structure/media/manage/image/fields`) and it exports
with your site config. Uninstalling the module does not remove `config/optional` objects that other modules
now depend on; the media type carries an enforced `acquia_cms_image` dependency.
