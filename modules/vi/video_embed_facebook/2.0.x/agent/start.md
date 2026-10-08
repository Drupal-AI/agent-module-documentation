# Video Embed Facebook — agent index

A **single Video Embed Field provider plugin** that teaches the `video_embed_field` module to accept
Facebook video URLs. No config, no permissions, no Drush, no plugin types of its own, no configure
route. Depends on `video_embed_field`.

Core facts:
- Plugin: class `Facebook`, `@VideoEmbedProvider(id = "facebook")`, extends
  `Drupal\video_embed_field\ProviderPluginBase`.
- Enable it → any **`video_embed_field`** field also accepts Facebook URLs (no per-field setup).
- Recognised URL forms: `https://www.facebook.com/<page>/videos/<id>` and
  `https://www.facebook.com/video.php?v=<id>` (`getIdFromInput()` pulls the numeric `<id>`).
- Embed: iframe to `https://www.facebook.com/plugins/video.php?href=<url>`; thumbnail:
  `https://graph.facebook.com/<id>/picture`.

**Compatibility note (this environment):** the shipped `Facebook::renderEmbedCode($width, $height,
$autoplay)` does not match the installed `ProviderPluginBase::renderEmbedCode($width, $height,
$autoplay, $title_format = NULL, $use_title_fallback = TRUE)`, so loading the plugin class raises a
PHP fatal ("Declaration … must be compatible"). Storing a Facebook URL in a field works; rendering /
provider-resolving it does not, until the provider is updated. Details in the doc below.

Docs:
- **The provider plugin: URL patterns, embed/thumbnail, how VEF providers work, and using a
  `video_embed_field` field** → [plugins/facebook-provider.md](plugins/facebook-provider.md)
