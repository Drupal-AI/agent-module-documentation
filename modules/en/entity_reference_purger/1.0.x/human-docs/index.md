# Entity Reference Purger — manual setup guide

**Entity Reference Purger** (`entity_reference_purger`) keeps your entity
reference fields honest. When you delete an entity that other entities point at,
those references become "orphaned" — the field still holds a value, but it points
at content that no longer exists. This module automatically removes those dangling
values from the parent entities, so reference fields never keep pointing at
deleted content.

There is no admin settings page. You switch it on **per entity reference field**.
On a field's settings form you'll find an "Entity Reference Purger" section with
two checkboxes: **Remove orphaned entity references** turns the cleanup on, and
**Use queue** (which only appears once the first box is ticked) chooses *when* the
cleanup happens. With the queue off, the orphaned value is removed immediately as
part of the deletion. With the queue on, the work is deferred to a background job
that runs on the next cron — the better choice when deleting one entity could
orphan a large number of references.

Under the hood, whenever any entity is deleted the module scans every non-computed
entity reference field whose target type matches the deleted entity, finds the
parents that referenced it, and removes the matching field item(s). If the parent
is revisionable, it creates a new revision with a descriptive log message. This
lets you maintain referential integrity across your content model without writing
custom `hook_entity_delete()` code.

The module works with references to any entity type — nodes, taxonomy terms,
users, media, Paragraphs, or custom entities — and its per-field settings export
with your field configuration so they travel across environments.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Entity Reference Purger has **no page of its own**. You enable it per field on the
field's settings form — for example **Structure → Content types → *(type)* →
Manage fields → *(your reference field)***.

## How to use it

1. Go to the settings form of an entity reference field — for example
   `/admin/structure/types/manage/article/fields/node.article.field_related`.
2. In the **Entity Reference Purger** section, tick **Remove orphaned entity
   references**.
3. Decide on **Use queue**:
   - Leave it **off** to remove orphaned values immediately when a referenced
     entity is deleted. Good for low-volume fields.
   - Turn it **on** to defer cleanup to cron via the module's queue worker.
     Recommended when a single deletion could orphan many references.
4. Save the field settings.

Enable purging only on the fields where dangling references actually matter — you
can freely mix immediate purging on some fields with queued purging on others, and
turn it off again by unticking the box.

## For developers

To enable purging on a **base** entity reference field (defined in code), set it
on the field definition:

```php
$fields['my_ref'] = BaseFieldDefinition::create('entity_reference')
  ->setSetting('target_type', 'node')
  ->setSetting('entity_reference_purger', [
    'remove_orphaned' => TRUE,
    'use_queue' => FALSE,
  ]);
```

For a config field you can set the same values as third-party settings via
`FieldConfig::setThirdPartySetting()`. See the [`agent/`](../agent/start.md) docs
for the full delete-hook flow and the queue worker details.
