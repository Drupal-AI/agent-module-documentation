# EmailAdjuster plugin type

An EmailAdjuster is a configurable unit of email modification, stacked inside a
`mailer_policy` and run during an email phase.

- Attribute: `Drupal\mailer_policy\Attribute\EmailAdjuster` — params: `id`, `label`,
  `description`, `weight` (int, or per-phase `[PHASE => weight]`; lower runs first).
- Manager: `EmailAdjusterManagerInterface` → `EmailAdjusterManager`
  (`Plugin/EmailAdjuster`, interface `EmailAdjusterInterface`, base `EmailAdjusterBase`).
- Alter hook: `hook_mailer_adjuster_info_alter()` (`alterInfo('mailer_adjuster_info')`).

## Built-in adjusters (`Plugin/EmailAdjuster/`)
Addressing: `email_from`, `email_to`, `email_cc`, `email_bcc`, `email_reply_to`,
`email_sender`. Content: `email_subject`, `email_body`. Presentation: `email_theme`,
`email_inline_css`, `email_inline_images`, `email_wrap_and_convert`, `email_plain`,
`email_absolute_url`. Delivery: `email_transport`, `email_priority`, `email_skip_sending`.

## Implement one
```php
namespace Drupal\my_module\Plugin\EmailAdjuster;

use Drupal\mailer_policy\EmailAdjusterBase;
use Drupal\symfony_mailer\EmailInterface;
use Drupal\mailer_policy\Attribute\EmailAdjuster;
use Drupal\Core\StringTranslation\TranslatableMarkup;

#[EmailAdjuster(
  id: 'my_adjuster',
  label: new TranslatableMarkup('My adjuster'),
  description: new TranslatableMarkup('Does something to the email.'),
  weight: 500,
)]
class MyAdjuster extends EmailAdjusterBase {
  public function build(EmailInterface $email): void { /* modify $email */ }
  // buildConfigurationForm()/settings for the policy edit form
}
```
Add config schema under `mailer_policy.adjuster.my_adjuster` so the policy stores your
settings. Reuse any adjuster in code via
`EmailAdjusterManagerInterface::createInstance($id, $config)->init($email)`.
