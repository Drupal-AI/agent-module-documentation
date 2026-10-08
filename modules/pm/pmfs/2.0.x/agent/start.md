<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Prevent Multiple Form Submissions (pmfs) — agent index

Server-side blocking of duplicate/concurrent submissions of the same form, plus a service
API to guard custom operations with the same lock. No JavaScript is relied upon. Version
**2.0.0** (packaged 2023), core `^10 || ^11`. Settings at `/admin/config/system/pmfs`
(gated by `administer site configuration`). Ships **no permissions, no Drush commands, no
plugin types**; provides config schema and config-translation.

## Mechanism (read the source, not the acronym — "pmfs" = Prevent Multiple Form Submissions)
- `pmfs.module` `hook_form_alter` delegates to the `pmfs` service (`src/Pmfs.php`). A
  `hook_module_implements_alter` pushes pmfs to run **last** among form_alter hooks.
- For each **enabled** form id, `Pmfs::formAlter()` injects handlers on every button:
  `formValidate` (runs first in `#validate`), `formSubmitFirst` (first in `#submit`) and
  `formSubmitLast` (last in `#submit`). AJAX callbacks are wrapped by `formAjaxCallback`.
- On submit it **acquires a core persistent lock** (`@lock.persistent`) with a key of
  `pmfs.form.<form_id>.<cookie>`, where `<cookie>` is the `pmfs_key` cookie set by
  `src/EventSubscriber/Cookie.php` on `kernel.request`. `formValidate` rejects a second
  submission while the lock is held, with the configured message.
- **timeout** (default 30s) = how long the lock is held. **skip_timeout** = release the lock
  the moment the initial submit finishes (only guards true concurrency, not the window).
- So the discriminator is **visitor-cookie + form_id + timeout window**, per visitor. It is
  idempotency/serialisation, **not** a rate limiter and **not** cross-visitor protection.

## What it provides
- One config form route: `pmfs.settings` → `\Drupal\pmfs\Form\Settings` (`src/Form/Settings.php`).
- Service `pmfs` (`Drupal\pmfs\Pmfs`, aliased to the class) — the public API for custom code.
- Config object `pmfs.settings` with `form.<id>` and `custom.<id>` maps (schema in
  `config/schema/pmfs.schema.yml`; defaults in `config/install/pmfs.settings.yml` under
  `form._global`).
- A **development mode** (State `pmfs.dev_mode.enabled`) that records every rendered form id
  in `pmfs.dev_mode.detected_form_ids` so admins can find ids to configure; when on, first
  use of a custom id auto-creates its config entry.

## Files
- `src/Pmfs.php` — the whole engine (form alter, lock acquire/release, settings getters, custom API).
- `src/Form/Settings.php` — admin UI (per-form and per-custom items, add/remove via AJAX, dev tools).
- `src/EventSubscriber/Cookie.php` — sets the `pmfs_key` per-visitor cookie.
- `pmfs.routing.yml`, `pmfs.services.yml`, `pmfs.links.*.yml`, `pmfs.config_translation.yml`.

## Detail docs
- `agent/api/service-api.md` — using the `pmfs` service to guard custom controllers/operations.
- `agent/config/settings.md` — configuration model, keys and the admin form.

## Security posture
The only route is admin-gated; there is no user-supplied query, no DB query built from input,
no search/autocomplete endpoint, no SSRF vector. Per-visitor lock namespaces mean one visitor
cannot lock out another.
