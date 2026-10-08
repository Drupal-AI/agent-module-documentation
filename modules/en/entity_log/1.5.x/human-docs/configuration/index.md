# Configuration

All settings live on one form at **Configuration → Entity Log**
(`/admin/config/entity-log`). You need the **Administer entity log entities**
permission, which is a restricted, admin-only permission. The choices are saved
to the `entity_log.configuration` config object.

## Choose where changes are logged

Two master toggles decide where recorded changes go — you can turn on either or
both:

- **Log in logger** (`log_in_logger`) — writes each change to the Drupal logger
  on the `entity_log` channel, so it shows up in your dblog / syslog trail. Good
  for a lightweight, low-overhead record.
- **Log in entity** (`log_in_entity`) — creates a dedicated **Entity Log**
  content entity for each change. These are queryable, viewable, and can be
  reported on with Views.

> **If both are off, nothing is logged.** Entity Log checks this first and stops
> early when neither target is enabled.

## Set the row limit

- **Row limit** (`row_limit`) — the maximum number of rows to keep in the Entity
  Log table. On each cron run, older records beyond this limit are deleted so the
  table does not grow forever. Leave it at 0 (or empty) to disable pruning.

## Pick which fields to watch

The form lists the fieldable entity types on your site, their bundles, and the
fields on each. Tick the specific fields you want to track — only the fields you
check are watched. For example, you might watch just the *Status* and *Price*
fields on your Product content type, ignoring everything else.

Keeping the selection tight is the point: you get a focused change history for
the fields that matter (status flags, prices, assigned users, roles) rather than
noise from every edit.

## Setting it from the command line

If you would rather script the configuration — for example to watch the *title*
field on the Article content type and store changes as entities:

```bash
ddev drush cset entity_log.configuration log_in_entity 1 -y
ddev drush cset entity_log.configuration node.article.fields.title title -y
```

> **Note on config schema:** this version does not ship a config schema file for
> these settings. Everything works, but if you need strict config
> validation/translation for the keys, add a schema in your own module.

## Permissions

Set these under **People → Permissions**:

| Permission | What it allows |
|------------|----------------|
| **Administer entity log entities** | Reach the settings form and administer the log entities. This is the restricted, admin-only permission and the entity's admin permission. |
| **Access entity log overview** | See the log listing at **Structure → Entity log**. |
| **View published / View unpublished entity log entities** | View recorded change records. Grant these only to roles allowed to see the old/new field values, which may be sensitive. |
| **Add / Edit / Delete entity log entities** | Manually create, edit, or delete log entities (the module normally creates them for you). |

## Reviewing the log

Recorded changes appear at **Structure → Entity log**
(`/admin/structure/entity_log`). Each record has its own page showing the
changed field, the old value versus the new value, the source entity, the acting
user, and the hostname. Because Entity Log entities are fieldable and expose
Views data, you can add your own fields to them and build custom change reports.
