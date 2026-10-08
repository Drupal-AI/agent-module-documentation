<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Service, Twig function, and block

Three entry points, all funnelling into one method. Source under `src/`.

## Service `bitly_shortener`

`src/Services/BitlyShortenerServices.php` implements `BitlyShortenerServicesInterface` (which
declares just `shortener($url)`). Registered in `bitly_shortener.services.yml` with
`arguments: ['@config.factory', '@messenger']`.

`shortener($url)` logic:

1. If `bitly_shortener_enable == 0` **and** `bitly_shortener_token` is empty → returns `$url`
   unchanged (pass-through / disabled).
2. Reads `bitly_shortener_api` and `bitly_shortener_token` from `bitly_shortener.settings`.
3. Builds `$data = ['long_url' => $url]`, then via `\Drupal::httpClient()->post($bitly_api, …)`
   sends `body => json_encode($data)` with headers
   `Authorization: 'Bearer ' . $bitly_token` and `Content-Type: application/json`.
   (No `verify` option is passed, so Guzzle's **default TLS verification** applies.)
4. Decodes the JSON response: if `->link` is set, returns it (the Bitly short URL); otherwise
   adds a warning message *"Bitly shortener invalid access token."* and returns the original `$url`.
5. `catch` returns `$e->getMessage()`.

Call from PHP:

```php
$short = \Drupal::service('bitly_shortener')->shortener('https://www.drupal.org/');
```

Caveat: the `catch (Exception $e)` clause references an **unqualified** `Exception` in a namespaced
file with no `use \Exception;`, so it resolves to `Drupal\bitly_shortener\Services\Exception` — a
class that does not exist. Guzzle transport errors (`GuzzleHttp\Exception\*`) are therefore **not
caught** and will surface as uncaught exceptions rather than the intended message. Treat the
service as one that can throw on network/HTTP failure.

## Twig function `bitly_shortener()`

`src/Services/BitlyShortenerTwigServices.php` extends `Twig\Extension\AbstractExtension`, tagged
`twig.extension` in services.yml (id `bitly_shortener.twig`, args `['@module_handler', '@theme.manager']`).
`getFunctions()` registers one `TwigFunction('bitly_shortener', [self::class, 'bitlyShortener'])`
and runs `moduleHandler->alter('bitly_shortener_functions', $functions)` and the equivalent theme
alter — so modules/themes can add/replace functions via
`hook_bitly_shortener_functions_alter(&$functions)`.

`bitlyShortener($url)` simply calls `\Drupal::service('bitly_shortener')->shortener($url)`. In a
template:

```twig
{{ bitly_shortener('https://www.drupal.org') }}
{# or the current page, per hook_help: #}
{% set site_url = url('<current>') %}
{{ bitly_shortener(site_url|render|render) }}
```

Each render invokes the external API — cache the output.

## Block `bitly_shortener_block`

`src/Plugin/Block/BitlyShortenerBlock.php`, `@Block(id = "bitly_shortener_block", admin_label =
"Bitly Shortener", category = "Bitly Shortener")`, injects the `bitly_shortener` service.
`build()` resolves the current URL with `Url::fromRoute('<current>', [], ['absolute' => TRUE])`,
shortens it, and returns `#theme => 'bitly_shortener_block'` with `#bitly_shortener => $short` and
the `bitly_shortener/bitly_shortener` library attached. `getCacheMaxAge()` returns `0` (uncached —
so every request re-hits Bitly).

Theme hook `bitly_shortener_block` is declared in `bitly_shortener_theme()` (in the `.module`),
variable `bitly_shortener`. Template `templates/bitly-shortener-block.html.twig` renders the short
link into a read-only `<input>` (auto-escaped by Twig) plus a *Shortener Url* button whose
`js/bitly-shortener.js` (`bitlyShortenerFunction()`) copies the value to the clipboard. Library
`bitly_shortener` (in `bitly_shortener.libraries.yml`) pulls `core/drupal`, `core/jquery`,
`core/once`, plus `css/bitly-shortener.css`.
