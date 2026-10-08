<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Resave All Nodes (resave_all_nodes) — agent index

Maintenance tool that re-saves every node — or every node of selected content types —
through Batch API, so that presave/update logic added after the content was created
finally runs against it (path aliases, Search API queue, computed fields, metatag
defaults, denormalised values, revisions, entity-update event subscribers). Two triggers
share one batch class: an admin form and a Drush command.

Depends on core `node`. Core requirement `^8.8 || ^9 || ^10 || ^11`.
No stored config object / no config schema. `configure` route: `resave_all_nodes.form`.

- **Trigger it from the UI (the form, content-type filter, chunk size, runtime behavior)** →
  [configure/form.md](configure/form.md)
- **Trigger it from the CLI (the Drush command, options, aliases)** →
  [drush/commands.md](drush/commands.md)
- **Who is allowed to run it** →
  [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Route `resave_all_nodes.form` at `/admin/config/development/resave-all-nodes`, form
  `\Drupal\resave_all_nodes\Form\ResaveAllNodesForm`, gated by `_permission: 'resave all nodes'`.
- Single permission `resave all nodes` (`restrict access: TRUE`). No other roles can reach the form.
- Menu link `resave_all_nodes.toolbar_menu` under `system.admin_config_development`.
- Drush command `resave-all-nodes` (alias `ran`), options `--bundles`, `--chunk-size` (default 250);
  service `resave_all_nodes.commands` = `\Drupal\resave_all_nodes\Commands\ResaveAllNodesCommands`
  (registered in `drush.services.yml`).
- Shared batch: `\Drupal\resave_all_nodes\Batch\ResaveAllNodesBatch::batchOperation()` /
  `::batchFinished()`. It calls `$node->save()` and also saves every non-default translation.
- Heavy operation: it fires every presave/update hook, may create a revision per node, moves
  `changed` timestamps, and re-populates queues. Prefer the Drush path on any real-volume site.
- `.info.yml` reports legacy `version: '8.x-1.0-beta2'` — this branch has only alpha/beta releases.
- Note: Drush core added its own `drush entity:save node` (since 11.0.0-rc1) which overlaps this.
