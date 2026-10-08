<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Dismiss (dismiss) — agent index

Adds a jQuery-powered **"Dismiss" (close) button** to every block of Drupal **status / warning /
error messages** so a user can hide them without reloading. Package `User interface`. Core
`^8.8 || ^9 || ^10 || ^11`. License GPL-2.0-or-later. Version dir `8.x-1.x` (installed
`8.x-1.0-alpha2`).

- **The JS behavior, the library assets, the CSS, and the two `.module` hooks** →
  [behaviors/dismiss.md](behaviors/dismiss.md)

## What it actually is (from source)

- Pure front-end/UI convenience. **No** dependencies (composer `require` is empty), **no** routes,
  **no** permissions, **no** services, **no** plugins, **no** config or config schema (no `config/`
  dir), **no** install file, **no** Drush, **no** submodules.
- One asset library `dismiss/drupal.dismiss` (`dismiss.libraries.yml`) = `js/dismiss.js` +
  `css/dismiss.base.css`, dependencies `core/jquery` + `core/drupal`.
- Attached to **every page** by `dismiss_page_attachments()` in `dismiss.module`
  (`hook_page_attachments`). Also implements `dismiss_help()` (`help.page.dismiss`).

## Mechanism (from source)

- `Drupal.behaviors.dismiss` (in `js/dismiss.js`) prepends
  `<button class="dismiss"><span class="element-invisible"></span></button>` to each `.messages`
  element (skips ones that already have a `.dismiss` child), then binds a click handler that runs
  `$(this).parent().hide('fast')` and `event.preventDefault()`.
- The injected markup is a **static string** — no user/remote/config data is interpolated into it.
- Dismissal is **cosmetic and per-page-render only**: there is **no persistence** (no cookie, no
  `localStorage`, no server call), and Drupal still generates the same messages on the next request.

## Configuration / operation

- Install and enable; nothing else. There is no settings route (`configure` = null) and no
  auto-hide/timeout option in this source despite older project-page copy suggesting one.
