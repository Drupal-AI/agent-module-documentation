# Make array associative — manual setup guide

**Make array associative** (`make_array_associative`) is a small
[Migrate API](https://www.drupal.org/docs/drupal-apis/migrate-api) process plugin
for developers building migrations. It takes a plain indexed array of flat values
and turns each value into a single-element associative array, using a key you
choose. There is nothing to click — you use it by referencing the plugin inside a
migration YAML file.

Why that matters: core's `sub_process` plugin can only iterate over an array of
*associative* arrays. If your source is a multi-value field that arrives as a flat
list (`["one", "two"]`), you can't pipe it into `sub_process` directly. This
plugin reshapes the list first, so each item becomes `["my_key" => "one"]`, which
`sub_process` can then handle.

It depends on core's **Migrate** module and lives in the Migrate package. It has
no configuration form, no permissions, and no admin UI — it is purely a building
block for migration pipelines.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module — it has no settings form. You
use it entirely from within your migration definitions, as shown in "How to use
it" below.

## Where it lives in the admin menu

Nowhere — the module adds no admin pages. It exposes a single process plugin,
`make_array_associative`, that you reference from a migration's `process`
section.

## How to use it

In a migration YAML file, add the plugin as a step and give it a `key`. Every
value in the source array becomes a one-element associative array keyed by that
name — after which you can chain into `sub_process`:

```yaml
process:
  field_my_field:
    - plugin: make_array_associative
      key: my_temp_key
      source: some_source
    - plugin: sub_process
      process:
        final_key:
          plugin: some_plugin_that_cannot_handle_multiple_values
          source: my_temp_key
```

If `some_source` is `["one", "two"]`, the first step turns it into
`[{"my_temp_key": "one"}, {"my_temp_key": "two"}]`, which `sub_process` can then
iterate over one value at a time.
