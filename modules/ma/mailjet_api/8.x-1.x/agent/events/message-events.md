# Message build events

`MailjetApiHandler::buildMessagesBody()` dispatches two events so integrators can alter the mail
without a `hook_mail_alter()`. Constants live on `Drupal\mailjet_api\Event\MailjetApiEvents`.

| Constant | Event name | Payload class | Dispatched |
|----------|------------|---------------|-----------|
| `MAILJET_API_MESSAGE_PRE_BUILD` | `mailjet_api.message_pre_build` | `MailjetApiMessagePreBuild` | On the raw Drupal `$message` array, before it is mapped to the Mailjet payload. |
| `MAILJET_API_MESSAGE_POST_BUILD` | `mailjet_api.message_post_build` | `MailjetApiMessagePostBuild` | On the built single Mailjet message array, before `SandboxMode` and the `Messages` wrapper are added. |

Both payload classes extend `Drupal\Component\EventDispatcher\Event` and expose
`getMessage(): array` and `setMessage($message): void`.

Typical use of pre-build: inject `params['TemplateId']`, `params['CustomCampaign']`,
`params['Variables']`, etc. Post-build: tweak the final Mailjet fields (headers, campaign, etc.).

```php
namespace Drupal\my_module\EventSubscriber;

use Drupal\mailjet_api\Event\MailjetApiEvents;
use Drupal\mailjet_api\Event\MailjetApiMessagePreBuild;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;

class MailjetSubscriber implements EventSubscriberInterface {

  public static function getSubscribedEvents(): array {
    return [MailjetApiEvents::MAILJET_API_MESSAGE_PRE_BUILD => 'onPreBuild'];
  }

  public function onPreBuild(MailjetApiMessagePreBuild $event): void {
    $message = $event->getMessage();
    $message['params']['TemplateId'] = 42;
    $event->setMessage($message);
  }
}
```

Caveat (source): `setMessage()` is type-hinted `string $message` in both payload classes even
though the value is an array — passing an array raises a `TypeError`. Until that is fixed, altering
via `setMessage()` is unreliable; `hook_mail_alter()` is the dependable fallback for changing the
core message before build.
