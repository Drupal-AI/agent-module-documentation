# Self Entity Reference — manual setup guide

**Self Entity Reference** (`self_entity_reference`) is a small developer‑oriented
module that adds a read‑only, computed base field to your entities — a field that
references each entity back to *itself*. It sounds odd at first, but it's a neat
trick: any tool in Drupal that expects an entity‑reference field (Views
relationships, tokens, reference‑field formatters) can now be pointed at "this
entity" without you having to store a real, redundant reference value.

The classic use is display flexibility. Because the self‑reference is a proper
entity‑reference field, you can render an entity *through* it using a different
view mode than the one you're currently in — for example showing a "Hero" or
header view mode inside the full content view mode, or rendering a leaner view
mode into the search index while the full page uses Layout Builder. It's also
handy for building Views relationships that loop back to the same entity to expose
extra fields.

The field is provided automatically once the module is enabled — there is no
configuration UI, no routes, and no permissions, so it adds essentially no
security surface. It requires PHP 8.0+ and runs on Drupal 9.4, 10, and 11. This
project *is* covered by Drupal's security advisory policy.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

There is nothing to configure. After you enable the module, the computed
self‑reference field is available on your entity types automatically. You then
consume it like any other entity‑reference field — for instance:

- In **Views**, add a relationship on the self‑reference field to bring the same
  entity back into the query and expose additional fields.
- On **Manage display**, use an entity‑reference field formatter on the
  self‑reference to render the entity through a different view mode (a header/hero
  view mode nested inside the full view mode, say).
- In **tokens** or other derived data, reference the entity via the field where a
  reference is expected.

Because the field is read‑only and computed, there is no stored value to maintain
and nothing extra to save on the entity.
