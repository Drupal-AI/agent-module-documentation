<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Migrates a site from Group 2.x to Group 3.x by running an ordered set of step plugins during `drush updb`.

---

Group 3 renamed the *group content* subsystem to *group relationships* and changed table/entity definitions; this module carries existing data and configuration across that break instead of forcing a manual rebuild. Enabling it registers a `hook_update_N` that, on `drush updb`, walks an ordered pipeline of step plugins (`@StepMigrateGroup2To3`): copy Group Content configuration to Group Relationship (types + fields), create the new tables and copy the rows, update installed entity-definitions, fix entity-reference target-type field configuration, rewrite Views that used `group_content`, then remove the old configuration. The pipeline is progress-tracked in the batch sandbox so it resumes across batch iterations.

It is a throwaway migration tool: install it while still on Group 2.x, `composer require drupal/group:^3.0`, run `drush updb`, export config, verify, then uninstall and remove the module. Steps are pluggable — extend `StepPluginBase` to migrate site-specific Group-related config. No routes, no permissions, no services exposed to end users; all work runs under the update runner with the operator's privileges. Always back up the database and export config before running.

---

- Upgrade a site from Group 2.x to Group 3.x without rebuilding groups by hand.
- Run the migration as part of `drush updb` after switching to `drupal/group:^3.0`.
- Convert Group Content configuration (types + fields) to Group Relationship.
- Create the Group 3 database tables and copy existing rows into them.
- Update installed entity definitions for the new Group schema.
- Fix entity-reference field target-type configuration changed in Group 3.
- Rewrite Views that referenced `group_content` to use `group_relationship`.
- Remove the old Group 2 configuration after data is migrated.
- Resume a long migration safely across batch iterations (progress-tracked sandbox).
- Add a custom step plugin to migrate site-specific Group-related config.
- Extend `StepPluginBase` and annotate `@StepMigrateGroup2To3` for a new step.
- Inspect the ordered step list via the `plugin.manager.step_migrate_group2to3` manager.
- Reference the `group2to3_step_examples` submodule for example step implementations.
- Export the migrated configuration with `drush cex` once the update completes.
- Uninstall and remove the module after a successful, verified upgrade.
- Take a database backup before running the update (recommended workflow).