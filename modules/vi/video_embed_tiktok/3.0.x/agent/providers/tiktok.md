<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# TikTok provider plugin (`tiktok`)

The one thing this module ships: a `video_embed_field` provider that embeds TikTok videos.
Source: `src/Plugin/video_embed_field/Provider/Tiktok.php` (class `TikTok`, extends
`Drupal\video_embed_field\ProviderPluginBase`).

## Install and enable

```
composer require drupal/video_embed_tiktok
drush en video_embed_tiktok -y
```

Requires `drupal/video_embed_field:^3` (declared in `composer.json`; `video_embed_field` is also an
info.yml dependency, so it must be enabled) and Drupal core `^10.3 || ^11`. There is nothing else to
turn on — no settings form, no permissions, no config.

## How the provider is discovered

Video Embed Field runs an annotation-based plugin manager over
`Plugin/video_embed_field/Provider/`. The class carries:

```php
/**
 * @VideoEmbedProvider(
 *   id = "tiktok",
 *   title = @Translation("TikTok")
 * )
 */
```

so once the module is enabled the **TikTok** provider automatically shows up in the **Allowed
providers** checkboxes of every *video embed field*'s settings. If you have narrowed a field's
allowed providers, tick **TikTok** there for that field to accept TikTok URLs.

## URL patterns it matches

Matching is done by the static `getIdFromInput($input)`:

```php
public static function getIdFromInput($input) {
  if (preg_match('/https?:\/\/(www\.)?tiktok.com\/(?<user_id>@[\S]*)\/video\/(?<id>[0-9]*)\/?/', $input, $matches)) {
    return $matches['id'] ?? FALSE;
  }
}
```

- Scheme `http` or `https`, optional `www.`, literal `tiktok.com`, then `/@<user>/video/<id>`.
- The `id` capture is **`[0-9]*` — numeric only** and is what gets returned/used.
- A trailing `/` and a query string are tolerated.

Accepted forms (from `tests/src/Unit/ProviderUrlParseTest.php`), all returning
`6718335390845095173`:

```
https://www.tiktok.com/@scout2015/video/6718335390845095173/
http://www.tiktok.com/@scout2015/video/6718335390845095173/
http://www.tiktok.com/@scout2015/video/6718335390845095173
https://www.tiktok.com/@scout2015/video/6718335390845095173
https://www.tiktok.com/@scout2015/video/6718335390845095173/?taken-by=tiktok
```

Short-link forms like `https://vm.tiktok.com/…` are **not** matched — the URL must contain the
`/@user/video/{id}` path.

## Generated embed markup

`renderEmbedCode()` returns a `video_embed_iframe` render element (Video Embed Field renders it to an
`<iframe>`):

```php
$embed_code = [
  '#type' => 'video_embed_iframe',
  '#provider' => 'tiktok',
  '#url' => sprintf('https://www.tiktok.com/embed/%s', $this->getVideoId()),
  '#attributes' => [
    'width' => $width,
    'height' => $height,
    'frameborder' => '0',
    'allowfullscreen' => 'allowfullscreen',
  ],
];
```

- The iframe `src` is `https://www.tiktok.com/embed/{numeric-id}` — always TikTok's official embed
  host with a digits-only id from `getVideoId()`.
- `width`/`height` come from the field display formatter settings; `frameborder="0"` and
  `allowfullscreen` are fixed.
- When a title resolves via `getName($title_format, $use_title_fallback)`, a `title` attribute is
  added to the iframe for accessibility (new in Video Embed Field 3.0.x). The `$autoplay` parameter
  is accepted but not applied.

## Thumbnails

`getRemoteThumbnailUrl()` returns `thumbnail_url` from `oembedData()`, which fetches:

```
https://www.tiktok.com/oembed?url={the stored input URL}
```

via `file_get_contents()` and `json_decode()`s the JSON. Video Embed Field downloads that thumbnail
and manages it like any other provider's preview image, so TikTok thumbnails are available to the
field's thumbnail/image formatters. (The request always targets `www.tiktok.com`; the value read is
whatever TikTok returns as `thumbnail_url`.)

## How to use it

1. Add a **Video Embed Field** field to a content type, media type, or paragraph.
2. In the field's settings, make sure **TikTok** is among the **Allowed providers**.
3. Edit an entity, paste a TikTok video URL (e.g.
   `https://www.tiktok.com/@scout2015/video/6718335390845095173`) into the field, and save.
4. Configure the *Manage display* formatter (video/iframe or thumbnail) and dimensions as you would
   for any Video Embed Field provider.
