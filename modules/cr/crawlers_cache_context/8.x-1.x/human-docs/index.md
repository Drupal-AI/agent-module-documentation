# Crawlers cache context — manual setup guide

**Crawlers cache context** (`crawlers_cache_context`) is a developer-oriented module
that adds a Drupal **cache context** keyed on whether the current request comes from a
detected crawler/bot. With it, a render array can vary — and be cached separately —
depending on whether the visitor is a search-engine crawler or an ordinary user.

The classic use case is serving something to a crawler that you don't want to show
everyone. For example, you might give human visitors an infinite-scroll list but emit
a plain "Next page" link only for Googlebot so it can crawl every page. You attach the
context to the relevant part of your render array, and Drupal caches one variant for
crawlers and one for everyone else. You can target crawlers **in general**
(`crawlers_cache_context`) or a **specific** crawler such as Googlebot
(`crawlers_cache_context:googlebot`).

This is a **primitive for developers**, not a point-and-click feature: it has no admin
UI, no settings form, and no permissions. The behaviour lives in code, where you add
the context to a render array's `#cache['contexts']`. Crawler detection is done by the
`jaybizzle/crawler-detect` PHP library (installed automatically with Composer) and is
**user-agent based** — a heuristic that can be spoofed. Use it for **benign**
variations only: showing search engines materially different content from users is
**cloaking**, which search engines penalise, so vary content honestly. The module has
no access-control role.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (which pulls in the
   crawler-detect library) and enable the module.

There is **no configuration page** and no permissions — this module is used from code,
shown below.

## How to use it (for developers)

Attach the context to the part of a render array that should differ for crawlers.
Drupal then caches a separate variant per crawler status.

Target crawlers in general:

```php
$build['next'] = [
  '#type' => 'link',
  '#url' => $some_url,
  '#title' => t('Next page'),
  '#access' => $access,
  '#cache' => [
    'contexts' => [
      'crawlers_cache_context',
    ],
  ],
];
```

Or a specific crawler, such as Googlebot:

```php
'#cache' => [
  'contexts' => [
    'crawlers_cache_context:googlebot',
  ],
],
```

Because detection is user-agent based and can be spoofed, keep the variations benign
and avoid cloaking.
