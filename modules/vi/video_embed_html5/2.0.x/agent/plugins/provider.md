# The `html_5` Video Embed provider

`src/Plugin/video_embed_field/Provider/Html5.php` —
`@VideoEmbedProvider(id = "html_5", title = @Translation("HTML5"))`. It extends
`video_embed_field`'s `ProviderPluginBase`; you don't instantiate it — Video Embed Field
picks it automatically when a pasted URL matches.

## URL matching

`Html5::getIdFromInput($input)` runs a regex that accepts any URL/path ending in
`mp4`, `ogg`, or `webm` (case-insensitive) and returns `[$url, $extension]`; anything else
returns `FALSE` (so the provider does not claim non-matching input). Use direct links such as
`https://example.com/media/clip.mp4` or a local `public://…/clip.webm` path.

## Render output

`renderEmbedCode($width, $height, $autoplay, …)` returns a render array with
`#theme => 'video_embed_html5'`, `#src` = the URL, `#type` = `video/<ext>`, and `#autoplay`.
Template `templates/video-embed-html5.html.twig`:

```twig
<video controls {{ autoplay ? 'muted autoplay' : '' }} width="100%">
    <source src="{{ src }}" type="{{ type }}"/>
</video>
```

(`hook_theme()` in `.module` registers `video_embed_html5` with variables `src`, `type`,
`autoplay`, `width`, `height`.)

## Thumbnails

- **Server-side (preferred):** if the optional `php_ffmpeg` module is enabled, the provider's
  `downloadThumbnail()` opens the video and saves the frame at 1 second as
  `<thumbs>/<md5(url)>.jpg`.
- **Client-side fallback:** with no FFmpeg, `renderThumbnail()` outputs a container with
  `data-render-thumbnail=<url>` and attaches the `video_embed_html5/thumbnails` JS library,
  which draws the first video frame onto a `<canvas>`. While that runs it can show a
  placeholder image (see [configure/settings.md](../configure/settings.md)).
- `getRemoteThumbnailUrl()` returns `''` because the module overrides thumbnail handling.

## Using it

Add a *Video Embed* field to an entity and paste an mp4/ogg/webm URL — no code needed. To
constrain a field to only this provider, set the field's `allowed_providers` setting to
`['html_5']` (Video Embed Field field setting), e.g.:

```php
$fc = \Drupal\field\Entity\FieldConfig::loadByName('node', 'article', 'field_video');
$fc->setSetting('allowed_providers', ['html_5'])->save();
```
