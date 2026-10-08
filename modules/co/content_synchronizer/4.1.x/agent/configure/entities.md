<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Dashboard, Export & Import entities, publish/update strategies

There is **no `configure` route / global settings form** ("No specific configuration is
needed"). You work through two content entity types and a dashboard.

## Dashboard & routes

- `/admin/content_synchronizer` — dashboard (perm: *access content synchronizer dashboard*),
  under *Content* in the admin menu.
- `/admin/structure/export_entity` — Export entity collection (add/edit/delete/canonical).
- `/admin/structure/import_entity` — Import entity collection.
- Other routes: `content_synchronizer.export_confirm`, `content_synchronizer.quick_export`
  (Quick Export controller), `content_synchronizer.download_archive`.

## Export entity (`export_entity`)

A named, reusable set of entities to export (content entity, base table `export_entity`; the
member list lives in table `content_synchronizer_export_items`). Workflow:

1. *Add Export entity*, give it a name, add the entities you want to ship.
2. Launch the export → the module builds a `tar.gz` archive you download.

Bulk alternative: the **"Export entity"** action (`export_entity_action`, config
`system.action.export_entity_action`) on a Views bulk-operations listing, and the **Quick
Export** link to export a single entity immediately.

## Import entity (`import_entity`)

An uploaded archive plus its run state (content entity, base table `import_entity`). Fields
include `archive` (the uploaded file) and `processing_status`
(`STATUS_NOT_STARTED=0`, `STATUS_RUNNING=1`, `STATUS_DONE=2`). Workflow: *Add Import*, upload the
`tar.gz`, then launch the import choosing the two strategies below.

## Publish strategy (on creation)

Constant on `Drupal\content_synchronizer\Processors\ImportProcessor`:

| Value | Meaning |
|---|---|
| `publication_publish` | Publish imported content on creation (**default**) |
| `publication_unpublish` | Import but leave unpublished |
| `publication_revision` | Import as a new revision |

## Update strategy (when the entity already exists)

| Value | Meaning |
|---|---|
| `update_if_recent` | Overwrite only if the incoming content is more recent (**default**) |
| `update_systematic` | Always overwrite the existing entity |
| `update_no_update` | Never touch entities that already exist |

References survive across sites because `GlobalReferenceManager` maps each exported entity to a
stable UUID/global id, so relationships reconnect and updates target the right existing entity.

Programmatic/CLI equivalents: see [../drush/commands.md](../drush/commands.md) and
[../api/services.md](../api/services.md).
