# Laravel Http Client — manual setup guide

**Laravel Http Client** (`laravel_http_client`) is a **developer library** module.
It brings Laravel's **HTTP Client** — a fluent, expressive wrapper around Guzzle —
into Drupal, so developers who like Laravel's `Http::get()` / `Http::post()`
ergonomics can make outbound HTTP requests with far less boilerplate. This version
tracks **Laravel 11.x** and supports Drupal 10 and 11. It uses standard TLS
verification.

There is nothing here for site builders — no admin screen and no visible feature.
The module's value is in code. Once installed, your custom code can use the
`Http` service to build requests fluently: set query parameters, headers, retries,
and base URLs, and even register reusable request "macros". For example, you can
retry a request three times with a delay, attach query parameters, and issue a
`GET`; or define a named macro that pre‑sets headers and a base URL and reuse it
across calls.

Because it is a library integration, you "use" it by writing code against it. See
the official Laravel 11.x HTTP Client documentation for the full API this module
exposes.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

There is **no configuration page** for this module — it is a developer library
with no settings form. You use it from your own code.

## How to use it

After enabling the module, use the `Http` service from custom code, for example:

```php
use Drupal\laravel_http_client\Service\Http;

// Retry up to 3 times with a 100ms delay, then GET with query parameters.
Http::retry(3, 100)
  ->withQueryParameters(['name' => 'Taylor', 'page' => 1])
  ->get('https://example.com/users');

// Register a reusable macro with preset headers and base URL.
Http::macro('github', function () {
  return Http::withHeaders(['X-Example' => 'example'])
    ->baseUrl('https://github.com');
});
$response = Http::github()->get('/');
```

Refer to the official Laravel 11.x HTTP Client documentation for the complete set
of methods.
