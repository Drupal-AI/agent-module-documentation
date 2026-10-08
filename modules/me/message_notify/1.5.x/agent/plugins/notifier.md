# Notifier plugins

Message Notify defines a **Notifier** plugin type. Each notifier is a delivery transport
(email, SMS, push, webhook, ...).

## Plugin type wiring

- Discovery dir: `src/Plugin/Notifier/`
- Annotation: `@Notifier` (`Drupal\message_notify\Annotation\Notifier`) with keys `id`,
  `title`, `description`, `viewModes` (array of Message view modes to render).
- Interface: `MessageNotifierInterface`; abstract base: `MessageNotifierBase`.
- Manager service: `plugin.message_notify.notifier.manager`
  (`Drupal\message_notify\Plugin\Notifier\Manager`), alter hook
  `hook_message_notifier_info_alter()`, cache key `message_notifier_info`.

## Built-in notifiers

- **`email`** (`Plugin/Notifier/Email.php`) — renders `mail_subject` + `mail_body` view
  modes and sends via core's Mail manager (`message_notify_mail()` / `hook_mail`). Options:
  `mail`, `from`, `language override`.
- **`sms`** (`Plugin/Notifier/Sms.php`) — a stub: its `deliver()` throws unconditionally and
  it has **no `@Notifier` annotation**, so it is not registered as a usable plugin. It exists
  as a template for an SMS Framework integration.

## Implement a notifier

```php
namespace Drupal\my_module\Plugin\Notifier;

use Drupal\message_notify\Plugin\Notifier\MessageNotifierBase;

/**
 * @Notifier(
 *   id = "slack",
 *   title = @Translation("Slack"),
 *   description = @Translation("Send messages to Slack"),
 *   viewModes = { "mail_body" }
 * )
 */
class Slack extends MessageNotifierBase {

  public function deliver(array $output = []) {
    // $output is keyed by view mode id => rendered string.
    $body = $output['mail_body'];
    // ...post to Slack; return TRUE on success, FALSE on failure.
    return TRUE;
  }
}
```

Then: `\Drupal::service('message_notify.sender')->send($message, [], 'slack');`

## What the base class does for you

`MessageNotifierBase::send()`:
1. Renders the Message once per `viewModes` entry (via the `message` view builder;
   `renderInIsolation()` on core ≥ 10.3, `renderPlain()` before).
2. Calls your `deliver($output)`.
3. Calls `postSend($result, $output)` — logs failures to the `message_notify` channel,
   applies `save on success` / `save on fail`, and writes `rendered fields` into the message.

Override points: `deliver()` (required), `access()` (default TRUE — gate delivery),
`postSend()` (custom result handling), `setMessage()`.

## Constructor / DI

`MessageNotifierBase` takes `logger.channel.message_notify`, `entity_type.manager`,
`renderer`, and the optional Message entity. If your notifier needs more services, override
`create()` (see `Email::create()` which also injects `plugin.manager.mail`). Note the manager
passes the Message entity into `create()`/the constructor as an extra argument.
