<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cacheviz — install, settings, permissions

## Install / enable

`composer require drupal/cacheviz` then `drush en cacheviz`. No dependencies beyond core `^11` and PHP `>=8.3`.
No `.install` file, no schema/tables, no update hooks. On enable, `config/install/cacheviz.settings.yml` seeds
the config object. Being enabled as a module is **not** enough to show anything — the `enabled` config flag must
also be TRUE (see gating below).

## Settings form

`Drupal\cacheviz\Form\SettingsForm` (`src/Form/SettingsForm.php`), a standard `ConfigFormBase`
(form id `cacheviz_settings`), editing config object `cacheviz.settings`.

- Route `cacheviz.settings`: `GET /admin/config/development/cacheviz`, `_permission: 'administer cacheviz'`
  (`cacheviz.routing.yml`). Menu link under *Configuration → Development* (`cacheviz.links.menu.yml`,
  parent `system.admin_config_development`, weight 10). This is the **only** route in the module.
- It is a normal Drupal config form: submission goes through core's CSRF-protected form flow; `submitForm()`
  casts `enabled`/`auto_highlight_problems` to bool and stores `excluded_paths` verbatim.

## Config object `cacheviz.settings`

Schema `config/schema/cacheviz.schema.yml` (`type: config_object`); install defaults
`config/install/cacheviz.settings.yml`.

| Key | Type | Default | Meaning |
|-----|------|---------|---------|
| `enabled` | boolean | `true` | Master switch. When FALSE, no comment injection and no asset/settings injection on any page. |
| `auto_highlight_problems` | boolean | `true` | Passed to JS as `autoHighlight`; auto-highlights problem elements on load. |
| `excluded_paths` | string | `/admin`, `/admin/*`, `/user/login`, `/user/register`, `/user/password` (one per line) | Newline-separated path patterns; `*` wildcards. Matched by core `path.matcher`. |

`provides_config_schema: true`. No config entities.

## Permissions

`cacheviz.permissions.yml`, both flagged `restrict access: true`:

- **`view cacheviz debug`** — required to see any visualization. Checked in `Renderer::shouldProcessRequest()`
  and `ResponseSubscriber::shouldProcess()` via `currentUser->hasPermission(...)`.
- **`administer cacheviz`** — required to reach the settings form.

## Gating logic (must ALL be true to visualize)

Implemented identically in `Renderer::shouldProcessRequest()` and `ResponseSubscriber::shouldProcess()`:

1. `cacheviz.settings:enabled` is TRUE, **and**
2. current user has `view cacheviz debug`, **and**
3. `PathMatcher::isCurrentPathExcluded()` is FALSE — i.e. the current path (from `path.current`) does not match
   any `excluded_paths` pattern via core `path.matcher` (`src/PathMatcher.php`).

`Renderer` caches this decision per-request in `$this->shouldProcess`.

## Operating notes

- Clear caches after toggling `enabled` or editing excluded paths so already-rendered output is regenerated.
- The default exclusions keep the panel off admin and auth pages. Add checkout/sensitive flows as needed.
- Intended for development/staging only; it surfaces internal cache metadata (tags, contexts, keys). Do not
  enable on production.
