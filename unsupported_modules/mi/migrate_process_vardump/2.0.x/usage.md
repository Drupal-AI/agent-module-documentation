<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Migrate Process Vardump provides a var_dump process plugin for migration debugging and development.

---

Migrate Process Vardump provides a Migrate process plugin that var_dumps the value passing through it —
a debugging aid for developing migrations, letting you inspect what a value looks like at a given point in
the process pipeline. It is in the Migration package.

Use it during migration development to debug value transformations. It is a developer/migration-debugging
tool used in the Migrate pipeline (dev context); it outputs debug information and has no runtime or access
role. Remove it from migration definitions before production use (debug output shouldn't run in real
migrations). Add the plugin to a migration process step temporarily to inspect values.

---

- var_dump values in a migration.
- Debug migration transformations.
- Inspect pipeline values.
- Provide a debug process plugin.
- Use during migration development.
- Debug value at a process step.
- Have no runtime or access role.
- Remove before production.
- Inspect migration data.
- Add temporarily for debugging.
- Output debug info.
- Develop migrations.
- Debug the process pipeline.
- See value transformations.
- Aid migration debugging.
- Use in dev context.
- Inspect migrate values.
- Debug migrate plugins.
- Temporarily dump values.
- Support migration dev.
