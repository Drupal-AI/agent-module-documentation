<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# migmag_process — agent index

Adds migrate **process plugins** + an improved migrate-stub service. No config, routes,
permissions, or Drush. Depends on `migmag`. Has its own submodule
`migmag_process_lookup_replace` (forces core `migration_lookup` → `migmag_lookup`).

- **The seven process plugins (ids, config options, examples)** →
  [plugins/process-plugins.md](plugins/process-plugins.md)
- **The `migmag_process.lookup.stub` alternative stub service** →
  [api/migrate-stub.md](api/migrate-stub.md)

Plugin ids (discover via `plugin.manager.migrate.process`): `migmag_lookup`, `migmag_try`,
`migmag_compare`, `migmag_target_bundle`, `migmag_get_entity_property`, `migmag_uuid_generate`,
`migmag_logger_log`.
