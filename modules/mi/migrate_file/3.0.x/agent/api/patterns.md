<!--
SPDX-FileCopyrightText: © 2025 Agent Module Documentation contributors
SPDX-License-Identifier: GPL-2.0-or-later
-->
# Patterns, config-entity build, and caveats

## Static vs dynamic destinations

`destination` (and `uid`) can take a **source** value, a **`@destination`** reference
(prefix with `@`, wrap the whole value in quotes), or a `constants/…` value. To hard-code a
path you must route it through a constant, because a bare string is read as a source
property:

```yaml
source:
  constants:
    file_destination: 'public://path/to/save/'   # trailing slash = directory
    sep: '/'
process:
  # dynamic per-row folder: public://save/<field1>/<field2>/
  _dest:
    plugin: concat
    source:
      - constants/file_destination
      - '@field1'
      - constants/sep
      - '@field2'
      - constants/sep
  field_file:
    plugin: file_import
    source: file
    destination: '@_dest'
    uid: '@uid'
```

A **trailing slash** on the destination means "directory" — the source's original basename
is appended. Without it, the value is treated as the full target filename.

## `id_only` for managing sub-fields yourself

```yaml
field_image/target_id:
  plugin: file_import
  source: image
  destination: constants/dest
  id_only: true
field_image/alt: image_alt
```

## Building a migration config entity (no YAML file needed)

With `migrate_plus` installed, migrations are `migration` config entities under the config
prefix **`migrate_plus.migration.<id>`**. You can create one entirely in code/`drush php`:

```php
\Drupal::entityTypeManager()->getStorage('migration')->create([
  'id' => 'import_article_images',
  'label' => 'Import article images',
  'migration_group' => 'default',
  'source' => [
    'plugin' => 'embedded_data',
    'data_rows' => [['id' => 1, 'img' => '/var/www/html/web/core/misc/druplicon.png', 'name' => 'Logo']],
    'ids' => ['id' => ['type' => 'integer']],
    'constants' => ['dest' => 'public://imported/'],
  ],
  'process' => [
    'name' => 'name',
    'field_media_image' => [
      'plugin' => 'file_import',
      'source' => 'img',
      'destination' => 'constants/dest',
    ],
  ],
  'destination' => ['plugin' => 'entity:media', 'default_bundle' => 'image'],
])->save();
```

Inspect it back with `drush config:get migrate_plus.migration.import_article_images process`.

## Running it

Normally: `drush migrate:import <id>` (needs `migrate_tools`). Programmatically:

```php
$m = \Drupal::service('plugin.manager.migration')->createInstance('import_article_images');
(new \Drupal\migrate\MigrateExecutable($m, new \Drupal\migrate\MigrateMessage()))->import();
```

`file_import` creates the managed `file` entity as a side effect of populating the file/image
field; the file lands at the resolved `destination` URI.

## Caveats

- **Alpha:** the installed release is `3.0.0-alpha1`.
- **Remote plugins need a stream wrapper.** `file_remote_url` / `file_remote_image` store the
  URL as the file URI and do **not** download; without `drupal/remote_stream_wrapper` (or an
  equivalent handler) those files won't resolve.
- **`entity:file` is the wrong destination for `file_import`.** `file_import` already creates
  the file entity and returns a `target_id`; point it at a file/image **field** on a node,
  media, user, etc. — not at an `entity:file` destination.
- **Runtime note for this documentation site:** the migration plugin manager here fails to
  build because an unrelated legacy `pathauto_pattern` upgrade template is missing its
  `source_module` property, so `drush migrate:*` (and even single-migration `createInstance`)
  throw `BadPluginDefinitionException`. Creating, reading and exporting `migrate_plus.migration`
  **config entities** works normally (that is what the eval `hard` tier verifies); only the
  migrate *runtime* is blocked on this particular install.
