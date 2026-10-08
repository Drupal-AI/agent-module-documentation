# Configuring ib_dam_media

## What installs

- **Media type** `ib_dam_embed` (`media.type.ib_dam_embed`, label "IntelligenceBank Embed"),
  source `ib_dam_embed`, source field `field_media_ib_dam_embed`.
- **Source field** `field_media_ib_dam_embed` — a **link** field
  (`field.storage.media.field_media_ib_dam_embed`).
- **field_map**: `resource_title` → `name`, `resource_url` → `field_media_ib_dam_embed`.
- Default form/view displays for the media type.

## Media add flow / asset browser

- `hook_form_media_library_add_form_upload_alter()` adds an **Open IntelligenceBank Browser**
  button (ajax modal) to the core Media Library upload form.
- The button opens `/ib-dam-browser` (route `id_dam_media.asset_browser_form`,
  `MediaLibraryIbDamBrowserForm`, `_access: 'TRUE'`), which carries the current
  `media_library_state` as query args.
- The IB **embed** menu entry is removed unless `ib_dam.settings.allow_embedding` is TRUE
  (`hook_preprocess_links__media_library_menu`).

## Configuration form — source-type → media-type mapping

- Route `ib_dam_media.configuration_form` at `/admin/config/services/ib_dam/media`
  (`MediaConfigurationForm`, permission `administer intelligencebank configuration`).
- Config object **`ib_dam_media.settings`** (no `config/install`; null until saved). Schema keys:
  - `upload_location` (string) — file directory for downloaded IB files.
  - `media_types` (sequence) — each row `{ source_type, media_type }` mapping an IB asset source
    type to a local media type id.
- The form builds the mapping table from `MediaTypeMatcher::getSupportedSourceTypes()` and
  `getSupportedMediaTypes($type_id)`; on submit it stores only rows where a media type is chosen.

Set mapping via code by writing `ib_dam_media.settings:media_types` as a list of
`{source_type, media_type}` maps (see the config schema `ib_dam_media.schema.yml`).

## Field formatter

Config schema `field.formatter.settings.ib_dam_embed` extends the core link formatter settings
with `no_link` (do not wrap the embed content in a link).

## Updates

`ib_dam_media_update_8602` removed the obsolete `dialog_mode` (Stacked) Media Library setting;
the Media Library now always uses the standard dialog flow.
