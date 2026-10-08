<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `url_embed` service and helpers

## `url_embed` service

Class `Drupal\url_embed\UrlEmbed` (interface `UrlEmbedInterface`), constructor args
`['@module_handler', ['config'], '@?config.factory']`. Wraps the `oscarotero/embed`
(`Embed\Embed`) library.

```php
public function getEmbed(string $url, array $config = []): \Embed\Extractor;
```

- Invokes `hook_url_embed_options_alter(&$url, &$config)` across all modules first, so
  implementations can rewrite the URL or the adapter `$config` (e.g. force `maxheight` for a
  domain) before the fetch.
- Merges the passed `$config` over the service's base config (which includes the
  `facebook:token` / `instagram:token` derived from `url_embed.settings` when both Facebook
  app credentials are set — see `agent/configure/text-format-and-toolbar.md`).
- Returns an `Embed\Extractor`; the useful bits are `$info->code->html` (embed markup),
  `$info->code->ratio` (aspect ratio, if the provider reports one), and
  `$info->providerName`.
- Throws on invalid/unsupported URLs — callers (filters, formatter, dialog form) all wrap
  calls in `try/catch` and log via the `url_embed` logger channel on failure, degrading
  gracefully (original text/URL is left unchanged, formatter renders nothing for that item).

```php
$info = \Drupal::service('url_embed')->getEmbed('https://www.youtube.com/watch?v=xxXXxxXxxxX');
if (!empty($info->code->html)) {
  // $info->code->html is the embed markup to render.
}
```

`getConfig()` / `setConfig(array $config)` read/replace the service's base adapter config.

## `UrlEmbedHelperTrait`

For application-level classes (forms, filter plugins) that want lazy access to the module
handler and the `url_embed` service without constructor injection:

```php
use Drupal\url_embed\UrlEmbedHelperTrait;

class MyThing {
  use UrlEmbedHelperTrait;

  public function doIt() {
    $info = $this->urlEmbed()->getEmbed($url);   // lazy \Drupal::service('url_embed')
    $handler = $this->moduleHandler();           // lazy \Drupal::moduleHandler()
  }
}
```

Services registered in the container should inject `UrlEmbedInterface` directly instead
(see `UrlEmbedFilter::create()` for the pattern).

## `url_embed` Link field formatter

Plugin id `url_embed` (`LinkEmbedFormatter`), applicable to `link` fields only. Settings:
`enable_responsive` (bool, default `FALSE`) and `default_ratio` (string, default
`'66.669'`) — same meaning as the filter's settings. For each link item it calls
`getEmbed()` on the URL and renders the embed HTML directly (via `#type: inline_template`)
or wrapped in the `responsive_embed` theme hook when responsive is enabled. Attach it from
*Manage display* by choosing "Embedded URL" as the format for a Link field.
