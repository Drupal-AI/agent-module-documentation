# Notification plugin type (add a delivery method)

The module defines its own plugin type so alerts can be delivered by mechanisms other than email
(SMS, push, a message-queue, etc.). The built-in plugin is `email`.

## Definition

`search_api_saved_searches.plugin_type.yml`:

```yaml
search_api_saved_searches_notification:
  label: Saved search notification method
  plugin_manager_service_id: plugin.manager.search_api_saved_searches.notification
  plugin_definition_decorator_class: \Drupal\plugin\PluginDefinition\ArrayPluginDefinitionDecorator
```

| Aspect | Value |
|---|---|
| Manager service | `plugin.manager.search_api_saved_searches.notification` (`NotificationPluginManager`) |
| Discovery directory | `Plugin/search_api_saved_searches/notification` |
| Attribute | `Drupal\search_api_saved_searches\Attribute\SearchApiSavedSearchesNotification` |
| Annotation (legacy) | `Drupal\search_api_saved_searches\Annotation\SearchApiSavedSearchesNotification` |
| Interface | `NotificationPluginInterface` (extends Search API `ConfigurablePluginInterface`) |
| Base class | `NotificationPluginBase` (extends `ConfigurablePluginBase`) |
| Alter hook | `hook_search_api_saved_searches_notification_info_alter()` |
| Cache key | `search_api_saved_searches_notification` |

Attribute parameters: `id` (required), `label`, `description`, `deriver`, `no_ui`.

## Interface contract

`NotificationPluginInterface` methods a plugin must satisfy (defaults in `NotificationPluginBase`):

| Method | Purpose |
|---|---|
| `notify(SavedSearchInterface $search, ResultSetInterface $results): void` | Deliver new results to the search's owner. **Required** (no default). |
| `getFieldDefinitions(): array` | Extra `BundleFieldDefinition`s added to every bundle using this plugin (default `[]`). |
| `getDefaultFieldFormDisplay(): array` | Default form-display settings for those fields (default `[]`). |
| `checkFieldAccess($op, $field_definition, $account, $items): AccessResultInterface` | Access to plugin-defined fields (default: allowed). |
| `getSavedSearchType()` / `setSavedSearchType()` | The type the plugin instance is attached to. |

Config forms: extend `NotificationPluginBase` and implement `PluginFormInterface`
(`buildConfigurationForm` / `validate` / `submit`) — see the `Email` plugin. The type form embeds
each selected plugin's config subform; the type entity stores it under
`notification_settings.<plugin_id>`.

## Minimal skeleton

```php
namespace Drupal\my_module\Plugin\search_api_saved_searches\notification;

use Drupal\Core\StringTranslation\TranslatableMarkup;
use Drupal\search_api\Query\ResultSetInterface;
use Drupal\search_api_saved_searches\Attribute\SearchApiSavedSearchesNotification;
use Drupal\search_api_saved_searches\Notification\NotificationPluginBase;
use Drupal\search_api_saved_searches\SavedSearchInterface;

#[SearchApiSavedSearchesNotification(
  id: 'sms',
  label: new TranslatableMarkup('SMS'),
  description: new TranslatableMarkup('Sends new results by text message.'),
)]
class Sms extends NotificationPluginBase {

  public function notify(SavedSearchInterface $search, ResultSetInterface $results): void {
    // $results holds only the NEW items (already diffed by NewResultsCheck).
    // $search->getOwner(), $search->get('mail'), custom fields you defined, etc.
  }
}
```

## Instantiating plugins programmatically

```php
$manager = \Drupal::service('plugin.manager.search_api_saved_searches.notification');
$plugin  = $manager->createPlugin($type, 'email', $config);      // one plugin bound to a type
$plugins = $manager->createPlugins($type, ['email'], []);        // several, config from the type
```

`createPlugin()` injects the owning type as `$configuration['#saved_search_type']` and throws
`SavedSearchesException` for an unknown id. `SavedSearchType::getNotificationPlugins()` /
`getNotificationPlugin($id)` / `isValidNotificationPlugin($id)` read them back.

### Fields added by a plugin

`getFieldDefinitions()` returns `BundleFieldDefinition`s that are attached to `search_api_saved_search`
for every bundle using the plugin (via `hook_entity_field_storage_info()` +
`SavedSearchType::adaptFieldStorageDefinitions()`). The `email` plugin adds the required `mail`
field. If a plugin's field set changes, ship an update hook that calls the field-storage-definition
listener CRUD methods.
