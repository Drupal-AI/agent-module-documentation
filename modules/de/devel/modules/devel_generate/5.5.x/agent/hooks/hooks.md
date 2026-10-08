# Devel Generate hooks

- `hook_devel_generate_alter(&$results)` (invoked from `devel_generate.module`) — alter the
  parameters/results of a generation run before entities are created, e.g. inject custom field
  values or adjust counts.

To add an entirely new generator, implement a `DevelGenerate` plugin instead — see
[../plugins/devel-generate.md](../plugins/devel-generate.md).
