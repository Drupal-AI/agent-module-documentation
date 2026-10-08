# The Dailymotion provider plugin

Source: `src/Plugin/video_embed_field/Provider/Dailymotion.php`
(`@VideoEmbedProvider(id = "dailymotion", title = "Dailymotion")`, extends
`Drupal\video_embed_field\ProviderPluginBase`). This is the module's only code. You do not call
it directly — Video Embed Field's field widget/formatter instantiate it when a stored URL matches.

## Accepted input (`getIdFromInput($input)`)

Static regex:

```
/^https?:\/\/(www\.)?(dailymotion\.com|dai\.ly)\/(embed\/)?(video\/)?(?<id>[a-zA-Z0-9]*)(_([0-9a-zA-Z\-_])*)?$/
```

Matches and extracts the alphanumeric `id` from, e.g.:
- `https://www.dailymotion.com/video/x8abc12`
- `https://dailymotion.com/x8abc12`
- `https://www.dailymotion.com/embed/video/x8abc12`
- `https://dai.ly/x8abc12`
- URLs with a trailing `_slug` suffix (the slug after `_` is ignored).

Returns `FALSE` when no id is found (so Video Embed Field falls through to other providers).

## Embed output (`renderEmbed(array $options)`)

Returns a `video_embed_iframe` render element:

- `#url` → `//www.dailymotion.com/embed/video/<id>`
- `#query` → `autoPlay` = `$options['autoplay']`
- `#attributes` → `width`, `height`, `frameborder=0`, `allowfullscreen`, `loading` (from the
  formatter's lazy/eager setting), and `title` when a title is resolved.

`$options` (`width`, `height`, `autoplay`, `loading`, `title_format`, `use_title_fallback`) is
supplied by Video Embed Field's `Video` formatter settings — this module adds no settings of its own.

## Thumbnail (`getRemoteThumbnailUrl()`)

Returns `https://www.dailymotion.com/thumbnail/video/<id>`. Video Embed Field downloads and caches
this as the local poster image used by its thumbnail/preview formatters.

## Title via oEmbed (`getName()` / `oEmbedData()`)

`getName()` calls `formatTitle()` with the video title fetched from Dailymotion's public oEmbed
endpoint: `https://www.dailymotion.com/services/oembed?url=<normalized embed url>`, retrieved with
`ProviderPluginBase::downloadJsonData()`. Used to populate the accessible iframe `title`. Returns
NULL title on download failure (falls back per `use_title_fallback`).

## Deprecated shim

`renderEmbedCode($width, $height, $autoplay, …)` is deprecated (removed in video_embed_field 3.2.0)
and simply forwards to `renderEmbed()`. New code should rely on `renderEmbed()`.

## Adding it to a restricted field

If a field limits allowed providers, edit the field's widget settings (Manage form display →
the video field's cog) and tick **Dailymotion**, otherwise Dailymotion URLs are rejected on save.
