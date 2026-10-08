<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Save & Edit (save_edit) — agent index

Adds a "Save & Edit" action to node add/edit forms that saves and redirects back to the
**edit form** (route `<entity>.edit-form`) instead of the default post-save page, with optional
auto-unpublish and default-button hiding/relabeling. Pure `hook_form_alter` + config; no
entities, plugins, or Drush.

Dependencies: Drupal core only (no contrib deps). `core_version_requirement: ^11.2 || ^12`.

- **All settings keys, per-content-type enablement, and permissions** →
  [configure/settings.md](configure/settings.md)
- **The form-alter mechanism (button cloning, submit handlers, redirect)** →
  [api/mechanism.md](api/mechanism.md)

Key facts:
- Config object: `save_edit.settings`. Configure route `save_edit.save_edit_settings_form`
  at `/admin/config/save_edit/settings`.
- A content type is enabled when `node_types.<bundle>` equals `<bundle>` (a "0" value = off).
- Button only appears for users with permission `use save and edit`.
- Permissions: `use save and edit`, `administer save and edit`.
- Node-only: it alters `\Drupal\node\Form\NodeForm`; no support for other entity types.
- Hooks are class-based: `\Drupal\save_edit\Hook\SaveEditHooks` (autowired service in
  `save_edit.services.yml`, `#[Hook]` attributes). `save_edit.module` keeps `#[LegacyHook]`
  wrappers plus the two procedural submit handlers (`save_edit_form_submit_presave`,
  `save_edit_form_submit_redirect`).

Branch/version: **3.0.x** (3.0.0), `core_version_requirement: ^11.2 || ^12`. Sites on Drupal 10 or
11.0/11.1 must use the 2.x branch instead.

## Diff 2.2.x → 3.0.x

Same feature and `save_edit.settings` config surface (identical schema, install, and settings
form). What changed in this branch:

- **Core requirement bumped:** `^11.2 || ^12` (was `^10 || ^11`). Drops Drupal 10 and 11.0/11.1.
- **Class-based hooks:** hook bodies moved from procedural `save_edit.module` into
  `\Drupal\save_edit\Hook\SaveEditHooks` (`#[Hook('help'|'form_alter'|'entity_bundle_create'|'entity_bundle_delete')]`),
  registered via `save_edit.services.yml` (`autowire: true`, ctor injects `ConfigFactoryInterface`
  and `AccountProxyInterface`). `save_edit.module` retains only `#[LegacyHook]` delegating wrappers
  and the two submit-handler functions (which core calls by name, so they stay procedural).
- **Pre-11.2 class guard removed:** because 11.2 is the floor, `formAlter()` references only
  `\Drupal\node\Form\NodeForm`; the old `\Drupal\node\NodeForm` `class_exists()` fallback is gone.
- **Behaviour unchanged:** the redirect handler still targets the entity's internal `edit-form`
  route and reissues an HTTP 303 when another handler already set a response; auto-unpublish and
  the hide/relabel toggles behave as in 2.2.x. Kernel tests in `tests/src/Kernel/*` cover the form
  alter, redirect, and settings-form access.
