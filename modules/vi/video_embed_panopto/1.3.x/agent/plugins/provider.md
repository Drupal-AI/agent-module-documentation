<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `panopto` Video Embed Field provider plugin

The whole module. One class, `src/Plugin/video_embed_field/Provider/Panopto.php`, registered with
Video Embed Field's provider plugin type:

```php
/**
 * @VideoEmbedProvider(
 *   id = "panopto",
 *   title = @Translation("Panopto")
 * )
 */
class Panopto extends ProviderPluginBase { … }
```

- Plugin type owner: `video_embed_field` — manager `video_embed_field.provider_manager`
  (`ProviderManager`), discovery dir `Plugin/video_embed_field/Provider`, annotation
  `Drupal\video_embed_field\Annotation\VideoEmbedProvider`, base
  `Drupal\video_embed_field\ProviderPluginBase`.
- No configuration, settings, or services are added here; the plugin just implements three methods.

## Recognising a URL — `getIdFromInput()` (Panopto.php:45)

Static method called by the field's validation/provider selection. Runs two case-insensitive
patterns and, on the first match, returns `group1 . '|' . group2`:

```php
$patterns = array(
  '@.*//(.*)/Panopto/Pages/Viewer\.aspx\?id\=([^"\&]+)@i',
  '@.*//(.*)/Panopto/Pages/Embed\.aspx\?id\=([^"\&]+)@i',
);
```

- Group 1 = the Panopto **server host** (everything between `//` and `/Panopto/Pages/…`).
- Group 2 = the **session id** (`id=` value, up to a `"` or `&`).
- Accepted URL shapes (scheme optional because the leading `.*//` swallows it):
  - `https://<host>/Panopto/Pages/Viewer.aspx?id=<id>`
  - `https://<host>/Panopto/Pages/Embed.aspx?id=<id>`
- Returns `FALSE` when neither pattern matches (Video Embed Field then tries the next provider).
- **Stored value** for the field is the concatenation `"<host>|<id>"` — not a plain id. Every other
  method re-`explode('|', …)`s it, so `$video_id_array[0]` is the host and `[1]` is the session id.
  `ProviderPluginBase::isApplicable()` calls this and treats any non-empty result as a Panopto match.

## Rendering the player — `renderEmbedCode()` (Panopto.php:18)

Returns a Drupal render array (an `html_tag` iframe); Video Embed Field wraps it in a container and
renders it:

```php
return [
  '#type' => 'html_tag',
  '#tag' => 'iframe',
  '#attributes' => [
    'width' => $width,
    'height' => $height,
    'frameborder' => '0',
    'allowfullscreen' => 'allowfullscreen',
    'src' => '//' . $video_id_array[0] . '/Panopto/Pages/Embed.aspx?id='
             . $video_id_array[1] . '&v=1&autoplay=' . $video_autoplay,
  ],
];
```

- Signature: `renderEmbedCode($width, $height, $autoplay, $title_format = NULL,
  $use_title_fallback = TRUE)`. `$width`/`$height` come from the formatter settings; `$autoplay` is
  turned into the string `'true'`/`'false'` for Panopto's `autoplay=` param.
- `src` is **protocol-relative** (`//host/…`), so it inherits the page's http/https scheme; always
  points at Panopto's `Embed.aspx`, `&v=1`.
- Note on the installed parent (video_embed_field **3.1.0**): the base
  `ProviderPluginBase::renderEmbedCode()` is deprecated (returns `[]` + a deprecation notice) and the
  current entry point is `renderEmbed(array $options)`. That base `renderEmbed()` **delegates back to
  `renderEmbedCode()`** for BC, so this plugin — which only overrides `renderEmbedCode()` — still
  renders correctly. If updating the module for a future 3.2.0, port the body to `renderEmbed()`.

## Remote thumbnail — `getRemoteThumbnailUrl()` (Panopto.php:37)

```php
return 'https://' . $video_id_array[0]
  . '/Panopto/PublicAPI/SessionPreviewImage?id=' . $video_id_array[1];
```

- Absolute `https://` URL to Panopto's Public API preview image for the session.
- The parent's `ProviderPluginBase::downloadThumbnail()` fetches this **server-side** (Guzzle GET) and
  saves the body to `{system.file:default_scheme}://video_thumbnails/<host>|<id>.jpg`
  (`getLocalThumbnailUri()`). This runs when the `video_embed_field_thumbnail` formatter renders a
  value, or when `video_embed_media` builds a media entity's thumbnail.

## How Video Embed Field consumes the plugin

- Field type `video_embed_field`, widget `video_embed_field_textfield`; the pasted URL is stored raw
  and providers are matched via `getIdFromInput()`/`isApplicable()`.
- Formatters (all from the parent module): `video_embed_field_video` (iframe — calls
  `renderEmbed()` → this plugin's `renderEmbedCode()`), `video_embed_field_video_url`,
  `video_embed_field_thumbnail`, plus `Colorbox`/`LazyLoad`.
- WYSIWYG (`video_embed_wysiwyg` submodule) renders embeds through the same `renderEmbed()` path.
- `getName()`/thumbnail download are inherited from `ProviderPluginBase`; this plugin does not
  override them.

## Extending / overriding

To change behaviour (e.g. force `https`, add allowlisted hosts, tweak query params) subclass this
provider or ship your own `@VideoEmbedProvider` plugin in a custom module under
`src/Plugin/video_embed_field/Provider/`, then clear caches so the provider manager rediscovers it.
