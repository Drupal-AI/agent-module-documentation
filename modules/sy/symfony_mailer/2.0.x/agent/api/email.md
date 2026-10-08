# Email API

## Core services
- `MailerPlusInterface` → `MailerPlus` — the sender; collects processors
  (`addProcessor()`) and sends an `Email` through its phases.
- `MailerLookupInterface` → `MailerLookup` — resolves the component mailer for a tag.

## The Email object
`Drupal\symfony_mailer\Email` (`EmailInterface`, extends `BaseEmailInterface`). Key setters
(fluent), used while building:
- `setSubject()`, `setBody(array $render)`, `setHtmlBody()`, `setTo()`, `setFrom()`,
  `setReplyTo()`, `setCc()`, `setBcc()`, `addProcessor()`, `setParam()`, `setVariable()`.
- Accessors: `getBody()`, `getHtmlBody()`, `getHeaders()`, `getTo()`, `getType()`,
  `getSubType()`.
- Addresses use `Address` / `AddressInterface`; files use `Attachment` /
  `AttachmentInterface`.

Phases are constants `EmailInterface::PHASE_INIT|BUILD|PRE_RENDER|POST_RENDER|POST_SEND`
(names in `EmailInterface::PHASE_NAMES`).

## Sending in code
Normally you don't send directly — you implement a component mailer (`#[MailerInfo]`) and let
Mailer Plus create and send the `Email`. To influence an existing email, add a processor or
use a phase hook:
```php
// e.g. hook_mailer_build():
function my_module_mailer_build(EmailInterface $email): void {
  $body = $email->getBody();
  $body['extra'] = ['#markup' => 'Extra text'];
  $email->setBody($body);
}
```
Reuse a configured adjuster on any email:
```php
\Drupal::service(\Drupal\mailer_policy\EmailAdjusterManagerInterface::class)
  ->createInstance('email_skip_sending', ['message' => 'skipped'])
  ->init($email);
```
See [../hooks/hooks.md](../hooks/hooks.md) for the full phase-hook set.
