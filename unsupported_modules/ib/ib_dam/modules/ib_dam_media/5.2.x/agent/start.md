# IB: Media integration (ib_dam_media) — agent index

Submodule of `ib_dam`. Adds an `ib_dam_embed` **media source/type** and an IntelligenceBank
**asset browser** inside the core Media Library. Depends on `link`, `media`, `media_library`,
`ib_dam`.

- **The media type, source field, the config/mapping form, and the asset browser** →
  [configure/media.md](configure/media.md)
- **The `ib_dam_embed` media source, MediaTypeMatcher, and MediaStorage** →
  [api/media-source.md](api/media-source.md)

Key facts:
- Media source & type id `ib_dam_embed`; source field `field_media_ib_dam_embed` (a `link` field).
- Config object `ib_dam_media.settings` (keys: `upload_location`, `media_types` mapping). Form
  `/admin/config/services/ib_dam/media` (route `ib_dam_media.configuration_form`, permission
  `administer intelligencebank configuration`). No config ships by default.
- Asset browser route `id_dam_media.asset_browser_form` → `/ib-dam-browser` (`_access: 'TRUE'`);
  the "Open IntelligenceBank Browser" button is added to `media_library_add_form_upload`.
- Embed option is hidden unless base `ib_dam.settings.allow_embedding` is TRUE.
- Services: `ib_dam_media.media_type_matcher` (`MediaTypeMatcher`). Storage: `MediaStorage`.
