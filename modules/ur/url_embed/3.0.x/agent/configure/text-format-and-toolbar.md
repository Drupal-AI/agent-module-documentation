<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure URL Embed

There are three independent things to configure: the text filters, the CKEditor 5 toolbar
button, and the global settings form. None are required together — a site can use just the
filters (paste-a-URL becomes an embed automatically) with no toolbar button at all.

## 1. Text format filters

Two filter plugins, both `type = TYPE_TRANSFORM_REVERSIBLE`, live on
`admin/config/content/formats/manage/<format>`:

| Plugin id | Class | What it does |
|---|---|---|
| `url_embed_convert_links` | `ConvertUrlToEmbedFilter` | Rewrites bare URLs in the text into `<drupal-url data-embed-url="...">` elements (must run **before** `url_embed` in filter order — it produces the tag the other filter consumes). |
| `url_embed` | `UrlEmbedFilter` | Renders every `<drupal-url data-embed-url="...">` element into the provider's embed HTML (fetched via the `url_embed` service). |

`url_embed_convert_links` settings:
- `url_prefix` (string, default `""`) — if set, only URLs prefixed with this string are
  converted (e.g. `EMBED-https://youtube.com/...`); empty means convert every recognized URL.

`url_embed` settings (stored per-filter under `filter.format.<id>.filters.url_embed.settings`):
- `enable_responsive` (bool) — wrap the embed HTML in a `responsive_embed` themed container
  so it scales to the content width; attaches the `url_embed/responsive_styles` library.
- `default_ratio` (string, percent, default `'66.7'`) — fallback aspect ratio used when the
  provider doesn't report one (e.g. `56.25` for 16:9).

Enable both via UI (`/admin/config/content/formats/manage/<format>`, tick both filter
checkboxes, order `url_embed_convert_links` above `url_embed`) or via config:

```yaml
# filter.format.<format>.yml
filters:
  url_embed_convert_links:
    id: url_embed_convert_links
    status: true
    weight: 0
    settings:
      url_prefix: ''
  url_embed:
    id: url_embed
    status: true
    weight: 1
    settings:
      enable_responsive: true
      default_ratio: '66.7'
```

Or scriptably:

```php
$format = \Drupal::entityTypeManager()->getStorage('filter_format')->load('<format>');
$format->setFilterConfig('url_embed_convert_links', ['status' => TRUE, 'weight' => 0]);
$format->setFilterConfig('url_embed', ['status' => TRUE, 'weight' => 1, 'settings' => [
  'enable_responsive' => TRUE,
  'default_ratio' => '66.7',
]]);
$format->save();
```

Read it back: `drush cget filter.format.<format> filters.url_embed` (and `.url_embed_convert_links`).

The tag itself, once produced/consumed by the filters:

```html
<drupal-url data-embed-url="https://www.youtube.com/watch?v=xxXXxxXxxxX" data-url-provider="YouTube"></drupal-url>
```

## 2. CKEditor 5 toolbar button

Add the `urlembed` toolbar item to a text format's CKEditor 5 configuration so editors get a
paste-a-URL dialog instead of typing the tag by hand. Requires the `url_embed` filter to be
enabled on the same format (the embed only renders through that filter).

```yaml
# editor.editor.<format>.yml
editor: ckeditor5
settings:
  toolbar:
    items: [..., urlembed]
```

The button opens `url_embed.cke5dialog` (`/url-embedcke5/dialog/{editor}`), backed by
`UrlEmbedCke5Dialog` — a single "URL" textfield that resolves the provider name via the
`url_embed` service before saving. That route's access is gated by a custom access checker
(`_url_embed_editor_access`, service `url_embed.dialog_access`) that requires: the editor
uses CKEditor 5, the user has `use` access on the format, **and** `urlembed` is actually
present in that editor's configured toolbar — so adding the filter without the toolbar item
does not expose the dialog.

The module also ships an `embed.button.url` Embed Button config entity (id `url`, `type_id`
`url`) pointing at the `url` `EmbedType` plugin (`Drupal\url_embed\Plugin\EmbedType\Url`),
installed automatically on module install — this is what makes "URL" available as an embed
type/button in the Embed module's UI.

## 3. Global settings form

Route `url_embed.admin` at `/admin/config/media/url_embed` (menu: Configuration > Media >
Url Embed), permission `administer url_embed`. Config object `url_embed.settings` (not
shipped by default — created the first time the form is saved):

| Key | Meaning |
|---|---|
| `facebook_app_id` | Facebook App ID |
| `facebook_app_secret` | Facebook App Secret |

When both are set, the `url_embed` service builds a `facebook:token` / `instagram:token`
adapter option (`"$app_id|$app_secret"`) automatically for every embed fetch — required by
Facebook/Instagram since Oct 2020 for their oEmbed endpoints. The form shows a live "app is
active" / "invalid credentials" message by calling Facebook's `debug_token` graph API
endpoint. Read the value back with `drush cget url_embed.settings facebook_app_id`.
