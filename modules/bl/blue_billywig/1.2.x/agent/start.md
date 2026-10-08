# Blue Billywig — agent index

Integrates core **Media** with the Blue Billywig online video platform (OVP): a `blue_billywig` media
source + `blue_billywig_id` field type/widget/formatter, browser-to-S3 uploads (Uppy), platform
search/import in the media library, playout embeds, plus content-protection and accessibility
workflows. Talks to the platform via the `bluebillywig/bb-sapi-php-sdk` library wrapped in the
`blue_billywig.client` service. Depends on core `media` (Media Library recommended).

- **Global settings form (API creds, playout, embed type, feature toggles) + status/validation** →
  [configure/settings.md](configure/settings.md)
- **Create the media type, reference field, widget & embed formatter; upload paths; CPP + a11y forms** →
  [configure/media-and-fields.md](configure/media-and-fields.md)
- **The `blue_billywig.client` service: every public method for custom code (search, load, embed,
  upload, CPP, accessibility, delete)** → [api/client.md](api/client.md)
- **Permissions** → [permissions/permissions.md](permissions/permissions.md)

Key facts:
- `configure` route `blue_billywig.settings` → `/admin/config/media/blue-billywig` (perm
  `administer blue_billywig`). Config object `blue_billywig.settings`.
- Media source id `blue_billywig` (`allowed_field_types: [blue_billywig_id]`, add form
  `MediaLibraryAddForm`). Field type `blue_billywig_id` (no UI), widget `blue_billywig_id`,
  formatter `blue_billywig_embed_code`, CPP widget `blue_billywig_cpp`.
- S3 upload routes (POST, perm `upload videos to blue_billywig s3`):
  `blue_billywig.s3.initialize_upload` / `.complete_upload` / `.abort_upload`.
- Per-media forms (perm `media.update`): `blue_billywig.request_accessibility`,
  `blue_billywig.content_protection`. Fields `field_bb_accessibility_requested`, `field_bb_cpp`
  added by update hooks 10001/10003.
- Provides permissions + config schema. No Drush commands, no plugin manager of its own.
- The S3 upload endpoints are permission-gated, search input is Solr-escaped, and no
  hardcoded secrets ship (credentials are admin-entered config). See api/client.md notes.
