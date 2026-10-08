# CKEditor 5 YouTube — agent index

Adds a "YouTube embed" toolbar button to CKEditor 5. Editors paste a YouTube URL; the plugin
inserts a `src`-restricted `<iframe>` (or a `<lite-youtube>` web component). Configured **per text
format** (no standalone settings page, `configure` null). No permissions, no Drush. Depends on core
`ckeditor5`. Provides config schema for its per-format settings.

- **Enable it on a format, the allowed-attributes config, the src allow-list / allowed elements, and
  the lite-youtube component** → [configure/plugin.md](configure/plugin.md)

Key facts:
- CKEditor5 plugin `ckeditor5_youtube_embed_youtubeembed`, toolbar item `youtubeEmbed`, PHP class
  `src/Plugin/CKEditor5Plugin/Youtube.php`.
- Always-allowed: `<iframe src="https://www.youtube.com/* https://youtube.com/* https://m.youtube.com/*">`
  and `<lite-youtube ...>`. Optional iframe attributes are admin-selectable.
- Settings key `enabled_optional_attributes` (schema
  `ckeditor5.plugin.ckeditor5_youtube_embed_youtubeembed`); deprecated attrs (align, frameborder,
  longdesc, scrolling) are off by default.
- `hook_page_attachments` attaches library `ckeditor5_youtube/lite-youtube` on every page so
  `<lite-youtube>` embeds render on the front end.
