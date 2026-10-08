<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring the Entity warmer

Plugin id **`entity`**. Config path **`warmer.settings:warmers.entity`**
(schema `warmer.settings.warmer_plugin.entity`):

```yaml
warmers:
  entity:
    id: entity
    frequency: 300        # shared: seconds between re-enqueues on cron
    batchSize: 50         # shared: entities loaded per batch
    entity_types:         # entity_type_id:bundle pairs to warm
      'node:article': 'node:article'
      'node:page': 'node:page'
    published_only: true  # only warm published entities (EntityPublishedInterface)
```

- `entity_types` — a keyed list of `entity_type_id:bundle` strings. In the settings UI this
  is a multi-select of every bundle on the site.
- `published_only` — when true, the ID query adds an access check and a published-status
  condition for entity types that have a `published` key.

## Set it up

UI: *Configuration › Development › Cache warming › Settings* → the **Entity** tab, at
`/admin/config/development/warmer/settings`.

Drush / scripted:

```bash
drush cset warmer.settings warmers.entity.frequency 3600 -y
drush cset warmer.settings warmers.entity.batchSize 100 -y
# entity_types is a list; set it with php:eval when scripting:
drush php:eval '\Drupal::configFactory()->getEditable("warmer.settings")
  ->set("warmers.entity.entity_types", ["node:article" => "node:article"])
  ->set("warmers.entity.published_only", TRUE)->save();'
```

Then warm it: `drush warmer:enqueue entity` (add `--run-queue` to populate cache now).
