<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush export/import commands

Class `Drupal\default_content_access\Commands\DefaultContentAccessCommands`
(`src/Drush/Commands/DefaultContentAccessCommands.php`) extends `default_content`'s
`DefaultContentCommands`. It overrides the two module-scoped commands so that, on top of the base
node export/import, the per-node Content Access grant settings travel with the content.

## Install / enable
```
composer require drupal/default_content_access
drush en default_content_access -y
```
Pulls in `drupal/default_content ^2.0` and `drupal/content_access ^2.0`. No config to set.

## Constructor / service wiring
`create(ContainerInterface $container)` builds the command with:
- `default_content.exporter` (`ExporterInterface $defaultContentExporter`) — reused from the parent.
- `%container.modules%` container parameter → `installedExtensions` (string[] of installed module names).
- `module_handler`, `file_system`, `database` core services.
There is no `drush.services.yml`; Drush 12+ discovers the command from the `#[CLI\Command]` attributes.

## Command: export
`default-content-access:export-module <module>` (alias `dcaem`), method `contentExportModule($module)`.
1. Returns early if `<module>` is not in `installedExtensions`.
2. Calls `parent::contentExportModule($module)` — the normal Default Content export of the module's nodes.
3. `defaultContentExporter->exportModuleContent($module)` yields serialized content keyed by entity type.
4. Ensures `<module path>/access/` exists (`FileSystemInterface::CREATE_DIRECTORY`) and deletes any old
   `access/node.json`.
5. For each exported node UUID, selects `settings` from the `content_access` table joined to `node` on
   `ca.nid = n.nid` with `n.uuid = <uuid>`; non-empty settings are collected keyed by UUID.
6. Writes the map to `access/node.json` with `json_encode(..., JSON_THROW_ON_ERROR)`. If no node has
   Content Access settings, no file is written.

## Command: import
`default-content-access:import-module <module>` (alias `dcaim`), option `--update-existing` (default
FALSE), method `contentImportModule(string $module, array $options)`.
1. Returns early if `<module>` is not installed.
2. Guard: if `DefaultContentCommands::contentImportModule` does not exist, returns (the base import
   command had not yet landed upstream — see default_content issue #2640734).
3. Calls `parent::contentImportModule($module, $options)` — the normal Default Content import.
4. Reads `<module path>/access/node.json`; returns if absent.
5. Resolves each exported node UUID to its local `nid` via a `node` table select
   (`uuid IN (...)` → `uuid => nid` keyed pairs).
6. `DELETE FROM content_access WHERE nid IN (<those nids>)`, then a single multi-row
   `INSERT INTO content_access (nid, settings)` from the file, wrapped in try/catch (failure is
   currently swallowed — a `@todo` to log it).
7. Calls `node_access_rebuild()` so core node-access grants reflect the imported settings.

## Data flow summary
`content_access.settings` (per node) ⇄ `<module>/access/node.json` (UUID → settings blob), tied to
nodes exported by Default Content into `<module>/content/`. Import is destructive for the targeted nids:
it replaces their `content_access` rows before rebuilding grants.

## Notes for agents
- CLI-only; nothing is web-reachable. Both commands no-op unless the named module is installed.
- The module does not implement `hook_node_access`/grants or a UI — it just moves Content Access's own
  stored settings. Review an imported `access/node.json` before shipping, since it dictates the grants
  applied to the matching nodes on the target site.
- Queries use Drupal's database API with placeholder conditions (no string concatenation).
