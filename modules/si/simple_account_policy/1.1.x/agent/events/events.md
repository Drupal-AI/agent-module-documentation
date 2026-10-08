# Events

The module never mutates a user account directly. `AccountPolicy` dispatches an event for each
decision, and a bundled subscriber performs the real change. In 1.1.x each event has its own
subscriber class under `src/EventSubscriber/` (registered in `simple_account_policy.services.yml`
with `tags: [{ name: event_subscriber }]`). Add your own subscriber to react to (or replace) a
decision.

| Event class | `EVENT_NAME` constant | Fired by | Default subscriber (class) | Default action |
|---|---|---|---|---|
| `Event\AccountPolicyBlockEvent` | `simple_account_policy_block` | `AccountPolicy::block()` | `AccountPolicyBlockSubscriber` | `$account->block(); $account->save();` |
| `Event\AccountPolicyActivateEvent` | `simple_account_policy_activate` | `AccountPolicy::activate()` (controller / row op) | `AccountPolicyActivateSubscriber` | Delete this user's `user.failed_login_user` flood rows, `$account->activate()`, `setLastAccessTime(time())`, `save()`. |
| `Event\AccountPolicyWarningEvent` | `simple_account_policy_warning` | `AccountPolicy::issueWarning()` (cron) | `AccountPolicyWarningSubscriber` | Send the `inactive_warning_mail` to `$account->getEmail()` via the mail manager. |
| `Event\AccountPolicyDeleteEvent` | `simple_account_policy_delete` | `AccountPolicy::delete()` (cron) | `AccountPolicyDeleteSubscriber` | Log a notice, run core `user_cancel()` with the event's cancel method, then `batch_process()` (or drush batch on CLI). |

All event objects expose public `$account` (`UserInterface`) and `$policy`
(`AccountPolicyInterface`). `AccountPolicyDeleteEvent` also carries `getCancelMethod(): string`
(the configured `user_cancel_method`).

## Subscribe from your module

```php
namespace Drupal\my_module\EventSubscriber;

use Drupal\simple_account_policy\Event\AccountPolicyBlockEvent;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;

class MyPolicySubscriber implements EventSubscriberInterface {

  public static function getSubscribedEvents(): array {
    return [AccountPolicyBlockEvent::EVENT_NAME => ['onBlock']];
  }

  public function onBlock(AccountPolicyBlockEvent $event): void {
    // $event->account is the user about to be blocked.
    \Drupal::logger('my_module')->notice('Blocking @u', ['@u' => $event->account->getAccountName()]);
  }
}
```

Register it in `my_module.services.yml` with `tags: [{ name: event_subscriber }]`.
