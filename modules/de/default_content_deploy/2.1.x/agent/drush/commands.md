# Drush commands

Registered in `drush.services.yml` as `default_content_deploy.commands`
(`Drupal\default_content_deploy\Commands\DefaultContentDeployCommands`, annotated
Drush 9+ style). A `pre-command` hook switches to an administrator account
(`AdministratorTrait::getAdministrator()` — user 1 when the super-user container
parameter is enabled, else the first active `administrator`-role user) and switches
back on `post-command`.

| Command | Aliases | Args | Purpose |
| --- | --- | --- | --- |
| `default-content-deploy:export` | `dcde` | `entity_type` | Export a single entity or a group of one entity type, **without** references. |
| `default-content-deploy:export-with-references` | `dcder` | `entity_type` | Export entities of one type **with** all referenced entities (recursive, depth-guarded). |
| `default-content-deploy:export-site` | `dcdes` | — | Export the whole site's content (all content entity types) + path aliases. |
| `default-content-deploy:import` | `dcdi` | — | Import all content found in the content directory; prompts for confirmation, then runs a batch. |
| `default-content-deploy:uuid-info` | `dcd-uuid-info`, `dcd-uuid` | `entity_type`, `id` | Print the UUID of one entity. |
| `default-content-deploy:entity-list` | `dcd-entity-list` | — | List all content entity types (`machine_name (label)`) available for export. |

## Options

**dcde** (`export`): `--entity_ids` (comma list), `--bundle` (comma list),
`--skip_entities` (comma list of IDs), `--skip-export-timestamp`, `--force-update`
(delete the folder first), `--folder`, `--changes-since` (date parsed by `\DateTime`;
only entities changed on/after it).

**dcder** (`export-with-references`): all of the above plus `--skip_entity_type`
(referenced entity types to skip) and `--text_dependencies` (bool; include entities
embedded in processed-text fields).

**dcdes** (`export-site`): `--skip_entity_type`, `--force-update`,
`--skip-export-timestamp`, `--folder`, `--changes-since`. (`--add_entity_type` is
deprecated/no-op.)

**dcdi** (`import`): `--force-override` (overwrite even non-newer/unchanged
entities), `--folder`, `--preserve-ids` (keep original entity IDs — skips entities
whose ID already exists), `--incremental` (skip entities whose export timestamp is
not newer than the last import), `--delete` (also process a `_deleted/` subfolder to
remove entities). `--verbose` prints a per-entity Entity Type / UUID / Action table.

## Import semantics (as implemented in `Importer`)

- Entities are matched by **UUID**. New UUID → created (ID reassigned unless
  `--preserve-ids`); existing UUID → updated only if the file's `changed` time is
  newer than the DB (or content differs), unless `--force-override`.
- Entity references are corrected to local IDs via a two-pass import (import, then a
  "correction" pass); path aliases are imported last so they can point at new IDs.
- `user` entities: after save, the exported password **hash** is written straight
  into `users_field_data.pass` (the entity API can't set a hash directly).
- Under CLI, each file is processed while switched to an administrator account.

Typical deploy loop: `drush cex && drush dcdes` (push side) →
`git pull && drush updb -y && drush cim -y && drush cr && drush dcdi -y` (pull side).
