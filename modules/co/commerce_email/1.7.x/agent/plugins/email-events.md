<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `commerce_email_event` plugin type

Email event plugins map a Commerce business event to a Symfony event name, and know how to pull
the relevant entity out of that event. An email entity's `event` key is one of these plugin ids.

- **Manager:** `plugin.manager.commerce_email_event` (`EmailEventManager`)
- **Interface / base:** `EmailEventInterface` / `EmailEventBase`
- **Annotation:** `@CommerceEmailEvent` (`id`, `label`, `event_name`, `entity_type`, `priority`, `deriver`)
- **Directory:** `src/Plugin/Commerce/EmailEvent/`

## Shipped plugins

| Plugin id | `event_name` (Symfony) | `entity_type` |
|---|---|---|
| `order_placed` | `commerce_order.place.post_transition` | `commerce_order` |
| `order_paid` | `commerce_order.order.paid` | `commerce_order` |
| `order_transition:<transition>` | `commerce_order.<transition>.post_transition` | `commerce_order` |
| `checkout_register` | `commerce_checkout.checkout_register` | `user` |
| `checkout_completion_register` | `commerce_checkout.completion_register` | `commerce_order` |
| `commerce_recurring_payment_declined` | `commerce_recurring.payment_declined` | `commerce_order` |

`order_transition` is a **derivative**: `OrderTransitionDeriver` reads every order-workflow
transition (except `place`, already covered by `order_placed`) and produces one plugin per
transition, so custom order workflows automatically add events.

`RecurringPaymentDeclined` only functions when Commerce Recurring is installed.

## Annotation fields

- `id` — plugin id used as the email entity's `event`.
- `label` — shown in the email add form's Event select.
- `event_name` — the Symfony event the `EmailSubscriber` listens on.
- `entity_type` — entity type the event fires for; used as the default `targetEntityType`.
- `priority` — listener priority (default 0). Change per-plugin, or via
  `hook_commerce_email_event_info_alter()` for the module's own plugins.

## Writing a custom email event

```php
namespace Drupal\my_module\Plugin\Commerce\EmailEvent;

use Drupal\commerce_email\Plugin\Commerce\EmailEvent\EmailEventBase;
use Symfony\Component\EventDispatcher\Event;

/**
 * @CommerceEmailEvent(
 *   id = "my_custom_event",
 *   label = @Translation("My custom event"),
 *   event_name = "my_module.something_happened",
 *   entity_type = "commerce_order",
 * )
 */
class MyCustomEvent extends EmailEventBase {

  public function extractEntityFromEvent(Event $event) {
    return $event->getOrder();      // return the ContentEntity the email is "about"
  }

}
```

Then store owners can create a `commerce_email` entity with `event: my_custom_event`.
`EmailEventBase` supplies `getLabel()`, `getEventName()`, `getEntityTypeId()`,
`getRelatedEntityTypeIds()`, and `extractRelatedEntitiesFromEvent()`; override the extract
methods to expose your event's entities/tokens.
