<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DDECK PWA — hooks, SDC components & theme asset convention

All rendering lives in `ddeck_pwa.module` plus two Single Directory Components under `components/`.
There are no controllers or custom routes serving the manifest — the manifest/service worker belong
to the PWA module; this module only *alters* the manifest and *attaches* head tags.

## Hooks (`ddeck_pwa.module`)

- **`hook_theme()`** — declares `ddeck_pwa_navigation_block` (no variables), template
  `templates/ddeck-pwa-navigation-block.html.twig`, which is one line:
  `{% include 'ddeck_pwa:ddeck_pwa_navigation' %}`.
- **`hook_preprocess_html()`** — gets `ddeck_pwa.context`; if `shouldShowNavigation()` is false it
  returns. Otherwise sets `$variables['page_bottom']['ddeck_pwa_navigation'] = ['#theme' =>
  'ddeck_pwa_navigation_block']`, so the nav bar is appended to the bottom of every page.
- **`hook_page_attachments_alter()`** — attaches five `<meta>` tags to `html_head`:
  `mobile-web-app-capable`, `apple-touch-fullscreen`, `apple-mobile-web-app-title`
  (content = `PwaContext::getAppleAppTitle()`), `apple-mobile-web-app-capable`,
  `apple-mobile-web-app-status-bar-style` = `default`. Then iterates the module constant
  `DDECK_PWA_SPLASH_RESOLUTIONS` (28 iPhone/iPad width/height/ratio/orientation entries): for each it
  builds `<theme>/pwa/splash_screens/{w}x{h}@{r}x_{orientation}.png`, **skips it unless the file
  exists on disk** (`file_exists`), and otherwise adds an `apple-touch-startup-image`
  `html_head_link` with a `media` query matching the device and an `href` of
  `basePath + relative theme path`.
- **`hook_pwa_manifest_alter(array &$manifestData)`** — builds a fixed list of eight icon sizes
  (72→512), maps each to `<scheme+host+basePath>/<theme>/pwa/icons/<file>`, and keeps only files that
  exist. If at least one theme icon exists it **replaces** `$manifestData['icons']` with the theme
  icons; if the theme ships none, the PWA module's own icons are left untouched.

Splash-screen and icon URLs are derived from the **active theme path** and the request base URL —
not from request input or user-entered config — so there is no request-controlled path here.

## SDC: `ddeck_pwa_navigation` (`components/ddeck_pwa_navigation/`)

- `*.component.yml` — name *"DDECK PWA Navigation"*, `status: stable`, `props` object with
  `additionalProperties: false` (no props).
- `*.twig` — a `.ddeck-pwa-navigation` wrapper that first `include`s `ddeck_pwa:ddeck_pwa_loader`,
  then a `<nav class="... fixed-bottom ... d-flex md:d-none ...">` with four Bootstrap
  icon buttons carrying classes `pwa-nav-back`, `pwa-nav-forward` (starts `disabled`), `pwa-nav-home`,
  `pwa-nav-reload` and inline Bootstrap-Icons SVGs. Mobile-only via `d-flex md:d-none`.
- `*.js` — `Drupal.behaviors.ddeckPwaNavigation` uses `once()` on `.ddeck-pwa-navigation`.
  `DdeckPwaNavigation.init()` wires click handlers. When `'navigation' in window` (Navigation API) it
  calls `updateNavigationButtons()` and listens for `navigate` / `currententrychange` to enable/disable
  back/forward based on `window.navigation.currentEntry.index` vs `entries().length`. `getNavigate()`
  returns `window.navigation` or falls back to `window.history`. Handlers: `goBack`/`goForward`
  (`.back()`/`.forward()`), `goReload` (`location.reload()`), `goHome` (`location.href = '/'`).
  `*.css` holds component styling.

## SDC: `ddeck_pwa_loader` (`components/ddeck_pwa_loader/`)

- `*.component.yml` — *"DDECK PWA Loader"*, `status: stable`, no props.
- `*.twig` — `#ddeck-pwa-loader` full-screen overlay (`position-fixed ... d-flex md:d-none
  bg-primary`) containing a Bootstrap `spinner-border`.
- `*.js` — `Drupal.behaviors.ddeckPwaLoader` on `#ddeck-pwa-loader`. `init()` branches on
  `isSafari()` (UA regex). Non-Safari: show loader on `beforeunload`, hide on `load` and `pageshow`
  (re-enabling the forward button on `event.persisted`). Safari: bind a click handler to **all** `<a>`
  links (`bindSafariLinks`) to show the loader, and hide it on `pageshow`. `showLoader`/`hideLoader`
  toggle Bootstrap `d-none`/`d-flex`.

## Theme asset convention (what a theme must ship)

To get icons and splash screens, the **active theme** provides files under its own directory:

- `<theme>/pwa/icons/icon-{72,96,128,144,152,192,384,512}x{…}.png` → become manifest icons.
- `<theme>/pwa/splash_screens/{width}x{height}@{ratio}x_{orientation}.png` → become
  `apple-touch-startup-image` links (names must match `DDECK_PWA_SPLASH_RESOLUTIONS`).

Missing files are simply skipped, so partial sets are safe.
