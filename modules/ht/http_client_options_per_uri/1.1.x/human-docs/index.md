# HTTP Client Options per URI — manual setup guide

**HTTP Client Options per URI** (`http_client_options_per_uri`) lets you apply
different Guzzle HTTP-client options — timeouts, headers, proxy, TLS settings, and
so on — to Drupal's **outgoing** requests depending on which URI is being called.

By default Drupal applies one HTTP-client configuration to every outgoing
connection (set via `$settings['http_client_config']`). That is a blunt instrument:
if one third-party service is slow, you have to raise the timeout for *all* of
them. This module solves that by letting you define option sets that match specific
URIs. A slow CRM can get a generous timeout while everything else keeps a short,
snappy one.

It works by replacing Drupal's `http_client_factory` service with a version that
adds a small Guzzle middleware. On every outgoing request, the middleware checks
your rules, finds the ones whose regular expression matches the request URI, and
merges their options into the request. There is **no admin UI, no routes, and no
permissions** — all configuration lives in `settings.php`.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module — it is configured entirely in
`settings.php`, described below.

## How to use it

All configuration goes in your site's `settings.php` under
`$settings['http_client_options_per_uri_config']`. It is an array keyed by a name
you choose; each entry has a `regexp` (a PCRE tested against the full request URI)
and an `options` array of standard Guzzle request options to apply when it matches.

```php
$settings['http_client_options_per_uri_config']['paypal'] = [
  'regexp' => '/^http(?:s)?:\/\/api\.(?:sandbox\.)?paypal\.com.*$/i',
  'options' => [
    'timeout' => 10,
    'connect_timeout' => 10,
  ],
];

$settings['http_client_options_per_uri_config']['mandrill'] = [
  'regexp' => '/^http(?:s)?:\/\/mandrillapp\.com\/api\/.*$/i',
  'options' => [
    'timeout' => 10,
    'connect_timeout' => 10,
  ],
];
```

**How matching works:** every entry whose `regexp` matches contributes, and if more
than one matches, **the last matching entry wins**. Matched options are deep-merged
into the request's existing options.

**Common uses:** a shorter timeout for a slow API without affecting others; a longer
`connect_timeout` for one service; a custom `User-Agent` header for a single host;
routing one host through a specific `proxy`; or attaching client-certificate
options (`cert`, `ssl_key`) for a mutual-TLS partner.

> **Security caution:** options are merged verbatim, so you *can* set
> `verify => false` to disable TLS certificate verification for matching hosts —
> which exposes those connections to man-in-the-middle attacks. Only do this
> deliberately, document why, and **scope the `regexp` tightly** so sensitive
> options never leak to unintended hosts. Because these settings live only in
> `settings.php`, they are an intentional, auditable operator choice — there is no
> way for a site admin (let alone an anonymous user) to change them through the UI.
