<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Copyscape (copyscape) — agent index

Integrates the paid **Copyscape Premium** plagiarism API. On node create/edit, selected long-text
fields are sent to Copyscape and, if the returned percent-match exceeds a threshold, the save is
blocked (or warned) and per-user failures are counted; repeated failures block+log out the editor.

- **Version dir:** 8.x-4.x (installed 8.x-4.3). `core_version_requirement: ^10 || ^11`, PHP `^8.1`.
- **Dependencies:** Drupal core only (uses `node`, `user`); no contrib or Composer libraries.
- **Requires** a purchased Copyscape subscription — the API is not available on free accounts.

## What it provides
- **Content entities** (`src/Entity/`): `copyscape_result` (logged API responses per node) and
  `copyscape_fail` (per-user failure counter). Both use `CopyscapeAccessControlHandler`
  (`src/Access/`) gated by the `administer copyscape entities` permission, and share
  `CopyscapeDeleteForm` (`src/Form/CopyscapeDeleteForm.php`).
- **Services** (`copyscape.services.yml`):
  - `copyscape.api` → `Drupal\copyscape\Copyscape\Api` — builds and sends the Copyscape request,
    parses the XML reply (`textSearch()`, `apiCall()`, `readXml()`).
  - `copyscape.utility` → `Drupal\copyscape\Copyscape\Utility` — bypass checks, field/bundle
    selection, threshold evaluation (`wasSuccessful()`), fail counting, result logging.
- **Hooks** (`copyscape.module`): `hook_form_alter` adds a validate handler to node add/edit forms;
  `copyscape_form_validate()` runs the check; `hook_ENTITY_TYPE_insert/update` on `node` logs
  results; `hook_form_field_config_edit_form_alter` adds a per-field "check" toggle.
- **Routes** (`copyscape.routing.yml`) & **forms**: `copyscape.settings_api`
  (`/admin/config/copyscape/api`, `CopyscapeApiUserForm`), `copyscape.settings_content`
  (`/admin/config/copyscape/content`, `CopyscapeContentForm`), `copyscape.results`
  (`/copyscape/results`, `ResultsController`), and the result delete form.
- **Permissions** (`copyscape.permissions.yml`): `administer copyscape`,
  `administer copyscape entities` (both `restrict access: true`).
- **Config** (`config/install/`, schema `config/schema/copyscape.schema.yml`): `copyscape.settings`
  (API credentials + bypass/fail/log options) and `copyscape.content` (thresholds + per-bundle
  field selection).

## Solution docs
- Configuration, routes, permissions, entities: [agent/config/settings.md](config/settings.md)
- API client & the check/validate flow: [agent/api/client.md](api/client.md)
