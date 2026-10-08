<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Default Content Deploy (default_content_deploy) — agent index

Exports Drupal **content entities** (nodes, taxonomy, media, files, users, path
aliases, …) to per-entity JSON files and imports them into another environment,
preserving cross-references by UUID so content can be deployed like code (git,
CI) and synced continuously. Version **2.1.4**, core `^10.3 || ^11.0`.

Dependencies: core `hal` (module). Composer libs: `laminas/laminas-stdlib`,
`rogervila/array-diff-multidimensional`, `ext-dom`. Note: composer.json declares a
`conflict` with `drupal/better_normalizers` and `drupal/search_api:<1.36`.

Configure route: `default_content_deploy.settings` (`/admin/config/development/dcd`);
the info.yml `configure` link points to `default_content_deploy.import`. Defines
permissions, Drush commands, config schema, dispatched events, and overrides several
core HAL normalizers via a ServiceProvider. Submodule: `search_api_default_content_deploy`.

- **Run export/import from the CLI (dcde/dcder/dcdes/dcdi + info commands)** → [drush/commands.md](drush/commands.md)
- **Set the content directory and export options** → [configure/settings.md](configure/settings.md)
- **Grant who may import/export via the UI** → [permissions/permissions.md](permissions/permissions.md)
- **Call the Exporter / Importer / DeployManager services from code** → [api/services.md](api/services.md)
- **Hook into export serialization or import save (events)** → [events/events.md](events/events.md)

## Key facts

- Config object: `default_content_deploy.settings` (keys: `content_directory`,
  `text_dependencies`, `skip_export_timestamp`, `skip_entity_types`, `batch_ttl`,
  `skip_computed_fields`, `skip_processed_values`).
- Services: `default_content_deploy.exporter` (`ExporterInterface`),
  `default_content_deploy.importer` (`ImporterInterface`),
  `default_content_deploy.manager` (`DeployManager`),
  `default_content_deploy.metadata`, `logger.channel.default_content_deploy`.
- Drush: `default-content-deploy:export|export-with-references|export-site|import|uuid-info|entity-list`
  (aliases `dcde`, `dcder`, `dcdes`, `dcdi`, `dcd-uuid-info`, `dcd-entity-list`).
- Permissions: `default content deploy import`, `default content deploy export`.
- Routes: `default_content_deploy.settings`, `.import`, `.export`, `.export.download`.
- Events (class-named constants in `DefaultContentDeployEvents`): `PRE_SERIALIZE`,
  `POST_SERIALIZE`, `PRE_SAVE`, `POST_SAVE`, `IMPORT_BATCH_FINISHED`.
- Hook: `hook_cron` (garbage-collects orphaned import/export batch queue items per `batch_ttl`).
