# SchedulerFieldType plugins + the cron/queue flow

The plugin type lets you define what happens when a scheduler field's start/end dates are reached.

## Plugin type wiring

- Manager: `plugin.manager.scheduler_field_type` → `SchedulerFieldTypeManager` (extends
  `DefaultPluginManager`), discovers `Plugin/SchedulerField/Type/`, annotation `@SchedulerFieldType`,
  interface `SchedulerFieldTypePluginInterface`, base `SchedulerFieldTypePluginBase`. Alter hook
  `hook_scheduler_field_type_info_alter`.
- Annotation properties (`src/Annotation/SchedulerFieldType.php`): `id`, `name` (translated label),
  `process_during_cron` (bool, default `TRUE`).
- `scheduler_field.plugin_type.yml` also registers the type with the contrib **`plugin`** module
  (optional; provides the Plugin API UI via `ArrayPluginDefinitionDecorator`).

## Shipped plugins (`src/Plugin/SchedulerField/Type/`)

| id | Behavior |
|---|---|
| `scheduler_field_type_disabled` | No scheduling. `process_during_cron = FALSE`; empty `processSchedulerQuery()`. The default. |
| `scheduler_field_type_publication` | Publishes the entity when `start_date < now` (and no/future end date); unpublishes when `end_date < now`. Uses the entity's `published` key (falls back to `status`). Only available for entity types with a published key (`isAvailableForEntityType`) / `EntityPublishedInterface` (`isAvailableForEntity`). |

## Execution flow (all in `src/`)

1. `hook_cron` → `scheduler_field.cron` → `Cron::run()`.
2. For each plugin definition with `process_during_cron = TRUE`, `Cron` calls
   `plugin->processScheduler()`.
3. `processScheduler()` (in `SchedulerFieldTypePluginBase`) loads all `field_storage_config` of type
   `scheduler_field`, and for each (whose entity type passes `isAvailableForEntityType()`) builds a raw
   `\Drupal::database()->select()` joining base/data/field tables, filtered to rows where
   `{field}_scheduler_type = <plugin id>`, then lets the plugin add its own conditions via
   `processSchedulerQuery($query, $entity_storage, $field_storage)`. Returns `['<type>:<id>' => <id>]`.
4. `Cron` chunks the collected IDs (100 per item) into the `scheduler_field_process` queue.
5. Queue worker `SchedulerFieldProcess` (cron time 30s) loads each entity and, for every
   `scheduler_field` on it, calls `plugin->process($entity, $field_item)`.

So: **`processSchedulerQuery()` selects candidate entities cheaply in SQL; `process()` performs the
action per entity/field item.** You must run cron regularly (e.g. `drush cron`) for schedules to fire.

## Write your own plugin

```php
namespace Drupal\my_module\Plugin\SchedulerField\Type;

use Drupal\Core\Database\Query\SelectInterface;
use Drupal\Core\Entity\ContentEntityInterface;
use Drupal\Core\Entity\EntityStorageInterface;
use Drupal\Core\Field\FieldItemInterface;
use Drupal\field\FieldStorageConfigInterface;
use Drupal\scheduler_field\SchedulerFieldTypePluginBase;

/**
 * @SchedulerFieldType(
 *   id = "my_module_send_email",
 *   name = @Translation("Send email"),
 * )
 */
class SendEmail extends SchedulerFieldTypePluginBase {

  // Narrow the SQL to entities that are due (mirror the Publication plugin).
  public function processSchedulerQuery(SelectInterface $query, EntityStorageInterface $entity_storage, FieldStorageConfigInterface $field_storage): void {
    $field = $field_storage->getName();
    $table = $this->getFieldTableName($entity_storage->getEntityTypeId(), $field);
    $now = (new \Drupal\Core\Datetime\DrupalDateTime('now', 'UTC'))->format('Y-m-d\TH:i:s');
    $query->condition("$table.{$field}_value", $now, '<');
  }

  // Do the work for one due entity/field item.
  public function process(ContentEntityInterface $entity, FieldItemInterface $field_item) {
    // ... send the mail, then optionally flip a flag so it isn't re-sent.
  }

  // Optional: restrict availability.
  // public static function isAvailableForEntityType(string $entityTypeId): bool { ... }
}
```

Base class provides `entityTypeManager`, `database`, `getFieldTableName()`, and default
`isAvailableForEntity/Type` returning `TRUE`. `getName()` reads the annotation `name`.
Set `process_during_cron = FALSE` in the annotation for a plugin that only records intent (like
`disabled`) and should never be picked up by cron.
