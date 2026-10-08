# Migrate Child Entity Generate — manual setup guide

**Migrate Child Entity Generate** (`migrate_child_entity_generate`) provides a
single Migrate **process plugin**, `child_entity_generate`, for creating entities
that only make sense in the context of a parent — the classic example being
**paragraphs** (or field collections) attached to a node.

The problem it solves is a gap in the widely‑used `entity_generate` plugin from
Migrate Plus: that plugin can't take an **array of values** and build an entity's
fields from that array. Migrate Child Entity Generate can. Because these child
entities exist only inside their parent, there's no need to look them up for
prior existence — you just generate a fresh one each run and map its fields from
your source data. That makes it a natural fit for importing repeating structures
like FAQ items, slides, or any multi‑value paragraph field.

There is **no settings form** — the module is consumed entirely from migration
configuration (YAML). It depends only on core's **Migrate** module and runs on
**Drupal 8, 9, 10, and 11**. (Note: the project is marked *seeking a new
maintainer*.)

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module — you use the process plugin
from your migration YAML, as shown below.

## How to use it

Use `child_entity_generate` as the process plugin for the field that holds the
child entities. Map each child field from a key in your source array with
`values:`, and supply any fixed values with `default_values:`:

```yaml
process:
  field_faqs:
    plugin: child_entity_generate
    source: faq_items
    entity_type: field_collection
    bundle: faq
    values:
      field_faq_question: question
      field_faq_answer/value: answer
    default_values:
      field_faq_answer/format: basic_html
```

If you'd rather store each whole source value in a single destination property
instead of mapping sub‑fields, name that property with the `destination:` key:

```yaml
process:
  field_faqs:
    plugin: child_entity_generate
    source: questions
    entity_type: field_collection
    bundle: question
    destination: field_question
```

And when the values need pre‑processing (for example a `migration_lookup` on each
item), run them through `sub_process` first, then hand the result to
`child_entity_generate`:

```yaml
process:
  field_faqs:
    -
      plugin: sub_process
      source: faq_items
      process:
        entity:
          plugin: migration_lookup
          migration: faqs
          source: id
        isHighlighted: isHighlighted
    -
      plugin: child_entity_generate
      entity_type: field_collection
      bundle: faq
      values:
        field_faq_entity: entity
        field_faq_is_highlighted: isHighlighted
```
