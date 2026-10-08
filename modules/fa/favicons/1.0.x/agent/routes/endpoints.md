<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Public routes & head injection

Controllers: `Drupal\favicons\Controller\FaviconsController` (`src/Controller/FaviconsController.php`).
Both routes require `_permission: 'access content'` (`favicons.routing.yml`).

## `/site.webmanifest` — `siteWebmanifest()`

Route `favicons.site.webmanifest`. Reads `favicons.settings`; if the `favicon` fid is `0`/unset it returns an
empty `404` Response. Otherwise it calls `FaviconsGenerator::getDerivatives($fid)` and builds a web app manifest
array: `name`, `short_name`, an `icons` list (one entry per derivative style with absolute `src`, `sizes`,
`type: image/png`, `purpose: maskable`), `theme_color` and `background_color` (each the configured hex prefixed
with `#`), and `display: standalone`. The array is serialised with `Drupal\Component\Serialization\Json::encode()`
and returned as the response body.

## `/favicon.svg` — `faviconSvg()`

Route `favicons.svg`. Reads `favicons.settings`; returns an empty `404` when the `favicon` fid is `0`/unset or
when `getimagesize()` on the source file yields nothing. Otherwise it reads the width/height of the configured
source image and returns an SVG document that embeds the source PNG as a base64 `data:` URI inside an
`<image>` element sized to the source dimensions. The file rendered is always the single configured
`favicons.settings:favicon`; the route takes no file/path argument.

## Head injection — `favicons_page_attachments()`

`favicons.module` implements `hook_page_attachments()`:

1. Removes any existing `html_head_link` entry whose `rel` is `icon` (so a theme's default favicon is dropped).
2. Calls `favicons.generator`'s `getIcons()` and, for each returned icon, appends an `html_head` `<link>` with
   `rel`, `href` (absolute URL), `type: image/png`, and a `sizes` attribute for derivative entries.
3. Appends `<link rel="icon" type="image/svg+xml" href="/favicon.svg">`.
4. Appends `<link rel="manifest" href="/site.webmanifest">`.

These tags are emitted through Drupal's normal head-attachment render pipeline. `hook_install()` sets the module
weight to `9999` so this hook runs after theme-provided favicon markup; the placement only takes effect after a
cache rebuild (`drush cr`).

## Operating notes

- Nothing is emitted until a source PNG is configured — both routes 404 and `getIcons()` returns `[]`,
  so no icon/manifest tags render.
- The `access content` permission on the two routes matches their purpose: they are read-only asset endpoints
  meant to be fetched by browsers/devices alongside normal page content.
