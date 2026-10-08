# Plugins: component mailers & processors

## Component mailers (`#[MailerInfo]`)
A component mailer turns a Drupal event (a user action, a contact submission, an order…)
into an `Email` and declares which email tags it owns.

- Attribute: `Drupal\symfony_mailer\Attribute\MailerInfo` (TARGET_CLASS) — params:
  `base_tag`, `label`, `sub_defs` (sub-types), `metadata_key`, `required_config`,
  `token_types`, `variables`.
- Manager: `MailerLookupInterface` → `MailerLookup` (autowired default plugin manager).
- Base class: `Component\ComponentMailerBase` (`ComponentMailerInterface`).
- Discovery: component mailers are registered as services (see `symfony_mailer.services.yml`),
  e.g. `UserMailer`, `ContactMailer`, `CommerceOrderMailer`, `UpdateMailer`, `VerifyMailer`,
  `SimplenewsNewsletterMailer`, `SimplenewsSubscriberMailer`, `UserRegistrationPasswordMailer`.
- Alter: `hook_symfony_mailer_info_alter(array &$mailers)`.

Sketch:
```php
#[MailerInfo(
  base_tag: 'my_module',
  label: new TranslatableMarkup('My module'),
  sub_defs: ['welcome' => 'Welcome email'],
  token_types: ['user'],
  variables: ['user' => new TranslatableMarkup('The user')],
)]
class MyMailer extends ComponentMailerBase implements MyMailerInterface {
  // build the Email(s) for base_tag/sub-type
}
```

## Email processors
Cross-cutting logic that runs on the `Email` during a phase.

- Interface: `Processor\EmailProcessorInterface` (+ `EmailProcessorTrait`,
  `ReplaceableProcessorInterface`, `CallbackEmailProcessor`).
- Registered by tagging a service `symfony_mailer.add_processor` (collected into
  `MailerPlus::addProcessor()`), or added per-email via `$email->addProcessor(...)`.
- Phases: constants on `EmailInterface::PHASE_*` (init, build, pre_render, post_render,
  post_send); lower weight runs first.

## EmailAdjuster (config-driven)
The configurable, policy-based plugin type (`#[EmailAdjuster]`) is defined by the
**mailer_policy** submodule — see that module's docs.
