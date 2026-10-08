# Service, hooks and library (API)

## Service — `piwik_noscript`

`Drupal\piwik_noscript\PiwikNoscript` (`autowire: true`; also aliased to the interface
`Drupal\piwik_noscript\PiwikNoscriptInterface`). Constructor injects `config.factory`, `current_user`,
`module_handler`, `renderer`, `request_stack`, `current_route_match`, `title_resolver`. Everything is
driven off the **Matomo module's** config object `matomo.settings`; this module owns no config of its own.

Public methods (all in `src/PiwikNoscript.php`):

- `getConfig(): ?ImmutableConfig` — returns the `matomo.settings` config **only if both** `site_id`
  and `url_https` are set, else `NULL`. The image/URL builders no-op (empty markup) when this is `NULL`.
  (`src/PiwikNoscript.php:122`)
- `getOptions(): array` — builds the Matomo query options:
  `query.action_name` = resolved page title (`renderInIsolation()` if it is a render array),
  `query.idsite` = `matomo.settings:site_id`, `query.rec` = `'1'`, `query.url` = current request URI.
  Fires the alter hook `hook_piwik_noscript_options_alter` before returning. (`src/PiwikNoscript.php:86`)
- `getUrl(array $options): string` — `Url::fromUri($url_https . 'js/')->setOptions($options)->toString()`;
  `url_https` comes from `matomo.settings`. Query values are URL-encoded by `Url::toString()`.
  (`src/PiwikNoscript.php:109`)
- `getImage(): array` — `#[TrustedCallback]` lazy builder used by the page hook. Returns a
  `#theme => 'image'` renderable (`#uri` = `getUrl(getOptions())`, `#width`/`#height` `0`,
  `loading: eager`, `style: position: absolute`) and adds cache context `url`. Returns empty
  `#markup` when unconfigured, or when the Matomo module's `_matomo_visibility_pages()` /
  `_matomo_visibility_user()` exclude the current page/user. When the `matomo` module is **not**
  enabled it additionally attaches `drupalSettings.piwikNoscript.url` (with `send_image=0` added) and
  the `piwik_noscript/piwik_noscript` library for referrer tracking. (`src/PiwikNoscript.php:39`)

Call from PHP:

```php
$svc = \Drupal::service('piwik_noscript'); // or type-hint PiwikNoscriptInterface
if ($svc->getConfig()) {
  $options = $svc->getOptions();
  $trackingUrl = $svc->getUrl($options);
}
```

## Page hook — `hook_page_bottom`

`Drupal\piwik_noscript\Hook\PageBottom` (`#[Hook('page_bottom')]`, `__invoke(array &$page_bottom)`) adds:

```php
$page_bottom['piwik_noscript'] = [
  '#type' => 'html_tag',
  '#tag' => 'noscript',
  'child' => [
    '#create_placeholder' => TRUE,
    '#lazy_builder' => ['piwik_noscript:getImage', []],
  ],
  '#attributes' => ['class' => ['piwik-noscript']],
];
```

The `#lazy_builder` defers `getImage()` to a placeholder, so the per-request URL/title never pollute the
page-level render cache (BigPipe/placeholder-strategy aware; the module ships tests for both).

## Alter hook — `hook_piwik_noscript_options_alter(array &$options)`

Invoked in `getOptions()` via `moduleHandler->alter('piwik_noscript_options', $options)`.
`$options['query']` is the associative array of Matomo tracking parameters. Implement it to add or
override parameters (custom dimensions, `uid`, campaign keys, etc.):

```php
function mymodule_piwik_noscript_options_alter(array &$options): void {
  $options['query']['dimension1'] = 'my-value';
}
```

## JS library — `piwik_noscript/piwik_noscript`

`piwik_noscript.js` (deps `core/drupalSettings`). Runs only when `drupalSettings.piwikNoscript` is
present — i.e. only when the `matomo` module is **not** enabled. It calls
`fetch(drupalSettings.piwikNoscript.url + '&urlref=' + encodeURIComponent(document.referrer), {mode: 'no-cors'})`
to record the referrer that the plain `<noscript>` `<img>` cannot send.
