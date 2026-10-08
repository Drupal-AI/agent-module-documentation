# Wistia provider plugin

`Drupal\video_embed_wistia\Plugin\video_embed_field\Provider\Wistia` — the module's only class.
It extends `Drupal\video_embed_field\ProviderPluginBase` and is discovered by video_embed_field's
`VideoEmbedProvider` annotation:

```php
/**
 * @VideoEmbedProvider(
 *   id = "wistia",
 *   title = @Translation("Wistia")
 * )
 */
```

You do not instantiate this yourself. video_embed_field's provider manager tries each provider's
`getIdFromInput()` against the URL an editor pastes; the first that returns an id wins.

## Methods it implements

- `static getIdFromInput($input): string|false` — the URL matcher. Regex:
  ```
  ^https?://(?:.+)?(?:wistia\.com|wi\.st|wistia\.net)(?:/(?:medias|embed/iframe|embed))*/(?<id>[0-9A-Za-z]+)(?:\.\w*)?$
  ```
  Returns the named `id` capture (alphanumeric media key) or `FALSE`. This is also what
  video_embed_field uses to validate the field value on save.
- `renderEmbedCode($width, $height, $autoplay, $title_format = NULL, $use_title_fallback = TRUE): array`
  — returns a render array of `#type => 'video_embed_iframe'`:
  - `#provider => 'wistia'`
  - `#url => https://fast.wistia.com/embed/iframe/{getVideoId()}`
  - `#query => ['autoPlay' => $autoplay, 'muted' => $autoplay]` (mute is tied to autoplay)
  - `#attributes => width, height, frameborder=0, allowfullscreen, class=wistia_embed`, plus a
    `title` attribute when `getName()` resolves one.
- `getName($title_format = NULL, $use_title_fallback = TRUE): ?string` — the video title, via
  `formatTitle()` on the oEmbed `title`.
- `getRemoteThumbnailUrl(): ?string` — the oEmbed `thumbnail_url` (used by video_embed_field to
  download and cache the poster image), or NULL if the oEmbed fetch failed.
- `protected oEmbedData(): ?array` — GETs `https://fast.wistia.net/oembed?url={getInput()}` through
  the base class's `downloadJsonData()` and returns the decoded array (or NULL on failure).

## Adding a provider like this one

To support another host, create your own module with a class under
`src/Plugin/video_embed_field/Provider/`, annotate it `@VideoEmbedProvider(id=..., title=...)`,
extend `ProviderPluginBase`, and implement `getIdFromInput()`, `renderEmbedCode()`,
`getRemoteThumbnailUrl()`, and `getName()`. No service registration or config is required — this
module is the minimal reference. Return `FALSE` from `getIdFromInput()` for URLs you do not own so
other providers can claim them.
