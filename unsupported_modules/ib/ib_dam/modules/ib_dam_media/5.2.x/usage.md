IB: Media integration (`ib_dam_media`) wires IntelligenceBank DAM into Drupal's Media and Media Library, adding an `ib_dam_embed` media source/type and an in-modal IntelligenceBank asset browser so editors pick DAM assets while adding media.

---

The submodule ships a Media source plugin `ib_dam_embed` (`IbDamEmbedField`, allowed field type `link`, with a `media_library_add` form) and an installed media type of the same id whose source field is `field_media_ib_dam_embed` (a link field), mapping IB metadata (`resource_title` → name, `resource_url` → the field). It adds an **Open IntelligenceBank Browser** button to the core `media_library_add_form_upload` form (via `hook_form_..._alter`) that opens the asset browser at `/ib-dam-browser` (`id_dam_media.asset_browser_form`) in a modal; the embed option only appears when the base module's `allow_embedding` setting is on. A configuration form at `/admin/config/services/ib_dam/media` (`ib_dam_media.settings`, permission `administer intelligencebank configuration`) maps IntelligenceBank source asset types to local media types using the `ib_dam_media.media_type_matcher` service (`MediaTypeMatcher`). Downloaded/embedded assets are persisted through `MediaStorage` (an `AssetStorage` implementation) as media entities. It also provides field-formatter settings for the `ib_dam_embed` formatter. Depends on `link`, `media`, `media_library`, and the base `ib_dam`. Real use needs a configured IntelligenceBank connection.

---

- Let editors add IntelligenceBank assets from inside the core Media Library modal.
- Create `ib_dam_embed` media entities that embed IB public CDN links.
- Map IntelligenceBank image assets to a local Image media type.
- Map IB video/audio/document source types to matching local media types.
- Add an "Open IntelligenceBank Browser" button to the media add form.
- Reference embedded IB media from any entity-reference/media field.
- Store IB assets as reusable media entities rather than one-off links.
- Restrict the embed option to when embedding is enabled in ib_dam settings.
- Configure IB-source-type → media-type mapping at one admin form.
- Use the `MediaTypeMatcher` service to resolve which media type an IB asset becomes.
- Persist imported IB assets via the MediaStorage asset storage handler.
- Show embedded IB link media with the `ib_dam_embed` field formatter.
- Choose the upload location for downloaded IB files (`upload_location` setting).
- Give a marketing team self-serve access to brand assets inside Drupal's media UI.
- Keep large IB assets off Drupal by embedding CDN links as media.
- Build content that mixes local uploads and IntelligenceBank assets in one Media Library.
- Auto-populate a media entity's name from the IB resource title.
- Provide a consistent media-based workflow for DAM assets across content types.
- Migrate ad-hoc IB links into structured media via the source plugin.
- Add IntelligenceBank media to Layout Builder through a media field.
