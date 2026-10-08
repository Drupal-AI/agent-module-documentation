<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Fonts route and asset delivery

## Why a fonts route exists
The PHP Debug Bar ships Font Awesome, whose `font-awesome.min.css` references its font files with a relative path. That relative path does not resolve when the CSS is served through the `vendor://` stream wrapper, so the module provides a route that redirects the browser to the real font URL.

## Route (`debugbar.routing.yml`)
```
debugbar.fonts:
  path: '/fonts/{filename}'
  defaults:
    _controller: '\Drupal\debugbar\Controller\FontsController::getFont'
  requirements:
    _permission: 'access content'
```

## Controller — `FontsController::getFont(string $filename)`
Extends `ControllerBase`. Returns a `RedirectResponse` to:
`vendor_stream_wrapper_create_url('vendor://maximebf/debugbar/src/DebugBar/Resources/vendor/font-awesome/fonts/' . $filename)`.
The `{filename}` route parameter matches a single path segment (no slashes). The response is a redirect to the resolved vendor URL; the `debugbar.fonts` route is one of the two routes the `KernelEventSubscriber` excludes from `stackData()`.

## Asset library (`debugbar_library_info_build()` in `debugbar.module`)
The `debugbar` library is built at runtime from what the library's JS renderer reports:
- Local file: `js/debugbar.js`.
- Each reported JS asset → `vendor://maximebf/debugbar/src/DebugBar/Resources/<asset>` with `type: external`.
- Each reported CSS asset → same `vendor://...` path under `css.component`, `type: external`.
- `header: TRUE`; dependencies `core/drupal`, `core/jquery`.

All library JS/CSS/font delivery therefore relies on the `vendor_stream_wrapper` module being installed and able to serve files from the Composer `vendor/` directory.
