<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Hooks (`url_embed.api.php`)

Only one hook, invoked by the `url_embed` service on every `getEmbed()` call, before the
fetch:

```php
/**
 * Alter url or options passed to the embed request before sending it.
 *
 * @param string $url
 *   The URL.
 * @param array $config
 *   Options passed to the adapter (oscarotero/embed adapter settings, e.g.
 *   'facebook:token', 'oembed:query_parameters', etc.)
 */
function hook_url_embed_options_alter(&$url, &$config) {
  $parsedUrl = parse_url($url);
  if (($parsedUrl['host'] ?? '') == 'twitter.com') {
    $config = array_merge($config, ['oembed' => ['parameters' => ['maxheight' => 600]]]);
  }
}
```

Both `$url` and `$config` are taken by reference, so an implementation can rewrite the URL
entirely (e.g. normalize a shortlink) or add/override any adapter option before the
`oscarotero/embed` library performs the request. Runs for every caller of the service:
the `url_embed` filter, the `url_embed_convert_links` filter, the `url_embed` field
formatter, and the CKEditor 5 dialog form.
