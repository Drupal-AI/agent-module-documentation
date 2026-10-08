<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Sync UUIDs provides a Drush command to sync UUIDs, aligning entity/config UUIDs between environments.

---

Sync UUIDs provides a Drush command to synchronize UUIDs — aligning the UUIDs of configuration (and
entities) between environments, which is important because Drupal's configuration management matches config
by UUID; mismatched UUIDs (e.g. after content/config was created separately on different environments) cause
config-import conflicts. This command reconciles them. It depends on core Config and is in the Development
package.

Use it to fix UUID mismatches that break config sync/deployment. It is a developer/deployment tool operating
via Drush; because it changes UUIDs, run it deliberately and understand its effect (aligning UUIDs affects
how config/entities are matched on import). It has no runtime access role. Run the sync command as part of a
controlled deployment/repair process.

---

- Sync entity/config UUIDs.
- Align UUIDs across environments.
- Fix config-import UUID conflicts.
- Depend on core Config.
- Provide a Drush command.
- Reconcile mismatched UUIDs.
- Run deliberately.
- Understand the effect on config matching.
- Have no runtime access role.
- Use in deployment/repair.
- Fix config-sync conflicts.
- Align config by UUID.
- Handle UUID mismatches.
- Run via Drush.
- Repair UUIDs.
- Sync UUIDs between environments.
- Support config management.
- Run in a controlled process.
- Reconcile environments.
- Align UUIDs.
