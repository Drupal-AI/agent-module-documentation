<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Claro Tiles (claro_tiles) — agent index

A **CSS-only admin UX** module that restyles Drupal's core admin index listings
(`.admin-list` / `.admin-item` markup — e.g. `/admin/content`, `/admin/config`,
`/admin/structure`) from the default vertical list into a **responsive grid of
tiles**. Package `Custom`. Core `^10 || ^11`. License GPL-2.0-or-later.
Installed **1.0.1** (version dir `1.0.x`).

## What it provides (from source — the module is 6 files, no PHP logic beyond one hook)

- **`claro_tiles.module`** — a single `hook_page_attachments()` implementation.
  It checks `\Drupal::service('router.admin_context')->isAdminRoute()` and, on any
  admin route, attaches the library `claro_tiles/admin_styles`. That is the module's
  entire behavior.
- **`claro_tiles.libraries.yml`** — one library `admin_styles`, a single theme CSS
  file `css/admin.css`. No JS, no library dependencies.
- **`css/admin.css`** — turns `.admin-list` into a CSS grid whose column count
  scales by viewport breakpoint (1 column below 512px, up to 6 columns at 1821px+;
  2 columns inside `.layout-column--half`), boxes each `.admin-item` as a
  bordered/padded tile with a hover background, and makes the whole tile clickable
  via an absolutely-positioned `a:before` overlay. It uses Claro CSS custom
  properties (`--color-gray-200`, `--color-bgblue-hover`, `--color-text`,
  `--color-link`), so the styling only renders meaningfully when the **Claro** admin
  theme is active — though the library is attached on admin routes regardless of the
  active theme.

## What it does NOT have (verified — no such files exist)

- **No routes, no controllers, no forms, no services** (no `.routing.yml`,
  `src/`, `.services.yml`).
- **No permissions** (no `.permissions.yml`) — `data.json` previously claimed
  `provides_permissions: true`; corrected to `false`.
- **No config, no config schema, no settings form** (no `config/` directory) —
  `data.json` previously claimed `provides_config_schema: true`; corrected to
  `false`. There is nothing to configure; enabling the module is the whole setup.
- **No install/update/uninstall hooks** (no `.install`), no templates, no submodules,
  no Composer library requirements.

## Dependencies

None declared in `.info.yml`. Practically depends on the **Claro** admin theme for
its CSS variables to resolve. Supports Drupal 10 and 11.

## Usage

Enable the module and ensure Claro is the admin theme. No configuration. Admin
index pages that use the core `.admin-list`/`.admin-item` markup render as a tile
grid automatically.
