<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# mail_composer API usage

Service: `mail_composer.manager` → `Drupal\mail_composer\Manager`.

## With a custom Email class + Twig template (recommended)
1. Subclass `Drupal\mail_composer\Email`:
```php
namespace Drupal\my_module;
use Drupal\mail_composer\Email;
class TestEmail extends Email {
  public function getSubject(): string { return $this->t('My test email'); }
  public function getFrom(): string { return 'foobar@foo.bar'; }
}
```
2. Add a Twig body template `my_module/templates/emails/test-email.html.twig` using `{{ my_variable_1 }}` etc. (HTML template works with a mailer like Symfony Mailer/SwiftMailer).
3. Send:
```php
$manager = \Drupal::service('mail_composer.manager');
$email = new \Drupal\my_module\TestEmail(['my_variable_1' => 'foo', 'my_variable_2' => 'bar']);
$manager->compose($email)->setTo('foo@bar.bar')->send();
```
Manager setters override any values declared on the Email class.

## Without a template
Skip the template and provide `TestEmail::getBody()` or `$manager->setBody([...])`.

## With the default Email class (no subclass)
```php
$manager->setSubject('My test email')
  ->compose()
  ->setFrom('foobar@foo.bar')->setTo('foo@bar.bar')
  ->setSubject('Test subject')->setBody(['This is the body.'])
  ->send();
```

## Contract
- Setters: `setFrom, setTo, setSubject, setBody(array), setReplyTo, setKey, setLangcode, setHeaders`.
- `compose(?EmailInterface)` copies Email-class values into the manager (default `Email` when null).
- `send()` requires non-empty `to`, `langcode`, `key`; otherwise throws `MailingException`. Returns the mail result bool. Default `key` is `mail_composer` if not set via `setKey()`.
- Delivery is performed by `@plugin.manager.mail` (site mail plugin).
