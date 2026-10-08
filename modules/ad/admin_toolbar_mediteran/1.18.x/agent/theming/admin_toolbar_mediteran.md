<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Theming — how the Mediteran restyle works

The module is a **styling layer only**. It ships CSS + icon images and attaches them to the
existing toolbar. It renders no new markup, defines no Twig templates or theme hooks, and has
no PHP classes, routes, permissions, config or settings form. There is nothing to configure —
enabling it applies the skin.

## The one library (`admin_toolbar_mediteran.libraries.yml`)

A single library, `admin_toolbar_mediteran/admin_toolbar_mediteran`, bundling ten theme-CSS
files (all at `weight: 1000` so they load after the assets they override). No JS. The files,
grouped by the admin surface they restyle:

| Directory | Files | Restyles |
|---|---|---|
| `css/admin_toolbar/` | `admin.toolbar.css`, `tools.css` | The contrib Admin Toolbar dropdown menus. |
| `css/toolbar/` | `toolbar.theme.css`, `toolbar.icons.theme.css`, `toolbar.module.css`, `toolbar.menu.css` | Core toolbar bar, its menu, and toolbar icons. |
| `css/shortcut/` | `shortcut.theme.css`, `shortcut.icons.theme.css` | The Shortcut module's bar/links. |
| `css/user/` | `user.icons.admin.css` | User-menu icons. |
| `css/coffee/` | `coffee.css` | The Coffee module's quick-search dialog (the former "Coffee Mediteran" project, now merged in). |

Icons come from `images/icons/` (SVGs plus jQuery-UI icon sprites), referenced by the CSS.

## Attachment logic (`admin_toolbar_mediteran.module`)

Five procedural hooks, every one gated on the private helper
`_admin_toolbar_mediteran_is_access()`, which returns
`\Drupal::currentUser()->hasPermission('access toolbar')` — so nothing loads for users who
cannot see the toolbar:

- `hook_page_attachments_alter()` — attaches the `admin_toolbar_mediteran` library globally.
- `hook_preprocess_html()` — adds the **body class** `admin-toolbar-mediteran`. The module's
  selectors are scoped under this class, so the skin does not leak to the front end / non-toolbar
  users.
- `hook_toolbar_alter()` — sets `class => ['user-toolbar-tab']` on the toolbar `user` item's
  wrapper attributes, so CSS can push the account tab to the right.
- `hook_library_info_alter()` — **unsets** the stock CSS it replaces: `admin_toolbar`'s
  `toolbar.tree` → `css/admin.toolbar.css`, and core `toolbar`'s `toolbar` → `css/toolbar.theme.css`.
  Also gated on `access toolbar`.

## Customizing / overriding

Everything is plain CSS scoped under the `.admin-toolbar-mediteran` body class. To tweak it,
load your own CSS after this library (higher weight, or a library that depends on it) and
override the selectors. There are no PHP or render-element extension points.

## Compatibility caveat

`core_version_requirement` is a very wide `^8 || ^9 || ^10 || ^11`, and `.info.yml` still
reports the legacy `version: '8.x-1.18'`. Wide CSS compatibility is not visual compatibility:
Drupal admin markup changed substantially across 8→11, and on a Drupal 11 site using the
**Navigation** module instead of the classic toolbar, these selectors may target markup that
is no longer rendered. Verify the look in a browser rather than trusting the range. The
project's own status is "No further development".
