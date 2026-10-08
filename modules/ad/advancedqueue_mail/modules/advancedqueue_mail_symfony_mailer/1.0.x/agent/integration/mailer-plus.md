<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Mailer Plus integration

## Install & enable

```bash
composer require drupal/symfony_mailer   # Mailer Plus, 1.6.x or 2.0.x
drush en advancedqueue_mail_symfony_mailer -y
drush cr
```

Depends on `advancedqueue_mail` and `symfony_mailer`. On sites that already had `symfony_mailer` when upgrading
the parent, `advancedqueue_mail`'s `hook_update_10002()` enables this submodule automatically.

## How the sender is overridden

`AdvancedqueueMailSymfonyMailerServiceProvider::alter(ContainerBuilder $container)`
(`src/AdvancedqueueMailSymfonyMailerServiceProvider.php`):

1. Returns if `advancedqueue_mail.mail_sender` is not defined.
2. Version-detects via `interface_exists('Drupal\symfony_mailer\MailerPlusInterface')`:
   - **2.x present** → sets the sender class to `Service\SymfonyMailerV2MailSender`, argument
     `new Reference('Drupal\symfony_mailer\MailerPlusInterface')`; and registers an autowired, public
     `Component\AdvancedQueueMailMailer` service so 2.x can discover the mailer.
   - **otherwise (1.x)** → sets the class to `Service\SymfonyMailerMailSender`, argument
     `new Reference('email_factory')`.

Because it overrides the existing service id, the parent's `AdvancedQueueEventSubscriber` keeps calling
`MailSenderInterface::sendNotificationMail()` — only the implementation changes.

## The two senders

- `SymfonyMailerMailSender` (1.x): `$this->emailFactory->newTypedEmail('advancedqueue_mail', $event_type, $job)`,
  then `setVariable('job', $job)` and `send()`.
- `SymfonyMailerV2MailSender` (2.x): `$this->mailer->newEmail("advancedqueue_mail.$event_type")`, then
  `setParam('job', $job)`, `setVariable('job', $job)` and `send()`.

## Email type registration

Both a plugin and an attribute declare the base tag `advancedqueue_mail` with sub-types `on_success` (Job
success), `on_retry` (Job retry), `on_failure` (Job failure):

- 1.x: `Plugin/EmailBuilder/AdvancedQueueMail` (annotation `@EmailBuilder`), extends `EmailBuilderBase`, uses
  `TokenProcessorTrait`; `createParams(EmailInterface $email, ?Job $job)` asserts a job and stores it as the
  `job` param.
- 2.x: `Component/AdvancedQueueMailMailer` with `#[MailerInfo(base_tag: 'advancedqueue_mail', label: 'Advanced
  Queue mail', sub_defs: […])]`, extends `ComponentMailerBase`.

## Configure in Mailer Plus

Add a Mailer Plus **Policy** of type *Advanced Queue mail*, pick the sub-type you care about (usually *Job
failure*), and set subject/body/recipient/format there. Add a policy with a **Skip sending** element for the
sub-types you do not want delivered. The `job` object (`Drupal\advancedqueue\Job`) is available as a template
variable for policy templates.
