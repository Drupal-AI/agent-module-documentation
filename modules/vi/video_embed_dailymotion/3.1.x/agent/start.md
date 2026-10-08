# Video Embed Dailymotion — agent index

A single [Video Embed Field](https://www.drupal.org/project/video_embed_field) provider plugin
for Dailymotion. No config page (`configure` null), no permissions, no schema, no Drush, no
submodules. Depends on `video_embed_field`. Enabling it makes "Dailymotion" a selectable
provider on any `video_embed_field`; all dimensions/autoplay/thumbnail settings come from Video
Embed Field itself.

- **The provider plugin: accepted URL patterns, iframe/embed output, thumbnail & oEmbed title** →
  [api/provider.md](api/provider.md)

Key facts:
- Plugin: `@VideoEmbedProvider(id = "dailymotion")` → `src/Plugin/video_embed_field/Provider/Dailymotion.php`.
- Accepts `dailymotion.com/video/<id>`, `dailymotion.com/<id>`, `/embed/video/<id>`, and `dai.ly/<id>`.
- Embeds `//www.dailymotion.com/embed/video/<id>`; thumbnail from `dailymotion.com/thumbnail/video/<id>`;
  title from the public `dailymotion.com/services/oembed` endpoint.
- To use it on a restricted field, add "Dailymotion" to that field's allowed providers.
