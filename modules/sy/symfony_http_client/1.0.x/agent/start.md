<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Symfony HTTP Client for Drupal (symfony_http_client) — agent index

Registers **Symfony's HTTP client** in the service container so code can autowire
`Symfony\Contracts\HttpClient\HttpClientInterface`. Version **1.0.0**,
core `^10.3 || ^11.0`, **`php: 8.3`** (a higher PHP floor than core requires),
package `System`.

No UI, no routes, no permissions, no configuration, no config schema, no hooks.
The entire module is two classes plus a one-block `.services.yml`.

## What it provides
- **`symfony_http_client.services.yml`** — only sets `_defaults` `autowire: true` /
  `autoconfigure: true` and a `~` entry for `HttpClientInterface`, so consumers can inject
  the interface.
- **`SymfonyHttpClientServiceProvider`** (`ServiceProviderInterface`) — registers the
  compiler pass in `register()`.
- **`SymfonyHttpClientCompilerPass`** (`CompilerPassInterface`) — aliases
  `HttpClientInterface::class` to a private definition built by the factory
  `HttpClient::create()`. The backing definition's id is randomised
  (`ContainerBuilder::hash('symfony_http_client.factory' . mt_rand())`) so no code can
  depend on it directly.

## Composer / dependencies
- Requires `symfony/http-client: ^6.4 || ^7.3` (Composer, not a Drupal module dep).
- No dependent Drupal modules; usually pulled in transitively (e.g. by the `ai` family).

## Key facts for a consumer
- **It is NOT core's `http_client`.** The client is built by bare `HttpClient::create()` with
  no Drupal-supplied options, so it does **not** inherit what `http_client_factory` gives
  core's `http_client`: **proxy settings** from `settings.php`, **timeouts**, and
  **middleware** (logging, test interception). Behind an outbound proxy, requests through
  this client bypass it.
- Core's Guzzle-based `http_client` remains available and unchanged; this only adds an
  alternative contract.

## Solution docs
- [agent/api/service.md](api/service.md) — service id, wiring, and how to consume the client.
