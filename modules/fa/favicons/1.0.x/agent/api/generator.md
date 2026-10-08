<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# FaviconsGenerator service & Image styles

Service id `favicons.generator` (`favicons.services.yml`) = `Drupal\favicons\FaviconsGenerator`
(`src/FaviconsGenerator.php`). Constructor args: `@entity_type.manager`, `@messenger`, `@config.factory`,
`@file_url_generator`. (It also implements `ContainerFactoryPluginInterface`, but is registered as a plain
service — not a plugin type.)

## Image styles

`const IMAGE_STYLES` maps the two style ids to the head `rel` they populate:

- `96x96`  → `rel: icon`
- `180x180` → `rel: apple-touch-icon`

Both styles ship as **optional** config (`config/optional/image.style.96x96.yml`,
`image.style.180x180.yml`): a single `image_scale` effect at 96x96 / 180x180 with `upscale: false`. Because
they are optional config, they are installed if the Image module is enabled at install time.

## Methods

- `getDerivatives(int $fid): array` — loads the `file` entity for `$fid`, then for each style
  (`image_style` storage, keyed by `IMAGE_STYLES` keys) computes the derivative URI with `$style->buildUri()`.
  Returns `['image_uri' => <source uri>, 'derivatives' => [<styleId> => ['uri' => ..., 'rel' => ...]]]`.
- `generateIcons(int $fid): void` — calls `getDerivatives()` and for each style loads the `image_style` entity
  and runs `$style->createDerivative($sourceUri, $derivativeUri)`, physically producing the scaled PNG files.
  Invoked from the settings form's `submitForm()`.
- `getIcons(): array` — reads `favicons.settings:favicon`; returns `[]` when the fid is `0`/unset. Otherwise
  returns the source favicon (`rel: icon`, absolute URL from `file_url_generator`) plus one entry per derivative
  style with its absolute URL and `rel`. Consumed by `favicons_page_attachments()` to build the head `<link>`
  tags (see [../routes/endpoints.md](../routes/endpoints.md)).

## Notes for agents

- Derivatives are standard core image-style derivatives, generated on save (not lazily on the SVG/manifest
  routes); the routes and head injection read the already-resolved URIs.
- A missing/`0` `favicon` fid is the "not configured" state everywhere: `getIcons()` returns `[]`, and the
  two public controllers return a 404 (see routes doc).
- The service uses the site's default file scheme / image toolkit; there is no bespoke image processing code.
