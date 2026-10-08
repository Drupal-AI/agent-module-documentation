# MailerOverride plugin type

A MailerOverride declares one legacy email **source** that can be redirected into Mailer Plus,
and the default policies to import when it is enabled.

- Attribute: `Drupal\mailer_override\Attribute\Override`.
- Manager: `OverrideManagerInterface` → `OverrideManager` (`Plugin/MailerOverride`,
  interface `OverrideInterface`, base `OverrideBase`).
- Alter hook: `hook_mailer_override_info_alter()` (`alterInfo('mailer_override_info')`).
- Related: `Plugin/Mailer/LegacyMailer` (a `#[MailerInfo]` component mailer that handles
  overridden legacy mail), `MailManagerReplacement` (the intercepting `mail.manager`
  replacement service, installed via `MailerOverrideServiceProvider`).

## Built-in plugins (`Plugin/MailerOverride/`)
`UserOverride`, `ContactOverride`, `UpdateOverride`, `UserRegistrationPasswordOverride`,
`CommerceOrderOverride`, `SimplenewsNewsletterOverride`, `SimplenewsSubscriberOverride`.
Each ships default `mailer_policy` config under `config/mailer_override/` that is imported on
enable.

## Implement one
```php
namespace Drupal\my_module\Plugin\MailerOverride;

use Drupal\mailer_override\OverrideBase;
use Drupal\mailer_override\Attribute\Override;
use Drupal\Core\StringTranslation\TranslatableMarkup;

#[Override(
  id: 'my_source',
  label: new TranslatableMarkup('My module emails'),
)]
class MySourceOverride extends OverrideBase {
  // declare the legacy module/keys captured and the default policies to import
}
```
Ship the default policies as `mailer_policy.mailer_policy.*.yml` under your module's
`config/mailer_override/` so enabling the override imports them.
