<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Prelinker (prelinker) — agent index

`preload` / `preconnect` resource hints managed as **configuration**, delivered as
**`Link:` response headers** and/or `<link>` elements in the `<head>`. Both preconnect
domains and preload files are **configuration entities** (listable, exportable,
weight-ordered), and each carries **visibility conditions** (request path, content type,
language, theme, …). Admin at `/admin/config/system/prelinker`.
Version **3.0.0**. **Core requirement `^11` — Drupal 11 only.** Nothing is emitted on admin routes.

**Routes are guarded by `_permission: 'administer'`** — not a permission any core module
defines (there is no `prelinker.permissions.yml`; the entities also set
`admin_permission = "administer"`). In practice only user 1 reaches these pages (uid 1
bypasses permission checks) unless some module declares that exact name. Know this before
reporting the pages as broken.

## Mechanism
- **Two config entity types.** `preconnect` (`domain`, `weight`, `visibility`) and `preload`
  (`file`, `as`, `fetchpriority`, `weight`, `visibility`). Defined in `src/Entity/`,
  edited via `src/Form/`, listed via draggable `src/Controller/*ListBuilder.php`.
- **`<head>` delivery** — `prelinker_page_attachments()` in `prelinker.module` adds
  `<link rel="preconnect">` / `<link rel="preload">` render-array elements. Font preloads
  get `crossorigin`; `fetchpriority` is added when set.
- **`Link:` header delivery** — `src/Render/HeaderProcessor.php` **decorates**
  `html_response.attachments_processor` and appends `Link:` headers. It also **parses the
  rendered HTML** (`DOMDocument`/`DOMXPath`) to lift hints in automatically: `data-preload-image`
  attributes, existing `<link rel="preload">`/`<link rel="preconnect">`/`<link rel="stylesheet">`,
  and CSS `@import` URLs.
- **Settings** (`prelinker.settings`, form `src/Form/PrelinkerSettings.php`) are per-feature
  checkboxes: `preconnect_head`, `preload_head`, `preload_head_image` (head `<link>`); and
  `preconnect_push`, `preload_push`, `preload_push_image`, `preload_push_css`,
  `preload_push_preload`, `preload_push_preconnect` (Link headers). All default off.
- **Visibility** — entities use core condition plugins via
  `ConditionManager::getFilteredDefinitions('prelinker', …)`; the module does **not** define
  any plugin type of its own. Empty condition set ⇒ shown on all (non-admin) pages.

## Read next
- `config/resource-hints.md` — full configuration reference: entity fields, settings toggles,
  the two delivery modes, the DOM-scanning features, visibility conditions, and caveats.

## Notes
- The `src/Service/Prelinker.php` service (path/page matching helpers) is legacy from the 2.x
  page-restriction model; 3.x path scoping runs through the `request_path` condition plugin.
  `prelinker_update_10001()` migrates the old `pages` field into a `request_path` condition.
