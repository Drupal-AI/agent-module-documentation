# TransportUI plugin type

A TransportUI plugin supplies the add/edit form and DSN-building logic for one kind of
transport; each saved transport is a `mailer_transport` config entity using one of these.

- Attribute: `Drupal\mailer_transport\Attribute\TransportUI`.
- Manager: `TransportUIManagerInterface` → `TransportUIManager`
  (`Plugin/TransportUI`, interface `TransportUIInterface`, base `TransportUIBase`).
- Alter hook: `hook_mailer_transport_info_alter()` (`alterInfo('mailer_transport_info')`).

## Built-in plugins (`Plugin/TransportUI/`)
- `smtp` (`SmtpTransportUI`) — host, port, user, password, encryption.
- `sendmail` (`SendmailTransportUI`) — local sendmail command (validated).
- `native` (`NativeTransportUI`) — PHP's configured mailer.
- `dsn` (`DsnTransportUI`) — paste any Symfony Mailer DSN (SES/Mailgun/SendGrid/…).
- `null` (`NullTransportUI`) — discard mail (staging/testing).

## Implement one
```php
namespace Drupal\my_module\Plugin\TransportUI;

use Drupal\mailer_transport\TransportUIBase;
use Drupal\mailer_transport\Attribute\TransportUI;
use Drupal\Core\StringTranslation\TranslatableMarkup;

#[TransportUI(
  id: 'my_service',
  label: new TranslatableMarkup('My delivery service'),
)]
class MyServiceTransportUI extends TransportUIBase {
  // buildConfigurationForm(): fields shown on the add/edit form
  // getDsn(): assemble the Symfony DSN from the stored configuration
}
```
Provide config schema for your plugin's `configuration` mapping.
