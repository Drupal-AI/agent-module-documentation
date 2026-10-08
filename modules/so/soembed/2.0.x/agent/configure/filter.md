# Configure the Simple oEmbed filter

`soembed` provides exactly one text-format filter plugin (`filter_soembed`) and has no module
settings page. You enable and tune it per text format.

## Enable on a text format
1. Go to `/admin/config/content/formats` and edit a format (e.g. *Full HTML*, *Basic HTML*).
2. Check **Simple oEmbed filter**.
3. Order it *before* "Convert URLs into links" and any filter that rewrites URLs — if a URL is
   turned into an `<a>` first, soembed will not embed it (it deliberately skips URLs already
   inside `<a>...</a>`).
4. Save.

## Settings (stored per format)
| Form label | Config key | Type | Default | Meaning |
|---|---|---|---|---|
| Maximum width of media embed | `soembed_maxwidth` | int | `0` | Passed to core oEmbed as `max_width`; `0` keeps the provider's native size. |
| Replace in-line URLs | `soembed_replace_inline` | bool | `FALSE` | `FALSE`: only a URL alone on its own line/block is embedded. `TRUE`: embed URLs anywhere in the text (needed when the WYSIWYG stores the body on one line). |
| Oembed providers buckets | `soembed_allowed_buckets` | sequence(string) | `[]` | Only shown when contrib `oembed_providers` is installed. Selected `oembed_provider_bucket` ids restrict which providers this format may embed; empty = all providers the core repository knows. |

Settings live in the format's third-party filter config; schema id `filter_settings.filter_soembed`.

## Set via PHP / drush
```php
$format = \Drupal\filter\Entity\FilterFormat::load('full_html');
$format->setFilterConfig('filter_soembed', [
  'status' => TRUE,
  'weight' => -10, // before "Convert URLs into links"
  'settings' => [
    'soembed_maxwidth' => 800,
    'soembed_replace_inline' => FALSE,
    'soembed_allowed_buckets' => [], // or bucket ids if oembed_providers is on
  ],
])->save();
```

## What happens at render time
`SoEmbedFilter::process($text, $langcode)`:
- Protects existing `<a>...</a>` tags (placeholder swap) so links are never re-embedded.
- If `soembed_replace_inline` is `TRUE`, scans for `http(s)` URLs anywhere except inside HTML
  attributes. Otherwise splits on block boundaries (`<p>` / `<div>` / `<br>` and `\n`) and only
  acts on a segment that is a standalone URL (`^https?://\S+$`).
- Each candidate URL goes through `embedUrl()`:
  - `getProviderByUrl()` matches it against every endpoint of every provider returned by
    `media.oembed.provider_repository`; a URL matching no known provider returns `NULL` and is
    left as plain text.
  - If provider buckets are selected (`oembed_providers`), the matched provider's name must be in
    a selected bucket, else it is skipped.
  - Core `media.oembed.url_resolver` builds the resource URL and `media.oembed.resource_fetcher`
    fetches the oEmbed resource.
  - Render by resource type: `TYPE_LINK` → a themed link; `TYPE_PHOTO` → `#theme => image` with
    the resource URL; otherwise (video / rich) → an `<iframe>` pointing at core route
    `media.oembed_iframe`, hash-signed via `media.oembed.iframe_url_helper` and attaching library
    `media/oembed.formatter`. `media.settings:iframe_domain` is honored when set.
- Any failure (unknown URL, `ResourceException`, other exception) returns `NULL` and leaves the
  URL unchanged; fetch errors are logged to the `media` logger channel.

## oembed_providers integration
Without contrib [`oembed_providers`](https://www.drupal.org/project/oembed_providers) the filter
form shows a warning and every provider the core repository lists is allowed. Install it, define
provider buckets (`oembed_provider_bucket` config entities), then tick the buckets under the
filter to scope this format to just those providers.
