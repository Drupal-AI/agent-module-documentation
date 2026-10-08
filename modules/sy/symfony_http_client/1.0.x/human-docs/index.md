# Symfony HTTP Client for Drupal — manual setup guide

**Symfony HTTP Client for Drupal** (`symfony_http_client`) registers Symfony's
HTTP client in Drupal's service container, so module code can autowire
`Symfony\Contracts\HttpClient\HttpClientInterface` instead of using Guzzle.
Drupal has shipped Guzzle as its `http_client` service for a decade, but much of
the wider PHP world — Symfony's own components, and many modern SDKs — now
expects Symfony's client, which supports HTTP/2, streaming, and async requests
natively. This module makes that client available.

It is pure infrastructure: there is **no user interface, no settings form, no
permissions, and no routes**. Under the hood it is just a service definition that
autowires the interface, plus a compiler pass that aliases that interface to a
private, factory-built `HttpClient::create()` service. Most sites do not install
it deliberately — it usually arrives as a **dependency** of something else
(on this site it came in with the `ai` module family). It requires the
`symfony/http-client` Composer library, **PHP 8.3** (a higher floor than core
itself requires), and Drupal 10.3 or 11.

One important thing to understand before writing code against it: this client is
**not** the same as core's `http_client`. It is built by a bare
`HttpClient::create()` with no Drupal-supplied configuration, so it does **not**
inherit the proxy settings, timeouts, or middleware that core applies to
`http_client` through its `http_client_factory`. If your site sits behind an
outbound proxy, or relies on core's client middleware for logging or test
interception, requests made through this client will bypass all of that — which
is the failure you are most likely to hit in practice. Core's Guzzle-based
`http_client` remains available and unchanged; this simply adds an alternative.

This guide is written for a **human** installing the module. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its Composer
   library, and enable it.

## How to use it

There is nothing to click. Once enabled, a service or plugin in your custom code
can type-hint `Symfony\Contracts\HttpClient\HttpClientInterface` as a
constructor argument and Drupal will inject the Symfony client automatically.
That is the whole feature — it exists so that code (and third-party SDKs) that
expect Symfony's client contract can run on Drupal without adapting Guzzle. Keep
the proxy/timeout/middleware caveat above in mind when deciding whether a given
outbound request should use this client or core's `http_client`.
