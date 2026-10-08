# Plugin type: message_ui_views_contextual_links

Message UI defines one plugin type, used to attach operation links to Message rows shown in
Views (via the Views field/handler `Drupal\message_ui\Plugin\views\field\MessageUIContextualLinks`).

- **Manager service:** `plugin.manager.message_ui_views_contextual_links` →
  `Drupal\message_ui\MessageUiViewsContextualLinksManager`
- **Discovery dir:** `Plugin/MessageUiViewsContextualLinks`
- **Interface:** `Drupal\message_ui\MessageUiViewsContextualLinksInterface`
  (base `MessageUiViewsContextualLinksBase`)
- **Annotation:** `@MessageUiViewsContextualLinks` (`id`, `label`; plugins also read a `weight`)
- **Alter hook:** `hook_message_ui_message_ui_views_contextual_links_info_alter()`
- **Cache key:** `message_ui_message_ui_views_contextual_links_plugins`

## Built-in plugins

| id | Class | Link |
|---|---|---|
| `view` | `MessageUiContextualLinkViewMessage` | View → `entity.message.canonical` |
| `edit` | `MessageUiContextualLinkEditMessage` | Edit → `entity.message.edit_form` |
| `delete` | `MessageUiContextualLinkDeleteMessage` | Delete → `entity.message.delete_form` |

(The `message_notify_ui` submodule adds a `notify` plugin.)

## Implement one

```php
namespace Drupal\my_module\Plugin\MessageUiViewsContextualLinks;

use Drupal\message_ui\MessageUiViewsContextualLinksBase;
use Drupal\message_ui\MessageUiViewsContextualLinksInterface;

/**
 * @MessageUiViewsContextualLinks(
 *   id = "my_op",
 *   label = @Translation("My operation"),
 *   weight = 5
 * )
 */
final class MyOp extends MessageUiViewsContextualLinksBase implements MessageUiViewsContextualLinksInterface {
  public function access() {
    // The base class exposes $this->message (the Message entity for the row).
    return $this->message->access('update');
  }
  public function getRouterInfo() {
    return ['title' => $this->t('Do it'), 'url' => \Drupal\Core\Url::fromRoute('my_module.route', ['message' => $this->message->id()])];
  }
}
```

Each plugin implements `access()` (return bool/AccessResult for the current `$this->message`)
and `getRouterInfo()` (return `['title' => ..., 'url' => Url]`). The Views field renders the
allowed plugins, ordered by `weight`, as operation links on each message row.
