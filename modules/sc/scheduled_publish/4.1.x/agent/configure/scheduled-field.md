<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Add and use a Scheduled Publish field

Scheduled Publish has no global settings page. You configure it by adding a
**`scheduled_publish`** field to a bundle that is under **Content Moderation**.

## Prerequisites

- The entity type + bundle must be enabled in a **Content Moderation** workflow (so target
  moderation states exist). `content_moderation`, `workflows`, `datetime` are dependencies.

## Add the field (UI)

1. *Manage fields* for the bundle (e.g. `/admin/structure/types/manage/article/fields`).
2. *Add field* → choose **Scheduled publish**. Give it a label; set **Allowed number of
   values** to *Unlimited* if editors should queue several transitions.
3. Save. On *Manage form display* the **Scheduled publish** widget is used by default; on
   *Manage display* the **Generic formatter** (`scheduled_publish_generic_formatter`) renders it.

## Field type / storage

- Field type id **`scheduled_publish`** (class `ScheduledPublish`, implements
  `DateTimeItemInterface`).
- Item properties/columns: **`value`** (`datetime_iso8601`, the when) and
  **`moderation_state`** (varchar 32, the target state); plus a computed `date`.
- `isEmpty()` is true unless *both* value and moderation_state are set.
- Config schema `field.storage_settings.scheduled_publish` (a `datetime_type`) and
  `field.formatter.settings.scheduled_publish_generic_formatter` (`date_format`, `text_pattern`).

## Create the field programmatically

```php
use Drupal\field\Entity\FieldStorageConfig;
use Drupal\field\Entity\FieldConfig;

FieldStorageConfig::create([
  'field_name' => 'field_scheduled',
  'entity_type' => 'node',
  'type' => 'scheduled_publish',
  'cardinality' => -1,            // unlimited: allow multiple queued transitions
])->save();

FieldConfig::create([
  'field_name' => 'field_scheduled',
  'entity_type' => 'node',
  'bundle' => 'article',
  'label' => 'Scheduled moderation',
])->save();
```

Read back: `drush cget field.storage.node.field_scheduled type` → `scheduled_publish`.

## How transitions fire

On the entity edit form an editor adds one or more **date + target moderation state** entries.
The cron service (`scheduled_publish.update`, `ScheduledPublishCron::doUpdate()`) runs on every
Drupal cron: for each entity whose scheduled datetime is due, it applies the matching
moderation-state transition, saving a new revision. Run it on demand with
`drush scheduled_publish:doUpdate` (alias `schp`) — see drush/commands.md.

## Admin listing & permissions

- Pending scheduled changes: **`/admin/content/scheduled-publish`**
  (`scheduled_publish.listing_page`) with **add** (`/admin/content/scheduled-publish/add`),
  **edit**, **delete** forms.
- Permission **`access scheduled publish pages`** gates the add/edit/delete forms; the listing
  controller additionally requires `view any unpublished content`.
