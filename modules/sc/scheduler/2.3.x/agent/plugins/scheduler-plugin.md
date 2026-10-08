# Add scheduling support for a new entity type — SchedulerPlugin

Scheduler defines its own plugin type, managed by `plugin.manager.scheduler`
(`\Drupal\scheduler\SchedulerPluginManager`, extends `DefaultPluginManager`). One plugin declares
support for one entity type; core ships `NodeScheduler`, `MediaScheduler`,
`TaxonomyTermScheduler` and `CommerceProductScheduler`.

- Plugin namespace: `Plugin/Scheduler`
- Annotation: `@SchedulerPlugin` (`Drupal\scheduler\Annotation\SchedulerPlugin`)
- Interface: `Drupal\scheduler\SchedulerPluginInterface`
- Base class: `Drupal\scheduler\SchedulerPluginBase`
- Alter hook: `hook_scheduler_info_alter()`

The manager filters out any plugin whose `dependency` module is not installed or whose
`entityType` is not defined, so a plugin for an optional entity type is simply ignored until that
module is present.

## Example (Node plugin, from source)
```php
namespace Drupal\mymodule\Plugin\Scheduler;

use Drupal\Core\Plugin\ContainerFactoryPluginInterface;
use Drupal\scheduler\SchedulerPluginBase;

/**
 * @SchedulerPlugin(
 *  id = "node_scheduler",
 *  label = @Translation("Node Scheduler Plugin"),
 *  description = @Translation("Provides support for scheduling node entities"),
 *  entityType = "node",
 *  dependency = "node",
 *  develGenerateForm = "devel_generate_form_content",
 *  collectionRoute = "system.admin_content",
 *  userViewRoute = "view.scheduler_scheduled_content.user_page",
 * )
 */
class NodeScheduler extends SchedulerPluginBase implements ContainerFactoryPluginInterface {}
```

## Annotation properties
Required: `id` (convention `{entity_type}_scheduler`), `label`, `entityType`, `dependency`
(module that provides the entity type). Optional: `description`, `typeFieldName` (only if the
entity type has no `bundle` key), `develGenerateForm`, `collectionRoute`, `userViewRoute`,
`schedulerEventClass` (defaults to `\Drupal\scheduler\Event\Scheduler{Type}Events`),
`publishAction` / `unpublishAction` (default `{type}_publish_action` / `{type}_unpublish_action`).

After adding a plugin, run `drush scheduler:entity-update` (or `drush cr`) so the `publish_on` /
`unpublish_on` base fields are added to the new entity type.
