<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Confirmation email settings

Configured per registration type as third-party settings under key `registration_confirmation`
(schema `registration.type.*.third_party.registration_confirmation`):

| Key | Type | Meaning |
|---|---|---|
| `enable` | boolean | send a confirmation email when a registration completes |
| `subject` | string (label) | the email subject (tokens supported) |
| `message` | text_format (`{value, format}`) | the email body; filtered through `format`, tokens supported |

On the registration type edit form these are the **Confirmation email settings** fieldset; subject
and message are only relevant when `enable` is checked. If the Token module is on, a token browser is
shown and tokens such as `[node:title]` (and registration/host tokens) resolve at send time.

## Storage (config prefix `registration.type.<id>`)

```yaml
third_party_settings:
  registration_confirmation:
    enable: true
    subject: 'You are registered for [node:title]'
    message:
      value: '<p>Thanks for registering. See you there!</p>'
      format: basic_html
```

## Read / write with drush

```bash
drush cget registration.type.conference third_party_settings.registration_confirmation
```

```php
$type = \Drupal\registration\Entity\RegistrationType::load('conference');
$type->setThirdPartySetting('registration_confirmation', 'enable', TRUE);
$type->setThirdPartySetting('registration_confirmation', 'subject', 'You are registered for [node:title]');
$type->setThirdPartySetting('registration_confirmation', 'message', ['value' => '<p>Thanks!</p>', 'format' => 'basic_html']);
$type->save();
```

## Behaviour

`Drupal\registration_confirmation\EventSubscriber\RegistrationEventSubscriber` reacts when a
registration reaches the completed state and, when `enable` is TRUE, sends the subject/message via
`registration.notifier` (`RegistrationMailer`). This is immediate (on completion), separate from the
base module's scheduled **reminder** emails and from the Wait List submodule's wait-list confirmation.
