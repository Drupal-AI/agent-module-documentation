<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Enabling, configuring and operating Config Revision

## Install & enable

```bash
composer require drupal/config_revision
drush en config_revision -y
```

Only core dependency is **`system`**. (`webform` is a dev/test dependency only, not required at
runtime.) The revision UI is documented to rely on core issue **#2350939** to work fully.

## Opt config entity types in — the settings form

Route **`config_revision.settings`** → `/admin/config/development/config-revision` (menu:
*Configuration → Development → Configuration revision settings*), permission
**`administer config_revision`**. Backed by `src/Form/AdminSettingsForm.php`.

- The form lists every entity type implementing `ConfigEntityInterface` as checkboxes
  (`buildForm()` filters `entityTypeManager->getDefinitions()` and sorts by label).
- Submitting writes the checked ids to config object **`config_revision.settings`**, key
  **`enabled_entity_types`** (a sorted, filtered sequence of entity-type ids).
- `createConfigRevisionType()` then **creates a `config_revision_type` bundle** for each newly
  enabled type and **deletes** the bundle for each newly disabled type. So the set of revisionable
  config types is exactly the set of existing `config_revision_type` bundles.

Config object / schema:

```yaml
# config/install/config_revision.settings.yml
enabled_entity_types: {}
```

```yaml
# config/schema/config_revision.schema.yml
config_revision.settings:      # config_object; enabled_entity_types: sequence of strings
config_revision.type.*:        # config_entity; id (string), label (label), description (text)
```

## How a revision is captured

`config_revision.module` implements `hook_entity_insert`, `hook_entity_update`,
`hook_entity_delete`; each ignores non-`ConfigEntityInterface` entities and delegates to
`src/EntityHooks.php` (resolved via `\Drupal::classResolver`):

- `entityPostSave()` returns early unless a `config_revision_type` bundle exists for the saved
  config entity's type (i.e. the type is opted in). It loads the existing `config_revision` for the
  config id (`ConfigRevision::loadConfigRevisionByConfigId()`, matches on the `name` field) or
  creates one, sets `config` to `$entity->toArray()`, sets the revision user/time/log
  (`"A new revision is saved for %label"`) and calls `setNewRevision()` + `save()`.
- `entityPostDelete()` deletes the `config_revision` record for that config id.
- Config **import** does not fire these the same way, so imports do not spam the history (the
  module's stated behaviour: changes during config import are ignored).

## Routes & permissions (this is the security-relevant part)

Permissions (`config_revision.permissions.yml`):

| Permission | `restrict access` | Purpose |
|---|---|---|
| `administer config_revision type` | true | Manage `config_revision_type` bundles / fields. |
| `administer config_revision` | true | Full admin: settings form, collection, view/revert/delete revisions. |
| `view config_revision` | (not set) | Titled "View all config revision". |

Routes come from the entity's route providers, not a routing.yml (except the settings form):

- **Collection** `/admin/content/config-revision` and **version-history**
  `/config-revision/{config_revision}/revisions` are pinned to `_permission: administer
  config_revision` by `RouteProvider::getCollectionRoute()` and
  `RevisionRouteProvider::getVersionHistoryRoute()`.
- **Canonical / edit / delete / add** and the **revision view / revert / delete** routes use
  core's `_entity_access` requirements, so their gate is whatever
  `src/AccessControlHandler.php` returns for the corresponding operation.

`AccessControlHandler::checkAccess()` maps `view all revisions`, `view revision`, `revert` and
`delete revision` to `administer config_revision`; `view` allows admins, or published-entity view
for holders of `view config_revision`. Reverting is handled by
`src/Form/RevisionRevertForm.php` (a **confirm form**, so state changes go through POST + a form
token; it also renders a YAML `Diff` of current-vs-revision using `diff.formatter`).

**Operating guidance:** treat `administer config_revision` as the privileged permission — it can
view raw stored config and revert live configuration (a destructive, site-behaviour-changing
action, since reverted config can include roles, permissions, fields and access rules). Grant it
only to trusted administrators, and review exactly which permission you hand to reviewers/auditors
who only need to look. Enable revisioning only for the config types you actually need to track.

## Revert semantics

`RevisionRevertForm::submitForm()` resolves the target config entity type's config prefix, builds
the config name (`{prefix}.{revision-label}`), loads it editable, `setData()` from the stored
revision's `config` map, `save(TRUE)`, then resets the entity storage cache. So a revert writes the
stored snapshot straight back onto the live config object.
