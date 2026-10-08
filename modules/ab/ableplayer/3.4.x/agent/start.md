<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Able Player — agent index

Integrates the accessible Able Player JS player into Drupal Media. On install it auto-creates fields
on media types and sets displays; rendering is via seven field formatters + theme templates. No
settings form (`configure` null), no permissions/Drush of its own; config schema present. Depends on
core `media` + `media_library`.

- **Install-time field/display setup, the media types & fields, applying the formatters, multi-lang
  captions, remote video** → [configure/setup.md](configure/setup.md)
- **Theme hooks, templates, attached libraries (incl. CDN assets), data-attributes on the player** →
  [theming/templates.md](theming/templates.md)

Key facts:
- Formatters (`src/Plugin/Field/FieldFormatter/`): `ableplayer_video`, `ableplayer_audio`,
  `ableplayer_caption`, `ableplayer_chapter`, `ableplayer_sign_language`, `ableplayer_poster_image`,
  `ableplayer_remote_video`.
- Auto-created media fields (via `hook_modules_installed` / `_ableplayer_fields()` /
  `_ableplayer_remote_video_fields()`): on `video_file`/`audio_file` →
  `field_ableplayer_media_caption` (ref to `able_player_caption` media), `ableplayer_description`
  (vtt), `ableplayer_chapter` (vtt), `ableplayer_sign_language` (mp4), `ableplayer_poster_image`
  (jpg/png); on `oembed:video` → `ableplayer_audio_description`, `ableplayer_remote_sign_language`
  (YouTube/Vimeo URLs).
- Ships media type `able_player_caption` (source field `ableplayer_caption`, VTT) in
  `config/optional/`; multi-language captions come from translating that media entity.
- Remote formatter uses `media.oembed.url_resolver` to detect YouTube/Vimeo and extract the id.
- Libraries: `ableplayer/ableplayer` (Able Player 5.0.0 local CSS/JS + core/jquery + CDN
  js-cookie 3.0.1), `ableplayer/ableplayer-vimeo` (CDN `player.vimeo.com`).
- `hook_file_default_types_alter` registers `text/vtt` as a document type.
