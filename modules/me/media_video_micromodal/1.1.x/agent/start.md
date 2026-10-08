# Media Video Micromodal — agent index

One field formatter that renders core Media **remote (oEmbed) videos** in a micromodal.js popup,
triggered by a thumbnail, custom thumbnail, media name, caption, or custom link text. Attach it on a
`media` type's *Manage display*. Depends on core `media`. No config page (`configure` null), no
permissions, no Drush. Provides a config schema for the formatter settings.

- **The formatter: which field types it applies to, every setting, the oEmbed iframe URL it builds,
  templates, libraries (unpkg CDN), CKEditor/Views use** → [configure/formatter.md](configure/formatter.md)

Key facts:
- Formatter id `micromodal_field_formatter`, field types `string`, `image`, `entity_reference`; only
  usable on `media` entities (see `isApplicable()`).
- Needs the media type to have `field_media_oembed_video` (core `remote_video`).
- Settings (schema `field.formatter.settings.micromodal_field_formatter`): `string_classes`,
  `link_text`, `caption_swap`, `thumbnail_image_style`.
- Modal iframe `src` is a signed core `media.oembed_iframe` URL rebuilt via `IFrameUrlHelper` +
  `PrivateKey`, not the raw remote URL.
- Libraries: `micromodal` (external `https://unpkg.com/micromodal@0.4.10`), `micromodal_libraries`
  (init + css), `caption_swap` (only attached when Caption Swap is on).
- Theme hook `media_video_micromodal` with suggestions `__{entity_type}_{bundle}[_{view_mode}]`.
