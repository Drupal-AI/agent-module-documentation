# Video Embed Wistia — agent index

A single Wistia provider plugin for [Video Embed Field](https://www.drupal.org/project/video_embed_field).
No config UI (`configure` null), no permissions, no Drush, no services, no config schema. Depends on
`video_embed_field`. Enabling the module makes "Wistia" an available provider anywhere a Video Embed
Field is used.

- **The Wistia provider plugin — supported URL formats, embed markup, oEmbed thumbnail/title, and how to
  extend or add another provider like it** → [plugins/provider.md](plugins/provider.md)

Key facts:
- Provider plugin: `Drupal\video_embed_wistia\Plugin\video_embed_field\Provider\Wistia` (id `wistia`).
- Recognises hosts `wistia.com`, `wi.st`, `wistia.net`; extracts an alphanumeric media id.
- Embed URL: `https://fast.wistia.com/embed/iframe/{id}` with `autoPlay`/`muted` query flags.
- Thumbnail + title from oEmbed: `https://fast.wistia.net/oembed?url={input}`.
