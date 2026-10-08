<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Plugin type: `message_purge` (auto-delete methods)

Message defines one plugin type used by its cron auto-purge system.

| Piece | Value |
|---|---|
| Plugin type id (cache/alter key) | `message_purge` |
| Manager service | `plugin.manager.message.purge` (`Drupal\message\MessagePurgePluginManager`) |
| Discovery directory | `src/Plugin/MessagePurge/` |
| Annotation | `@MessagePurge` (`id`, `label`, `description`) |
| Interface / base | `MessagePurgeInterface` / `MessagePurgeBase` |
| Alter hook | `hook_message_purge_alter()` |
| Ships with | `days` (older than N days), `quota` (keep at most N) |

## Implement one

`src/Plugin/MessagePurge/Weekend.php` in a module:

```php
namespace Drupal\my_module\Plugin\MessagePurge;

use Drupal\Core\Entity\Query\QueryInterface;
use Drupal\message\MessagePurgeBase;

/**
 * @MessagePurge(
 *   id = "weekend",
 *   label = @Translation("Weekend", context = "MessagePurge"),
 *   description = @Translation("Delete messages created on weekends."),
 * )
 */
final class Weekend extends MessagePurgeBase {

  // Add matching conditions to the message entity query; return the query.
  public function process(QueryInterface $query, $template) {
    // e.g. $query->condition('created', $someTimestamp, '<');
    return $query;
  }

  // Optional: expose a config form (via buildConfigurationForm) like Days/Quota do.
}
```

Look at `src/Plugin/MessagePurge/Days.php` and `Quota.php` for the full shape (they inject
services, add a `days`/`quota` numeric setting, and build a config sub-form). Purge plugin
config is stored under a template's `settings.purge_methods` or the global
`message.settings.purge_methods`, keyed by plugin id with `{ id, enabled, data, weight }`.

The `message.purge_orchestrator` service iterates enabled methods on cron and deletes matched
messages. Clear plugin discovery after adding one: `drush cr`.
