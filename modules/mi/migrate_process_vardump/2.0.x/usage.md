<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Migrate Process Vardump provides a single Migrate process plugin (`vardump`) that dumps a pipeline value to the terminal for migration debugging and passes it through unchanged.

---

Migrate Process Vardump adds one Migrate **process plugin**, id `vardump`, for debugging migrations. Placed anywhere in a migration's `process:` pipeline, it runs PHP `var_dump()` on the incoming value so a developer can inspect exactly what a source field or an upstream process step produced, then returns that same value untouched so the pipeline continues as if the plugin were not there. An optional `header` config key prints a label before the dump so multiple `vardump` steps can be told apart. It is in the Migration package, requires no configuration UI, declares no dependencies (it uses core `migrate` classes), and provides no permissions, services, or config schema.

Use it while writing or troubleshooting a migration, running the migration from the command line (for example `drush migrate:import`) so the dumped output is visible in the terminal. Insert a `vardump` step before and after another process plugin to see how that plugin transforms the value, or drop one in to confirm what a source query returns. It is a developer-only debugging aid with no runtime, content, or access role, and is meant to be removed once the migration is working — it does not modify the value it dumps.

---

- Dump any pipeline value to the terminal while running a migration (`vardump`).
- Inspect what a source field actually contains during import.
- See the exact PHP type and structure of a value (`var_dump` output).
- Verify what an upstream process plugin produced.
- Place a dump before and after another plugin to compare its input and output.
- Label each dump with a `header` so multiple steps are distinguishable.
- Debug a migration process pipeline without writing a custom plugin.
- Confirm whether a value is a string, array, NULL, or object.
- Check multi-value / array source data before it lands in a field.
- Trace how chained process steps transform a value step by step.
- Pass the value through unchanged so the migration still runs.
- Add a temporary inspection point in a migration YAML.
- Troubleshoot a field that imports empty or with the wrong value.
- Watch the output of a `drush migrate:import` run for a specific field.
- Diagnose why a migration mapping is not producing expected results.
- Dump the source value at the very start of a field's pipeline.
- Dump the final value just before it reaches the destination.
- Inspect values inside a migration during development, then remove the step.
- Understand an unfamiliar source's data shape quickly.
- Debug a migration authored by someone else.
