<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Content Entity Sync provides Drush commands to synchronize content entities, helping move content between environments.

---

Content Entity Sync provides Drush commands for synchronizing content entities — a way to move or
replicate content (nodes, terms, etc.) between environments or instances via the CLI, filling the gap
that Drupal's configuration sync leaves (config syncs, content does not). It depends on core Field and
operates through Drush.

Use it in deployment/content-staging workflows where specific content must be carried between
environments reproducibly rather than hand-recreated or copied via a full database. Because it is
Drush-driven, it runs in the already-privileged CLI context. Treat synced content as you would any
imported content, and run syncs deliberately (a content sync can overwrite entities), ideally as part
of a controlled process. It provides Drush commands.

---

- Synchronize content entities via Drush.
- Move content between environments.
- Replicate nodes/terms across instances.
- Fill the gap config sync leaves.
- Depend on core Field.
- Run content syncs from the CLI.
- Support content-staging workflows.
- Carry specific content reproducibly.
- Avoid full-database copies for content.
- Provide Drush sync commands.
- Run in the privileged CLI context.
- Overwrite entities deliberately.
- Treat synced content as imported.
- Deploy content changes.
- Sync content in a controlled process.
- Replicate content deterministically.
- Export and import content entities.
- Move content to staging/prod.
- Automate content replication.
- Handle content the config system won't.
