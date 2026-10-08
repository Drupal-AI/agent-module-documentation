<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Htaccess (htaccess) — agent index

An administrative interface for the site's root `.htaccess`. One config form loads Drupal's
default (scaffold) `.htaccess` content, lets an admin append extra Apache directives, and on save
concatenates the two and writes the result to `DRUPAL_ROOT/.htaccess`. Optionally the same
combined content is re-written on every cron run.

- Package `Administration`. Core `^10 || ^11`. No module dependencies. License GPL-2.0-or-later.
  Version **3.0.0**.
- Ships one submodule, **`robotstxt_utils`** (deletes the physical `robots.txt`), documented in
  its own tree — see below.

## What it provides

- **Route** `htaccess.admin_settings_form` → `/admin/config/system/htaccess`
  (`_form: HtaccessAdminSettingsForm`), permission **`administer htaccess`**
  (`restrict access: true`). Menu link under *Configuration → System*; one local task "Settings".
- **Form** `Drupal\htaccess\Form\HtaccessAdminSettingsForm` (extends `ConfigFormBase`) — the whole
  UI and the file write.
- **Config** `htaccess.settings` (`config/install`, `config/schema`).
- **Hooks** `htaccess_help()`, `htaccess_cron()` (in `.module`); `htaccess_install()`,
  `htaccess_requirements()`, `htaccess_update_10001()` (in `.install`).
- **Controller** `Drupal\htaccess\Controller\HtaccessController::content()` — would emit the
  `.htaccess` body as `text/plain` and invoke `hook_htaccess()`, but **no route references it**
  (unreachable in this release).

## Solution docs

- **The settings form, config keys, cron write, install/requirements** →
  [config/settings.md](config/settings.md)

## Submodule (own nested tree)

- **Robots.txt Utils** (`robotstxt_utils`) →
  `modules/ht/htaccess/modules/robotstxt_utils/3.0.x/` — adds a "Delete physical robots.txt"
  checkbox to the Robotstxt module's settings form and removes `DRUPAL_ROOT/robots.txt` on save
  and cron. Requires the contrib `robotstxt` module.

## Notes from source

- Default source path is `core/assets/scaffold/files/htaccess`; the read-only preview textarea
  shows whatever that path contains.
- `htaccess_requirements()` reports an error on the status page when clean URLs are off or when
  `DRUPAL_ROOT` is not writable.
- Config key `default_htaccess_path` is written by the form but is **absent from
  `htaccess.schema.yml`** (schema declares only `content`, `configuraciones_extra`,
  `reemplazar_automaticamente`). Key `content` is declared and set by `hook_install()` but is
  never written by the form.
