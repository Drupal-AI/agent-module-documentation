# Migrate Conditions — manual setup guide

**Migrate Conditions** (`migrate_conditions`) brings declarative conditional logic to
the Drupal [Migrate](https://www.drupal.org/docs/drupal-apis/migrate-api) API. Out of
the box, migration YAML can do a lot, but expressing "skip this row if the date is too
old", "use this field if the animal is a bird, otherwise that one", or "keep only the
array elements that match a pattern" often means reaching for custom code. This module
gives you a reusable framework of **condition** plugins plus a family of **process**
plugins that act on them, so that branching, skipping, filtering, and switching can all
be written directly in your migration definitions.

The idea is a clean split. A **condition** is a small reusable test that returns true or
false — `empty`, `equals`, `greater_than`, `contains`, `matches` (regex), `in_array`,
`older_than`, `entity_exists`, `in_migrate_map`, `is_stub`, the logical groupers `and`
and `or`, array helpers like `all_elements` and `has_element`, and a `callback` that
runs any PHP callable. The **process** plugins then consume a condition and do something
with the result: `evaluate_condition` returns the boolean, `skip_on_condition` skips a
row or a property (optionally logging a message), `stop_on_condition` halts a pipeline
early, `if_condition` branches between two values or sub‑pipelines,
`first_meeting_condition` returns the first value that matches (a tidy `null_coalesce`),
`filter_on_condition` filters an array, and `switch_on_condition` implements ordered
case matching.

A few ergonomic shorthands keep the YAML terse: a `not:` prefix negates any condition, a
parentheses form lets you write `equals(bird)` instead of a full map, and a per‑condition
`source` key lets a condition test a different row property than the process plugin's own
value. Every process plugin also gets an automatic `:foreach` variant that applies the
condition element‑by‑element over an array.

This is a developer‑facing module: it defines a new plugin type
(`migrate_conditions_condition`) and process plugins, and you use it entirely from
migration YAML. There is **no admin UI, configuration form, permission, or Drush command**.
It depends on core's **Migrate** module.

This guide is written for a **human** writing migrations by hand. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

Nowhere — there's no admin page. Everything happens inside your migration definition
files (the `process:` section of a migration YAML), or programmatically in custom
migration code.

## How to use it

Enable the module (see [Installation](installation/index.md)), then reference its
process plugins in a migration's `process` pipeline, giving each a `condition`. A
condition is either a plugin id string (for tests that need no extra config) or a map
with a `plugin` key plus its configuration.

Skip a row when a source date is older than a month, and log why:

```yaml
skip_old:
  plugin: skip_on_condition
  source: created_on
  method: row
  condition: { plugin: older_than, format: 'j M Y', value: '-1 month' }
  message: 'Created %s, too old.'
  message_context: [created_on]
```

Branch a value depending on another field:

```yaml
animal_color:
  plugin: if_condition
  source: animal_family
  condition: equals(bird)
  do_get: feather_color
  else_get: fur_color
```

Return the first non‑null of several source fields (a `null_coalesce`):

```yaml
null_coalesce:
  plugin: first_meeting_condition
  condition: 'not:is_null'
  source: [field_one, field_two, field_three]
  default_value: 'fallback'
```

Map values with an ordered switch, using `default` as the catch‑all:

```yaml
comparison:
  plugin: switch_on_condition
  source: my_source
  cases:
    - { condition: { plugin: less_than, value: 5 }, default_value: 'less than 5' }
    - { condition: equals(5), default_value: 'equal to 5' }
    - { condition: default, default_value: 'greater than 5' }
```

Combine conditions with `and` / `or` for compound tests (here, `13 <= age < 20`):

```yaml
condition:
  plugin: and
  conditions:
    - { plugin: less_than, negate: true, value: 13 }
    - { plugin: less_than, value: 20 }
```

To add your own test, write a condition plugin in
`src/Plugin/migrate_conditions/condition/` of a custom module, annotate it with
`@MigrateConditionsConditionPlugin`, and implement `doEvaluate()` (extend
`ConditionBase`, or `SimpleComparisonBase` for a plain value/property comparison). It
then becomes available to every process plugin above.
