<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Embera (Library) (embera) — agent index

Thin wrapper that installs the **mpratt/embera** PHP oEmbed library (`composer require` brings it into
`/vendor/`) and exposes **one Drupal service, `embera.manager`**, for turning supported media URLs
(YouTube/Vimeo/Twitter/etc.) into oEmbed data. Package `Libraries`. Core `^9 || ^10 || ^11`.
License GPL-2.0-or-later. Version 1.0.7.

Developer-facing only. **No** content types, fields, blocks, routes, permissions, admin form,
config schema, plugins, or Drush. Only a service + a `hook_requirements()` check. No Drupal module
dependencies; requires the `mpratt/embera:^2.0` Composer library.

- **The `embera.manager` service, its four methods, and the `Settings` that tune it** →
  [api/service.md](api/service.md)

## What it actually is (from source)

- `embera.services.yml` registers `embera.manager` → `Drupal\embera\EmberaServiceManager`, constructed
  with `@file_system` and `@settings`.
- `EmberaServiceManager` (`src/EmberaServiceManager.php`) builds one `\Embera\Embera` instance in its
  constructor and offers: `getEmbedInformation($url)`, `getThumbnailUrl($url)`, `getTitle($url)`,
  `getEmbedCode($url)`.
- `embera.install`: `embera_requirements()` reports whether `\Embera\Embera` class exists (ERROR if not).
- No `config/`, no `*.routing.yml`, no `*.permissions.yml`, no `src/Plugin/**`.
