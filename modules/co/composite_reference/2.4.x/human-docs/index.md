# Composite Reference — manual setup guide

**Composite Reference** (`composite_reference`) lets you mark an entity‑reference
(or entity‑reference‑revisions) field as **composite**, so the entities it points
to are automatically deleted when the referencing "host" entity is deleted. This
gives you parent‑child ownership semantics — for example, a node that "owns" its
Paragraphs, or a container entity that owns its child pieces — without writing any
custom deletion code.

You switch a field into composite mode with a checkbox on the field's settings
form; the choice is stored as a third‑party setting on the field, so it exports and
deploys with your configuration. For revision‑capable reference fields there is a
second option, **Include past revisions**, which also cleans up entities that were
only ever referenced in older revisions. Base fields (defined in code) can opt in
too, and their setting is preserved even through a per‑bundle base‑field override.

Deletion is careful, not blunt. When a host entity is deleted, the module collects
the entities its composite fields reference and deletes each one **unless it is
still referenced somewhere else** — it checks every reference and
reference‑revision field across the site, across all revisions, before removing
anything. This protects shared entities from being deleted out from under other
content, so composite references are best used for entities that are referenced by
a single parent.

There is no admin page, no permissions, and no Drush commands — it is pure field
configuration plus the automatic deletion behavior. It works with both configurable
(bundle) fields and base fields, and understands revision tables when the
"include past revisions" option is on.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

There is no central settings page. You mark a field composite on that field's own
**settings form**, reached from **Structure → Content types → [type] → Manage
fields → [field] → Edit** (or the equivalent Manage fields screen for any other
entity type).

## How to use it

**On a configurable (bundle) field, via the UI:** edit any entity‑reference or
entity‑reference‑revisions field and open its settings form. The module adds a
**Composite reference** section with:

- **Composite field** — tick this to enable cascade deletion of the entities this
  field references when the host entity is deleted.
- **Include past revisions** — shown only for *entity reference revisions* fields,
  and only when *Composite field* is ticked. When on, entities that were referenced
  only in older revisions are cleaned up too.

Save the field. From then on, deleting a host entity deletes its owned referenced
entities (unless they are still referenced elsewhere).

**On a base field, in code:** add a `composite_reference` setting to the field
definition:

```php
$fields['my_ref'] = BaseFieldDefinition::create('entity_reference')
  ->setSettings([
    'target_type' => 'node',
    'composite_reference' => TRUE,
    // or: 'composite_reference' => ['composite' => TRUE, 'composite_revisions' => TRUE],
  ]);
```

If that base field is later overridden per bundle, the module copies the composite
settings into the override so the exported configuration keeps working.

**A note on shared entities:** because the module skips any referenced entity that
is still referenced elsewhere, composite deletion is intended for entities owned by
a single parent (such as Paragraphs). An entity referenced by more than one host is
left in place.
