# Source plugins & migration definitions

## Source plugins (`src/Plugin/migrate/source/`)

| Plugin id | Class | Reads (legacy tables) | Notes |
|---|---|---|---|
| `d7_webform` | `d7/D7Webform` | `webform` + `node`/`node_revision` | Builds Webform `elements` YAML from components; `RollbackAwareInterface` |
| `d7_webform_submission` | `d7/D7WebformSubmission` | `webform_submissions` + `webform_submitted_data` | One row per submission |
| `d6_webform` | `d6/D6Webform` | D6 `webform` + node tables | D6 equivalent of `d7_webform` |
| `d6_webform_submission` | `d6/D6WebformSubmission` | D6 submission tables | D6 equivalent |

All extend `Drupal\migrate_drupal\Plugin\migrate\source\DrupalSqlBase`, annotated
`@MigrateSource(... core = {7}/{6}, source_module = "webform", destination_module = "webform")`.
`DrupalSqlBase` reads from the Migrate **source database** connection (usually named
`migrate`), not the current site DB — so these plugins need a legacy DB configured.

## Migration definitions (`migrations/*.yml`)

Migration ids match the source plugin ids: `d6_webform`, `d7_webform`,
`d6_webform_submission`, `d7_webform_submission`.

`d7_webform` (tags: `Drupal 7`, `Configuration`):
- destination `plugin: entity:webform`.
- process maps `webform_id`←`id`, `uid`←`node_uid`, `title`, `status`, `elements`, `handlers`,
  `access`, and a set of `settings/*` keys (page, page_submit_path, wizard_progress_bar,
  preview, draft, draft_auto_save, confirmation_type, confirmation_url/message, limit_total,
  limit_user) — some from `constants`, some from source fields.
- `migration_dependencies`: required `d7_user_role`; optional `d7_node:webform`.

`d7_webform_submission` (tags: `Drupal 7`, `Content`):
- destination `plugin: entity:webform_submission`.
- process maps `sid`, `webform_id`, `uri`, `created/completed/changed`←`submitted`,
  `in_draft`←`is_draft`, `remote_addr`, `uid`, `entity_type`=node, `entity_id`←`nid`,
  `data`←`webform_data`.
- `migration_dependencies`: required `d7_webform`.

The D6 definitions mirror these against D6 source tables.

## Running / reusing

- **Full upgrade:** run the Drupal-to-Drupal migration (e.g. Migrate Drupal UI or
  `drush migrate:upgrade`); `migrations/state/webform_migrate.migrate_drupal.yml` registers
  this module as the one that "finishes" the legacy `webform` module for D7, so these
  migrations join the generated upgrade set.
- **Manual / migrate_plus:** configure a legacy source database connection, then create a
  `migrate_plus.migration` config entity (or copy the shipped YAML) whose `source.plugin` is
  `d7_webform` / `d7_webform_submission`, and execute with `drush migrate:import` (migrate_tools).
- Import order: webform first, then its submissions (submission migration depends on it).
