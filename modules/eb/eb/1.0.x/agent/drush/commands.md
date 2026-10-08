<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# eb — Drush commands

Provided by `src/Drush/Commands/` (Drush `^12|^13`). All are `eb:*`.

## Import / validate / preview (`EbImportCommands`)
- `eb:import <file>` (alias `ebi`) — Import a YAML file as an `eb_definition` (created for review, not applied). Options: `--execute` (apply immediately), `--force` (overwrite existing id), `--full` (with preview). Enforces `import_max_file_size`.
- `eb:validate <file>` (alias `ebv`) — Validate a YAML file (build + two-stage validation); returns non-zero on errors.
- `eb:preview <file>` (alias `ebp`) — Preview operations from a file. `--full` shows the detailed per-operation list; default is a summary. (Uses `Traits\PreviewHelperTrait`.)

## Export / generate / list (`EbExportCommands`)
- `eb:generate <definition_id>` (alias `ebg`) — Reverse-engineer existing site entities into a new definition. Options: `--entity-type=`, repeatable `--bundle=`, `--label=`. Uses `DefinitionGenerator`.
- `eb:export <definition_id> <output>` (alias `ebe`) — Export a stored definition to a YAML file (optionally HMAC-signed via `ExportSecurityService`).
- `eb:list` (alias `ebl`) — List all definitions.

## Discovery (`EbDiscoveryCommands`)
- `eb:discovery` (alias `ebd`) — Show all discovered capabilities (field types, widgets, formatters, bundles) from `DiscoveryService`.

## Rollback (`EbRollbackCommands`)
- `eb:rollback-list` (alias `ebrl`) — List rollback operations. Options: `--definition=`, `--status=`.
- `eb:rollback <id>` (alias `ebr`) — Execute rollback record `<id>`.
- `eb:rollback-definition <definition_id>` (alias `ebrd`) — Roll back all pending rollbacks from a definition. `--force` continues past failures.
- `eb:rollback-purge [days]` (alias `ebrp`) — Delete rollbacks older than `days` (defaults to `rollback_retention_days`).

## Typical CI/CD flow
```bash
drush eb:validate model.yml
drush eb:preview  model.yml --full
drush eb:import   model.yml --execute --force
# later, if needed:
drush eb:rollback-definition <definition_id>
```
`provides_drush_commands: true`.
