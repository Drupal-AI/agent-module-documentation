<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Install, the `.module` hook, and running migrations

## Install / enable

`composer require drupal/edw_migrate_d7` then `drush en edw_migrate_d7`. Info.yml requires core
`^8.8.0 || ^9.0 || ^10 || ^11` and the modules `migrate`, `migrate_plus`, `migrate_tools`,
`migrate_drupal`. There is no `.install` file, no `config/`, no schema, no routes, no permissions,
no services and no Drush commands — enabling it only makes its plugin classes discoverable.

Two undeclared runtime needs: enable **`paragraphs`** before using the `paragraph_generate` process
plugin, and ensure **`league/csv`** is autoloadable before using the `csv` source plugin (it is not
in a composer.json here; it usually comes from `migrate_source_csv` or another require).

## `hook_migration_plugins_alter()` (`edw_migrate_d7.module`)

The module's only procedural code. For each discovered migration it:
1. `unset`s the migration if it has a `_discovered_file_path` key (i.e. any migration discovered
   from a YAML file rather than provided as config/derived);
2. otherwise `unset`s it if any entry in its `provider` contains the string `migrate_drupal`.

Effect: the automatically generated Migrate Drupal (D7 upgrade) migrations are removed, so the site
runs **only the explicit migration configs you define** (as `migrate_plus` config entities or a
migration group). Plan your upgrade as a full set of your own migrations rather than relying on the
generated ones.

## Authoring a migration

Reference this module's plugin ids in your migration YAML, e.g.:

```
source:
  plugin: edw_d7_node
  node_type: article
process:
  field_image:
    plugin: fid_download
    source: image_url
    destination: 'public://images'
  body/value:
    plugin: strip_inline_styles
    source: body_value
destination:
  plugin: 'entity:node'
```

D7 sources read from the `migrate` source database key you configure (standard Migrate Drupal
setup). The `edw_d7_user` source additionally reads `migrate_map_upgrade_d7_user_role`, so run the
user-role migration first.

## Running

Use Migrate Tools Drush commands as a trusted operator/CLI, e.g. `drush migrate:status`,
`drush migrate:import <id>` (or `--group=<group>`), `drush migrate:rollback <id>`. Only the
destinations that implement `rollback()` (`d7_locale_source`, `d7_locale_target`) can be rolled
back; `content_access` and `edw_draggableviews` cannot.
