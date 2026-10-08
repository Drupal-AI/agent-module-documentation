# Settings and thumbnail previews

The module has one settings page controlling optional local thumbnail generation. Everything else is
configured per media type (source field / displays) or per field-widget and formatter.

## Settings route and config

- Route: **`media_entity_remote_image.settings`** — path
  `/admin/config/media/media-entity-remote-image-settings`, form
  `Form\SettingsForm` (`ConfigFormBase`), requirement `_permission: 'administer site configuration'`.
  Menu link under `system.admin_config_media` (`Media Remote Image settings`). Declared as the
  module's `configure` route in `.info.yml`.
- Config object: **`media_entity_remote_image.settings`** (schema
  `config/schema/media_entity_remote_image.schema.yml`, install defaults in
  `config/install/media_entity_remote_image.settings.yml`).

| Config key | Type | Default | Meaning |
|---|---|---|---|
| `generate_thumbnails` | boolean | `false` | When on, fetch the remote image on media save and store a local thumbnail preview. |
| `thumbnail_image_style` | string | `media_library` | Image style used for the stored preview; the special value `_original` (`MEDIA_ENTITY_REMOTE_IMAGE_ORIGINAL_IMAGE`) stores an unscaled copy. |
| `local_images` | string | `public://remote_image_thumbnails` | Base directory for stored thumbnails (no UI field; edit via config). |

The settings form only exposes `generate_thumbnails` and `thumbnail_image_style`; the style select is
built from `ImageStyle::loadMultiple()` plus an "Original image" option, defaulting via
`_media_entity_remote_image_get_thumbnail_image_style()` (configured style → `media_library` →
`medium` → first available style).

## Thumbnail generation flow

When `generate_thumbnails` is **true**, `hook_ENTITY_ID_presave(media)`
(`media_entity_remote_image_media_presave()` in the `.module`) fetches the stored URL with
`\Drupal::httpClient()->request('GET', …, [TIMEOUT => 15])`, derives an extension from the URL or the
response `Content-Type`/MIME (`_media_entity_remote_image_get_extension*`), writes the bytes under
`{local_images}/{style}/…` (or `{local_images}/original/…`), applies the configured image style via
`ImageStyle::createDerivative()`, sets the media `thumbnail` field, and records its width/height with
`getimagesize()`. It skips the re-fetch when the source URL is unchanged and the existing thumbnail
already matches the configured style. Failures are logged and surfaced with a messenger error but do
not block the save (the full image can still render from its URL).

When `generate_thumbnails` is **false** the media keeps the module's default icon
(`remote-image.png`) as its thumbnail; the resource fetch that runs on save (validation + metadata)
still happens but no local file is written.

## Related hooks

- `hook_page_attachments()` — attaches `media_entity_remote_image/admin` (css/admin.css) on admin
  routes.
- `hook_form_media_remote_image_edit_form_alter()` — appends `_force_update_media_name` so the media
  name entered on the edit form is preserved after presave.
- `hook_media_source_info_alter()` — registers the Media Library add form (see
  [plugins/media-source.md](../plugins/media-source.md)).
- `hook_uninstall()` deletes all `remote_image_url` field storages; `hook_requirements('install')`
  checks the media icon directory is writable.
