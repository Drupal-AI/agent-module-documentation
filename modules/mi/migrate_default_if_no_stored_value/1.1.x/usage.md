<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Migrate Default If No Stored Value provides a migration process plugin.

---

Migrate Default If No Stored Value provides a **Migrate process plugin that applies a default only when no
value was previously stored** — useful for re-runnable migrations where you want to set a default on first
import but not overwrite an existing (possibly edited) value on subsequent runs. It depends on core Migrate, in
the Migrate package.

Use it in migrations to preserve edited values. It is a developer/migration plugin run by privileged users; it
processes migration data with migration privileges and has no access-control role. Use it in a migration
process.

---

- Apply a default only if none stored.
- Preserve existing values on re-run.
- Support idempotent migrations.
- Depend on core Migrate.
- Serve migration.
- Avoid overwriting edited values.
- Process data with migration privileges.
- Have no access-control role.
- Use it in a process pipeline.
- Handle the process plugin.
- Set conditional defaults.
- Configure the plugin.
- Preserve values.
- Handle the migration.
- Default values.
- Configure migrations.
- Handle processing.
- Apply defaults.
- Use the plugin.
- Provide a conditional-default plugin.
