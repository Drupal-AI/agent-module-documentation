<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure — Replicate UI

Admin form: **Configuration › Content authoring › Replicate**
`/admin/config/content/replicate` — route `replicate_ui.settings`
(`\Drupal\replicate_ui\Form\ReplicateUISettingsForm`), requires the
`administer site configuration` permission. Also linked from `admin/config`
(menu link `replicate_ui.settings`).

## Config object: `replicate_ui.settings`

| Key | Type | Default | Meaning |
|---|---|---|---|
| `entity_types` | sequence of strings | `[]` | Machine ids of the **content** entity types that get a Replicate UI. Only content entity types that have a `canonical` link template are offered/honoured. |
| `check_edit_access` | boolean | `false` | If `true`, also require core update (edit) access on the original entity, adding `_entity_access: {type}.update` to each replicate route. |

Schema: `config/schema/replicate_ui.schema.yml`. Install default:
`entity_types: []`, `check_edit_access: false` (out of the box nothing is replicable).

## What enabling a type wires up

When an entity type id is in `entity_types` (and it is a `ContentEntityType` with a
`canonical` link template), the module, on **route rebuild**, adds for that type:

- Route `entity.{type}.replicate` at `/{canonical}/replicate`
  (e.g. node → `/node/{node}/replicate`), form `{type}.replicate`
  (`ReplicateConfirmForm`), requirement `_replicate_access: TRUE`.
- A `replicate` **link template** and the confirm form class on the entity type
  (via `hook_entity_type_build`).
- A **local task** "Replicate" tab on the canonical page
  (deriver `ReplicateUILocalTasks`).
- An **entity-operation** "Replicate" link on admin listings
  (`hook_entity_operation`).
- A derivative of the `entity_replicate` **Action** and the `replicate_ui_link`
  Views field become available for that type.

The confirm form asks for a **New label** (one field per language for translatable
entities), defaulting to `"{label} (Copy)"`, then calls the replicator and redirects
to the new entity's canonical page.

## Set it with Drush (equivalent to the form)

```bash
# Enable Replicate UI for nodes; optionally require edit access on the original.
drush cset replicate_ui.settings entity_types.0 node -y
drush cset replicate_ui.settings check_edit_access true -y
# IMPORTANT: routes, tabs and the link template are only (re)built on a rebuild.
drush cr
```

Or in PHP (sets the whole list at once, then rebuilds):

```php
\Drupal::configFactory()->getEditable('replicate_ui.settings')
  ->set('entity_types', ['node', 'taxonomy_term'])
  ->set('check_edit_access', FALSE)
  ->save();
drupal_flush_all_caches(); // or `drush cr` — needed so routes/local tasks appear
```

Read the current setup back:

```bash
drush cget replicate_ui.settings
```

Gotcha: the settings **form** flags a router rebuild for you; when you write the
config directly (Drush/PHP) you must run `drush cr` (or rebuild the router) yourself,
otherwise the `entity.{type}.replicate` route and the Replicate tab will not exist.
