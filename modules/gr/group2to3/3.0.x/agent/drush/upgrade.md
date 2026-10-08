<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# group2to3 — running the upgrade

Throwaway migration module. Run once, then uninstall and remove it.

## Procedure
1. Be on the latest **Group 2.x**, with configuration fully synchronized (`drush cex`).
2. Back up the database.
3. Enable this module: `drush en group2to3 -y`.
4. Swap the Group major version: `composer require 'drupal/group:^3.0' -W`.
5. Run database updates: `drush updb -y`. This runs the ordered step pipeline (batched, resumable).
6. Export the resulting config: `drush cex -y`.
7. Test the site, then `drush pmu group2to3 -y` and `composer remove drupal/group2to3`.

## Step pipeline (ordered)
Executed by the `group2to3.migrate.upgrade` service, one step per batch iteration, progress tracked in the sandbox:
1. `CopyConfigurations` — Group Content → Group Relationship config (types + fields).
2. `CopyData` / `UpdateEntityDefinitionsInstalled` — create new tables, migrate rows, update installed entity definitions.
3. `UpdateFieldEntityReferenceTargetTypeConfiguration`, `ReplaceNewBundleGroupRelationship`.
4. `UpdateViewsConfiguration` — rewrite Views using `group_content` to `group_relationship`.
5. `RemoveOldConfigurations`, `FinalStep` — cleanup.

## Custom steps
For site-specific Group config, add a plugin in your module's `src/Plugin/StepMigrateGroup2To3/`, annotated `@StepMigrateGroup2To3`, extending `Drupal\group2to3\MigrateGroup2To3\StepPluginBase` and implementing `execute(array &$sandbox)` returning a progress value. See the `group2to3_step_examples` submodule for `SimpleExampleStep` / `SandboxExampleStep`.