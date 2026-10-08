# UI Patterns Extends — manual setup guide

**UI Patterns Extends** (`ui_patterns_extends`) adds an `extends:` key to
[UI Patterns](https://www.drupal.org/project/ui_patterns) pattern definitions so one
pattern can **inherit** the fields, settings, and variants of another. If you build a
family of similar components — several card or teaser patterns that share the same
fields — this lets you define a base pattern once and derive the others from it,
instead of copy‑pasting the same YAML into each one.

This is a developer/theming tool with no user interface. You add an `extends` entry
to a pattern's `*.ui_patterns.yml` file, and at build time the module merges in the
referenced parent's parts. The rule of thumb is simple: **the child always wins** — a
field or setting is only copied from the parent if the child doesn't already define
it, so you can inherit most of a base and override just the one piece you want to
change.

Inheritance is recursive (a parent that itself extends another is flattened first)
and protected against circular references (a cycle throws an error at build time). It
depends on the `ui_patterns` and `token` modules.

This guide is written for a **human** setting things up. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside UI Patterns and Token.

## How to use it

There's nothing to configure in the admin UI — this module quietly extends the YAML
syntax you already use for patterns. Add an `extends` list to a pattern definition:

```yaml
# A base pattern with shared parts
foo_base:
  label: Foo Base
  fields:
    title: { type: text, label: Title }
  settings:
    modifier: { type: textfield, label: Modifier }
  variants:
    blue: { label: Blue }

# Inherit its fields + settings + variants
foo_complete:
  label: Foo Complete
  extends:
    - foo_base
```

The reference forms you can list under `extends` are:

| `extends` entry | Copies from the parent |
|---|---|
| `parent` | its **fields**, **settings**, and **variants** |
| `parent.fields` | all fields |
| `parent.settings` | all settings |
| `parent.fields.<name>` | just that one field |
| `parent.settings.<name>` | just that one setting |

List several entries to extend from multiple parents. After a definition is merged,
the `extends` key is removed from the child. Because this happens when pattern
definitions are built, **clear caches after editing your YAML** for changes to take
effect. For the full merge and recursion rules, see the sibling
[`agent/configure/extends.md`](../agent/configure/extends.md).
