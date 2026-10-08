<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Embed service, link formatter & object-alter hook

## The `ckeditor_media_embed` service

Service id `ckeditor_media_embed`, class `Drupal\ckeditor_media_embed\Embed`, interface
`EmbedInterface`. It resolves media URLs against the configured provider.

```php
$embed = \Drupal::service('ckeditor_media_embed');

// Fetch the decoded oEmbed object for a single URL (or NULL on failure).
$obj = $embed->getEmbedObject('https://www.youtube.com/watch?v=…');
// $obj->html, $obj->type, $obj->provider_name, $obj->title, …

// Replace every <oembed url="…"> tag in a string with its embed HTML.
$html = $embed->processEmbeds($text);   // used by the filter

// A render-safe link to the settings page.
$link = $embed->getSettingsLink();
```

`getEmbedObject()` GETs `embed_provider` with `{url}` substituted, `json_decode`s the response,
then runs `hook_ckeditor_media_embed_object_alter()` on the result. `setEmbedProvider()` lets you
override the provider template at runtime. Network/transfer failures are logged and surfaced as a
warning message, and the method returns `NULL`.

## Link field formatter

Formatter id **`ckeditor_media_embed_link_formatter`**, label *"Oembed element using CKEditor
Media Embed provider"*, for `link` fields. On a Link field's *Manage display*, choose this
formatter to render each stored URL as an embed (via `getEmbedObject()`); if no oEmbed HTML comes
back it falls back to a plain link. Useful for a "media URL" field that should display as the
embedded player.

## `hook_ckeditor_media_embed_object_alter(&$embed)`

Invoked on every object returned by `getEmbedObject()`. `$embed` is the json-decoded oEmbed
object; mutate it in place. The module ships a default implementation that copies `$embed->title`
onto every `<iframe title="…">` in `$embed->html` for accessibility. Implement your own to
sanitize, rewrite, or restrict the provider's HTML:

```php
function mymodule_ckeditor_media_embed_object_alter(&$embed) {
  if (!empty($embed->html)) {
    // e.g. force lazy-loading on embedded iframes.
    $embed->html = str_replace('<iframe ', '<iframe loading="lazy" ', $embed->html);
  }
}
```

See `ckeditor_media_embed.api.php` for the canonical signature.
