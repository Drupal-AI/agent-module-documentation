# Plugin type: message_notify_ui_sender_settings_form

Provides the per-notifier extra form shown on the message **Notify** form. One plugin per
Message Notify notifier (matched by `notify_plugin`).

- Manager: `plugin.manager.message_notify_ui_sender_settings_form`
- Dir: `Plugin/MessageNotifyUiSenderSettingsForm`
- Interface/base: `MessageNotifyUiSenderSettingsFormInterface` / `MessageNotifyUiSenderSettingsFormBase`
- Annotation `@MessageNotifyUiSenderSettingsForm`: `id`, `label`, `notify_plugin`

## Implement one

```php
namespace Drupal\my_module\Plugin\MessageNotifyUiSenderSettingsForm;

use Drupal\message_notify_ui\MessageNotifyUiSenderSettingsFormBase;
use Drupal\message_notify_ui\MessageNotifyUiSenderSettingsFormInterface;

/**
 * @MessageNotifyUiSenderSettingsForm(
 *   id = "my_sms_sender_settings",
 *   label = @Translation("SMS sender settings"),
 *   notify_plugin = "sms"
 * )
 */
class MySmsSenderSettings extends MessageNotifyUiSenderSettingsFormBase implements MessageNotifyUiSenderSettingsFormInterface {
  public function form() {
    return [
      'phone' => ['#type' => 'tel', '#title' => $this->t('Override phone number')],
    ];
  }
}
```

Implement `form()` returning a render array; `MessageNotifyForm` embeds it when its
matching notifier (`notify_plugin`) is chosen and passes the collected values to
`message_notify.sender` when sending.

Reference plugin: `message_notify_ui_sender_settings_form`
(`MessageNotifyUiSenderMailSettingsForm`, `notify_plugin = "email"`) — a "Use custom email"
checkbox plus an email field made visible via `#states` when the checkbox is ticked.
