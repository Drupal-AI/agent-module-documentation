<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Migrate process plugin

Namespace: `Drupal\migrate_process_vardump\Plugin\migrate\process`. Use in a migration's `process:`
section. No config schema — the one config key is read directly from the process definition.

## vardump
Dumps the incoming value with PHP `var_dump()` and returns it unchanged, so it acts as a passthrough
debugging step anywhere in a pipeline. Output is written to stdout, so run the migration from the CLI
(e.g. `drush migrate:import`) to see it.

Config keys:
- `header` (optional): a label string printed as `header: ` immediately before the dump, so multiple
  `vardump` steps in the same pipeline can be told apart. Omitted → no label, just the dump.

```yaml
field_my_field:
  -
    plugin: vardump
    source: my_source
    header: 'Before some_plugin'
  -
    plugin: some_plugin
  -
    plugin: vardump
    header: 'After some_plugin'
  -
    plugin: some_other_plugin
```
The value dumped by each `vardump` step is passed through unmodified to the next step, so inserting or
removing a `vardump` never changes the migrated result.
