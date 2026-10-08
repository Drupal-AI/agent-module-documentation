<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure: enable entity types and bundles

Editorial access is enabled in two layers: a site-wide list of **entity types**, then a
per-**bundle** toggle carried as a third-party setting.

## 1. Site settings (which entity types participate)

- Route: `editorial_access_manager.settings` → `/admin/config/content/editorial-access-manager`
  (permission `administer site configuration`; this is the `configure` route in the `.info.yml`).
- Form: `Drupal\editorial_access_manager\Form\SettingsForm`.
- Config object: `editorial_access_manager.settings`, single key `entity_types` — a map of
  `entity_type_id => bool`. Only content entity types that have a bundle config entity are offered
  (node, taxonomy_term, media, comment, and any contrib content entity with bundles). Default when
  unset: `node` and `taxonomy_term` if present.

Saving with `node`'s membership toggled (added or removed) triggers `node_access_rebuild(TRUE)`.
The form warns that caches must be cleared before the per-entity "Manage editorial access" tabs appear
(the route subscriber and link templates are built from this list).

Set it with Drush:

```bash
drush cset editorial_access_manager.settings entity_types.node true -y
drush cset editorial_access_manager.settings entity_types.taxonomy_term true -y
drush cr
drush php:eval "node_access_rebuild(TRUE);"
```

Read the active list in PHP: `\Drupal::service('editorial_access_manager.manager')->getSupportedEntityTypesList()`.

## 2. Per-bundle enablement (third-party settings)

`hook_form_alter` adds an **"Editorial manager access"** fieldset to every bundle edit form (node type,
vocabulary, media type, …) whose entity type is enabled above. It stores two third-party settings under
the `editorial_access_manager` namespace on the bundle config entity:

| Key | Type | Meaning |
|-----|------|---------|
| `enabled` | bool | Turns editorial assignment on for this bundle. Assignment UI, node grants, and the entity-access hook all check this. |
| `entity_references_enabled` | list of entity type ids | If an assigned entity references entities of these types, assignees inherit edit access to those referenced entities too (tracked in the `editorial_access_references` table). |

Config schema is declared for `node.type.*`, `taxonomy.vocabulary.*`, `media.type.*`,
`comment.type.*` (`config/schema/editorial_access_manager.schema.yml`). Other contrib entity types work
at runtime but should add their own `*.third_party.editorial_access_manager` schema.

Set on a node type in PHP:

```php
$type = \Drupal::entityTypeManager()->getStorage('node_type')->load('article');
$type->setThirdPartySetting('editorial_access_manager', 'enabled', TRUE);
$type->setThirdPartySetting('editorial_access_manager', 'entity_references_enabled', ['media']);
$type->save();
node_access_rebuild(TRUE); // node types only
```

Saving the bundle form runs `editorial_access_manager_entity_bundle_config_form_submit`; for node types
it rebuilds node grants. Changing `entity_references_enabled` later triggers a batch
(`editorial_access_manager_update_entity_reference_batch`) that re-syncs the references table for already
assigned content.

## Assigning editors at runtime

Once a bundle is enabled, users with an `assign …` permission get a **Manage editorial access** tab on
each entity (route `entity.<type>.editorial_access_management`, path `<canonical>/editorial-access`) and a
per-language **Configure** link opening the assignment form
`editorial_access_manager.editorial_assignment`
(`/editorial-access-manager/editorial-assignment/{entity_type_id}/{entity_id}/{langcode}`). Assignments are
stored per entity + language + user in the `editorial_access` table. See
[../api/service.md](../api/service.md) for the programmatic API and access mechanism.
