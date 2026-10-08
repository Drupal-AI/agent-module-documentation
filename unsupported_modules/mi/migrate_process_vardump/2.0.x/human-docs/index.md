# Migrate Process Vardump — manual setup guide

**Migrate Process Vardump** (`migrate_process_vardump`) is a small but handy
Migrate *process plugin* for **debugging migrations**. Drop it anywhere in a
process pipeline and it `var_dump()`s the value flowing through it to the
terminal, then passes that value along unchanged. It is a passthrough — it never
modifies the field value — so you can insert it (and remove it) freely while you
work out why a transformation isn't doing what you expect.

Writing a migration is largely a matter of reasoning about what each process
plugin does to a value, and it is easy to lose track of the shape of the data
mid‑pipeline. This plugin lets you *see* the value at any step: put one before a
plugin and one after, and you can watch exactly how that plugin changed things.

This is strictly a **development‑time tool**. Because it prints debug output, you
should remove it from your migration definitions before running real migrations
in production. The module is self‑contained — it has no module dependencies, no
admin pages, and no permissions — and you use it entirely from your migration
YAML.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module — it has no settings form.
You use it from your migration definitions, as described below.

## How to use it

Use it like any other process plugin — insert `vardump` at the point in the
pipeline you want to inspect:

```yaml
field_my_field:
  - plugin: some_plugin
    source: my_source
  - plugin: vardump
  - plugin: some_other_plugin
```

When several dumps get confusing, add a `header` so you can tell them apart in
the output:

```yaml
field_my_field:
  - plugin: vardump
    source: my_source
    header: 'Before some_plugin'
  - plugin: some_plugin
  - plugin: vardump
    header: 'After some_plugin'
  - plugin: some_other_plugin
```

Run the migration with `drush migrate:import` and the dumped values (with your
headers) appear in the terminal output. Remember to delete the `vardump` steps
once you have finished debugging.
