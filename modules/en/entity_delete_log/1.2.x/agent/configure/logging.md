# Configure logging, table schema & report

## Turn logging on for an entity type

There is a settings form at `/admin/config/content/entity-delete-log`
(route `entity_delete_log.settings`, permission **administer site configuration**). It lists every
**content entity type** as a checkbox; ticking a type and saving stores the enabled ids in config.

Config object: `entity_delete_log.settings`, single key `entity_types` (array of entity-type ids).

```bash
# Read current selection
drush cget entity_delete_log.settings entity_types

# Enable logging for nodes and users (scriptable)
drush php:eval '\Drupal::configFactory()->getEditable("entity_delete_log.settings")->set("entity_types", ["node","user"])->save();'
```

The module reads this via `_edl_get_configured_entity_types()`; if the key is empty/absent nothing is
logged. There is **no config/install default**, so on a fresh install the value is absent (logs
nothing) until you save the form.

## What gets written, and when

- `hook_entity_predelete()` — for a **revisionable** entity, counts its revisions and stashes the
  count in `\Drupal::state()` under `"<type>:revisions:<id>"` (consumed and deleted on delete).
- `hook_entity_delete()` — if the entity's type is in `entity_types`, inserts one row into the
  base table **`entity_delete_log`**.

Row columns (schema in `entity_delete_log.install`):

| Column | Meaning |
|---|---|
| `entity_delete_log_id` | serial PK |
| `entity_id` | deleted entity id |
| `entity_type` | entity type id (e.g. `node`) |
| `entity_bundle` | bundle (e.g. `article`) |
| `entity_title` | `$entity->label()` at delete time |
| `author` | the entity author's uid (falls back to `1`; never the deleted user's own uid) |
| `revisions` | revision count for revisionable entities, else NULL |
| `created` | entity's created timestamp if it has one, else NULL |
| `deleted` | `time()` at deletion |
| `uid` | acting user (`\Drupal::currentUser()->id()`) |

Query it directly:

```bash
drush sqlq "SELECT entity_type, entity_id, entity_title, uid, deleted FROM entity_delete_log ORDER BY deleted DESC LIMIT 10"
```

## The report view

`/admin/reports/entity-delete-log` is a Views page display (view id `entity_delete_log`, provided as
default config `views.view.entity_delete_log`), gated by the **access site reports** permission
(set by `entity_delete_log_update_9001()` / the shipped view). It has exposed **Entity Type** and
**Entity Bundle** filters, sorts by `deleted` DESC, and adds relationships to both the acting user
(`uid`) and the original author (`author`) against `users_field_data`. Views field/filter/sort/
relationship metadata comes from `entity_delete_log_views_data()` in `entity_delete_log.views.inc`.

## What it does NOT provide

No permissions of its own (reuses core *administer site configuration* + *access site reports*), no
Drush commands, no plugins, no config schema. `configure` route = `entity_delete_log.settings`.
