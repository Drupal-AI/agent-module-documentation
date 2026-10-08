<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Migrate Source Queue allows queue items to be used as a migrate source.

---

Migrate Source Queue provides a **Migrate source plugin backed by a queue** — so items placed on a Drupal
queue become the rows a migration processes, enabling event-driven / incremental migrations (enqueue work,
let Migrate consume it) rather than migrating from a fixed source. It ships a
`migrate_source_queue_cron_example` submodule and depends on core Migrate, in the Migration package.

Use it for queue-fed migrations. It is a developer/migration feature; the queued data is processed with
migration privileges, so ensure only trusted code enqueues items and validate the data as any migration
should. It has no access-control role. Configure a migration to use the queue source.

---

- Use queue items as a migrate source.
- Enable event-driven migrations.
- Consume enqueued work in Migrate.
- Ship a cron example submodule.
- Depend on core Migrate.
- Process incremental migrations.
- Ensure only trusted code enqueues.
- Validate queued data.
- Have no access-control role.
- Configure a migration to use it.
- Handle queue-fed migration.
- Migrate from a queue.
- Process queued rows.
- Configure the source.
- Enqueue migration work.
- Handle the source plugin.
- Migrate incrementally.
- Consume the queue.
- Configure migrations.
- Provide a queue source.
