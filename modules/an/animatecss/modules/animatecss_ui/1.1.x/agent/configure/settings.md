<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure AnimateCSS UI

Everything is gated by the `administer animate css` permission (`animatecss_ui.permissions.yml`).

## Routes (`animatecss_ui.routing.yml`)

| Route | Path | Purpose |
|---|---|---|
| `animatecss.admin` | `/admin/structure/animatecss` | List of animate records (the `configure` target). `AnimateCssAdmin`. |
| `animatecss.add` | `/admin/structure/animatecss/add` | Add a selector→animation record. `Form/AnimateCssForm`. |
| `animatecss.edit` | `/admin/structure/animatecss/edit/{animate}` | Edit a record. `Form/AnimateCssForm`. |
| `animatecss.delete` | `/admin/structure/animatecss/delete/{animate}` | Delete a record. |
| `animatecss.duplicate` | `/admin/structure/animatecss/duplicate/{animate}` | Clone a record. |
| `animatecss.settings` | `/admin/config/user-interface/animatecss/settings` | Global library/behavior settings. `Form/AnimateCssSettings`. |

## Per-selector records — DB table `animatecss`

Not config entities — plain DB rows (schema in `animatecss_ui.install`), managed by service `animatecss.animate_manager` (`AnimateCssManager`, tagged `backend_overridable`). Columns: `aid` (PK), `selector` (varchar 255), `label`, `comment`, `changed`, `status` (enabled bool), `options` (big blob — PHP-serialized option bag).

`AnimateCssManager` methods: `loadAnimate()` (enabled rows), `findAll($header,$search,$status)` (paged/sortable list, `escapeLike` search), `findById($aid)`, `addAnimate(...)` (merge/upsert), `removeAnimate($aid)`, `isAnimate($selector)`. All queries are parameterized. Serialized `options` are read with `unserialize($blob, ['allowed_classes' => FALSE])`.

Per-record option keys (serialized by `AnimateCssForm`): `animation` (name), `delay`/`time`, `speed`/`duration`, `repeat`, `event` (trigger), `once`, `clean`, `display` (fix display), plus optional scroll-library sub-arrays (e.g. `wow`, `aos`) with an `enable` flag — when a scroll library is enabled for a row it is skipped by the default init and handled by that library instead.

## Global settings — config `animatecss.settings`

Defaults from `config/install/animatecss.settings.yml`; schema `config/schema/animatecss.schema.yml`.

| Key | Default | Meaning |
|---|---|---|
| `load` | `true` | Master on/off for attaching Animate.css. |
| `silent` | `false` | Suppress the "library not installed / using CDN" status-report warning. |
| `method` | `local` | `local` (`/libraries/animate.css`) or `cdn` (forced to `cdn` if the local file is missing). |
| `compat` | (unset) | Use the `animate.compat.css` build (older class names). |
| `minimized.options` | `true` (1) | Variant index: `0`=source (`animate.css`), `1`=minified (`animate.min.css`). |
| `url.visibility` | `'0'` | Page-match mode: `0` = animate on all pages EXCEPT `url.pages`; `1` = animate ONLY on `url.pages`. |
| `url.pages` | admin/imce/node-add/edit/user-edit/print/batch/ajax paths | Path patterns for the visibility rule (`*` wildcards). |
| `options.selector` | `{}` | Global default selector(s). |
| `options.animation` | `fadeInUp` | Default animation. |
| `options.delay` / `options.time` | `''` | Default delay class / custom ms. |
| `options.speed` / `options.duration` | `medium` / `''` | Default speed / custom ms. |
| `options.repeat` | `''` | Default repeat. |
| `options.event` | `load` | Default trigger event. |
| `options.once` | `false` | Animate once. |
| `options.clean` | `false` | Remove prior Animate.css classes first. |
| `options.display` | `false` | Fix element display before animating. |

## Loading behavior (`animatecss_ui_page_attachments`)

When this submodule is enabled it (not the base module) attaches the library. Order: skip if `load` is off; skip if the page-visibility check `_animatecss_ui_check_url()` fails (respects `url.visibility`/`url.pages` and the `?animate=no` query bypass); pick `method` (falls back to `cdn` when local library absent) and `compat`/`variant` to choose one of the `animatecss_ui/animate-*` libraries; load enabled selector rows via the manager, merge with global `options.selector`, emit to `drupalSettings.animatecss.elements`, and attach `animatecss_ui/animate-init`.

## Notes

- Uninstalling the submodule deletes the `animatecss.settings` config row directly (avoids a re-install collision).
- The list/add/edit forms attach admin CSS/JS (`animatecss_ui/animate-form`, `animate-settings`) and a sample preview on `/admin/structure/animatecss/*`.
