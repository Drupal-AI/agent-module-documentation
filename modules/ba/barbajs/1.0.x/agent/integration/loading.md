<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Barba JS — library loading & attachment (base module)

Everything the base `barbajs` module does. No permissions, routes, services, entities or plugins.

## Install / enable

`drush en barbajs`. `barbajs_install()` only adds a status message. Enabling is enough to get Barba core
on every front-end page (see auto-attach below). Enable the **barbajs_ui** submodule if you want a config
UI instead — when it is on, the base module stops auto-attaching (below).

## Defined libraries (`barbajs.libraries.yml`)

Local (bundled) builds serve JS from the module's `dist/**`:

| library id | file | notes |
|---|---|---|
| `barbajs/barba` / `barba.min` | `dist/core/barba.umd[.min].js` | Barba core, v2.10.3 |
| `barbajs/barba_css` / `.min` | `dist/css/barba-css.umd[.min].js` | CSS plugin, v2.1.16 |
| `barbajs/barba_prefetch` / `.min` | `dist/prefetch/barba-prefetch.umd[.min].js` | Prefetch plugin, v2.2.0 |
| `barbajs/barba_router` / `.min` | `dist/router/barba-router.umd[.min].js` | Router plugin, v2.1.11 |

CDN counterparts (`barba.cdn`, `barba.cdn.min`, `barba_css.cdn[.min]`, `barba_prefetch.cdn[.min]`,
`barba_router.cdn[.min]`) declare the same versions as `{ type: external }` protocol-relative URLs on
`cdn.jsdelivr.net/npm/@barba/<pkg>@<version>/…`. All libraries carry the upstream MIT `license`.

## Auto-attach (`hook_page_attachments`, `barbajs_page_attachments`)

1. Returns early during installation (`InstallerKernel::installationAttempted()`).
2. **Only attaches when `barbajs_ui` is NOT installed** — `if (!$module_handler->moduleExists('barbajs_ui'))`.
   When the UI submodule is enabled, it owns attachment (`barbajs_ui_page_attachments`) and the base hook
   does nothing.
3. Attaches `barbajs/barba.min` when `barbajs_check_installed()` is TRUE, otherwise `barbajs/barba.cdn.min`.

So the base module always attaches the **minified core** only; plugins and the non-minified variant are
opt-in through the UI submodule.

## Local-vs-CDN detection

- `barbajs_check_installed()`: TRUE if `dist/core/barba.umd.min.js` exists inside the module path
  (`module_handler->getModule('barbajs')->getPath()`). If not present (e.g. dist/ stripped), it calls
  `barbajs_find_library('barba')` and checks `DRUPAL_ROOT/<library_path>/dist/core/barba.umd.min.js`.
- `barbajs_find_library($library_name = 'barba')`: builds a core `LibrariesDirectoryFileFinder`
  (`$root`, `site.path`, `extension.list.profile`, `\Drupal::installProfile()`) and returns
  `->find($library_name)`. Standard `/libraries` discovery — the path is a fixed library name, not
  request input.

## Writing transitions

The module attaches the library but defines **no** `barba.init()` call. Add your own in a theme/module JS,
e.g.:

```js
barba.init({
  transitions: [{
    name: 'fade',
    leave: ({ current }) => gsap.to(current.container, { opacity: 0 }),
    enter: ({ next }) => gsap.from(next.container, { opacity: 0 }),
  }],
});
```

Barba requires a `data-barba="wrapper"` container and `data-barba="container"` regions in your theme's
page markup (see barba.js.org docs). GSAP or the Barba CSS plugin are optional animation drivers.

## hook_help

`help.page.barbajs` renders an About/Features/"How it loads"/Basic-usage help page (static strings and a
HEREDOC code sample; no dynamic input). It points to the Barba JS UI submodule for advanced control.
