<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings, permissions, routes, fallback content

## Install / enable

`drush en entity_language_access -y`. Only core `language` is required (see
`entity_language_access.info.yml`, `dependencies: [drupal:language]`). Once enabled the access check is
active for all qualifying entity types with no further setup. `.install` and `.module` are empty stubs
(no hook_install/schema; `entity_language_access.services.yml` sets
`entity_language_access.skip_procedural_hook_scan: true`).

## Permissions (`entity_language_access.permissions.yml`)

- **`administer entity_language_access`** — required to reach the settings form.
- **`bypass entity_language_access`** — holders see the canonical view of any entity in any language; the
  access check short-circuits to `allowed()` for them (see `access/language-access.md`).

## Routes / menu / tasks

- Route `entity_language_access.admin_settings_form` → path `/admin/config/regional/entity_language_access`,
  `_form: AdminSettingsForm`, `_permission: 'administer entity_language_access'`
  (`entity_language_access.routing.yml`).
- Menu link under `system.admin_config_regional` (`*.links.menu.yml`); local task "Settings"
  (`*.links.task.yml`); config-translation mapping `entity_language_access.settings`
  (`entity_language_access.config_translation.yml`).

## Settings form (`src/Form/AdminSettingsForm.php`)

`ConfigFormBase` using `RedundantEditableConfigNamesTrait`. Form id `entity_language_access_admin_settings`.
Fields (fieldset "Fallback Content"):

- `is_fallback_content_enabled` — checkbox, `#config_target` `entity_language_access.settings:is_fallback_content_enabled`.
- `fallback_content_nid` — `entity_autocomplete` (`#target_type: node`, `target_bundles: ['page']`),
  `#required`, shown/required only when the checkbox is on (`#states`). Its `ConfigTarget` stores the node
  id and, when loading, resolves it back to a node via `entityTypeManager->getStorage('node')->load()`.

Form help states the fallback node **must** be translated into all available languages and be accessible
to all users.

## Config object

`entity_language_access.settings` (`config/install/…settings.yml`, schema in `config/schema/…schema.yml`,
type `config_object`):

- `is_fallback_content_enabled` (boolean, default `false`).
- `fallback_content_nid` (integer, default `0`).

## Fallback content behaviour (`src/EventSubscriber/FallbackContent.php`)

`FallbackContent extends CustomPageExceptionHtmlSubscriber`, priority `-49` (runs before core's `-50` 403
handler). In `on403()`:

1. `needsRedirect()` returns TRUE only when the failed route carried requirement
   `_entity_language_access == 'true'` **and** the `_access_result`'s reason equals
   `EntityLanguageAccess::REASON` — i.e. the 403 came from this module, not any other access denial.
2. If fallback is disabled (`is_fallback_content_enabled` false / config new) it does nothing → default
   403 page.
3. If enabled and `fallback_content_nid >= 1`, it calls `makeSubrequestToCustomPath($event, '/node/' . $nid,
   Response::HTTP_FORBIDDEN)` — the fallback node is rendered while the HTTP status stays **403**.

If the configured node id is `< 1` it also falls through to the default 403.
