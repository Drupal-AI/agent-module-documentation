<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# hook_page_refresh_webhook_trigger_webhook()

Veto (or explicitly allow) a webhook trigger for a given node. Defined in `page_refresh_webhook.api.php`.

```php
function hook_page_refresh_webhook_trigger_webhook(
  \Drupal\Core\Entity\EntityInterface $entity,
  string $operation, // 'insert' | 'update' | 'delete'
): \Drupal\page_refresh_webhook\PageRefreshWebhookTriggerInstruction;
```

Return one of the enum cases:

- `PageRefreshWebhookTriggerInstruction::Prevent` — abort the webhook.
- `PageRefreshWebhookTriggerInstruction::Neutral` — no opinion.
- `PageRefreshWebhookTriggerInstruction::Permit` — allow (behaves like Neutral).

**A single `Prevent` from any implementation wins** — `Permit` cannot force a run that another module vetoed.

The hook only runs **after** the module already decided the entity is relevant: it is a node, its bundle is enabled, and it is not skipped for being unpublished. So you only need to add extra veto logic (e.g. draft moderation states).

## Example (class-based `#[Hook]`, D11.2+)

```php
namespace Drupal\my_module\Hook;

use Drupal\Core\Entity\EntityInterface;
use Drupal\Core\Hook\Attribute\Hook;
use Drupal\page_refresh_webhook\PageRefreshWebhookTriggerInstruction;

class WebhookHooks {

  #[Hook('page_refresh_webhook_trigger_webhook')]
  public function triggerWebhook(EntityInterface $entity, string $operation): PageRefreshWebhookTriggerInstruction {
    if ($operation === 'update' && $entity->get('moderation_state')->value === 'draft') {
      return PageRefreshWebhookTriggerInstruction::Prevent;
    }
    return PageRefreshWebhookTriggerInstruction::Neutral;
  }

}
```

## Changed from 1.x

The enum moved out of the global namespace and its cases were renamed to Drupal style:

| 1.x | 2.x |
|---|---|
| `\PageRefreshWebhookTriggerInstruction` | `\Drupal\page_refresh_webhook\PageRefreshWebhookTriggerInstruction` |
| `::PREVENT` / `::NEUTRAL` / `::PERMIT` | `::Prevent` / `::Neutral` / `::Permit` |
