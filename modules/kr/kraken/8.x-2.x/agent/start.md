<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Kraken.io (kraken) — agent index

Provides a single **Image Optimize** (`imageapi_optimize`) processor plugin, id `kraken`, that
compresses derivative images through the **Kraken.io** web service. The module has no page, route,
permission, or drush command of its own: you add the "Kraken.io" processor to an Image Optimize
**pipeline**, and whenever a pipeline runs over an image derivative the processor uploads the file to
`https://api.kraken.io/v1/upload` (via the `kraken-io/kraken-php` `\Kraken` client), waits for the
result, downloads the optimized image with the site's `http_client`, and overwrites the derivative in
place. Options are per-processor: API key, API secret, lossy, WebP conversion, success logging.

The only other surface is a runtime-requirements check (`KrakenRequirementsHook`) that appears on the
status report: it verifies the `\Kraken` PHP class is loaded and, for each distinct Kraken.io account
configured across pipelines, calls the account `status()` endpoint and reports plan name and remaining
quota (warning under 5%). Operationally, every optimized derivative is a synchronous third-party round
trip, so first-render latency of new derivatives depends on Kraken.io availability.

- Depends on: `imageapi_optimize:imageapi_optimize`. Composer library: `kraken-io/kraken-php:^1.6`
  (supplies the global `\Kraken` class).
- Core: `^10.3.0 || ^11`. Package: none declared. License: GPL-2.0-or-later.
- No settings page / `configure` route, no permissions, no drush, no routes, no menu links. Provides
  **config schema** and one **ImageAPIOptimizeProcessor** plugin. Defines no plugin *types*.

## What you'd do → where

- **Add/configure the Kraken.io processor on an Image Optimize pipeline (options, config keys)** →
  [configure/processor.md](configure/processor.md)
- **Understand how it talks to Kraken.io — `applyToImage()` flow, the `\Kraken` client, quota/status
  requirements check** → [api/kraken-client.md](api/kraken-client.md)

## Key facts (real machine names)

- Processor plugin: id `kraken`, class
  `Drupal\kraken\Plugin\ImageAPIOptimizeProcessor\KrakenProcessor` (extends
  `imageapi_optimize`'s `ConfigurableImageAPIOptimizeProcessorBase`). Manager:
  `plugin.manager.imageapi_optimize.processor` (owned by `imageapi_optimize`).
- Config schema: `imageapi_optimize.processor.kraken` — keys `api_key` (string), `api_secret`
  (string), `lossy` (bool, default TRUE), `webp` (bool, default FALSE), `logging` (bool, default
  FALSE). Stored inside the host `imageapi_optimize.pipeline.<id>` config entity, not a standalone
  config object.
- Service: `Drupal\kraken\Hook\KrakenRequirementsHook` (autowired/autoconfigured); implements the
  `runtime_requirements` hook (`#[Hook('runtime_requirements')]`). `kraken.install` keeps a
  `#[LegacyHook]` `kraken_requirements()` shim delegating to it.
- Processor methods of note: `applyToImage($image_uri)`, `getKrakenClient(): ?\Kraken`,
  `getApiKeyHash()` (sha1 of `key:secret`), `buildConfigurationForm`/`submitConfigurationForm`,
  `getSummary`, `defaultConfiguration`.
- External endpoints (via `\Kraken`): `https://api.kraken.io/v1/upload`,
  `https://api.kraken.io/user_status` (and `/v1/url`, unused by this module).
- Logger channel: `imageapi_optimize`. Success logging is opt-in via the `logging` config key.
- Proxy: `getKrakenClient()` passes `Settings::get('http_client_config')['proxy']['https']` (if set)
  to the client; upload timeout is hardcoded to 5s (`@todo` to make configurable).
