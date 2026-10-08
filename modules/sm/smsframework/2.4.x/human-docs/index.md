# SMS Framework — manual setup guide

**SMS Framework** (machine name `sms`) is an extensible API that connects Drupal
to SMS gateways — sending and receiving text messages through pluggable providers,
with phone‑number verification and per‑user routing built in. Text messaging shows
up across many features (two‑factor codes, order updates, appointment reminders,
alerts), and rather than each feature integrating a gateway directly, SMS
Framework is the shared layer they all build on: a provider‑agnostic API where the
gateway (Twilio and many others) is a plugin and modules send through one stable
interface.

It handles the whole message lifecycle — sending, delivery reports where the
gateway supports them, inbound messages — plus binding phone numbers to users and
verifying them. Many of the SMS gateway modules in the Drupal ecosystem (the
various `sms_*` modules) are gateway plugins that plug into this framework. It
depends on core's **System** and **Telephone** modules and on the **Dynamic Entity
Reference** module, and it ships several optional submodules: **SMS Blast**
(`sms_blast`, bulk send), **SMS User** (`sms_user`, per‑user features), **SMS Send
to phone** (`sms_sendtophone`), and **SMS Devel** (`sms_devel`, developer tools).

> **A note on the package name.** The project is *SMS Framework* and its Composer
> package is **`drupal/smsframework`**, but the module's machine name — the name you
> enable and that other modules depend on — is **`sms`**. The project's own docs
> sometimes show `composer require drupal/sms`; use `drupal/smsframework` for the
> Composer command and `sms` for `drush en`. This guide covers the **2.4.x** line
> (Drupal 11); note the maintainers consider v2 unsupported and recommend
> evaluating v3/v4 for new sites and long‑term support.

The security‑relevant parts are phone‑number handling and gateway credentials. The
framework defines the **`administer smsframework`** permission and, notably,
**`sms verify phone number`** — phone verification is identity‑adjacent (it's what
SMS‑based 2FA builds on), so treat that flow as an identity surface. And your
**gateway credentials** (a Twilio auth token, for example) are the secret to
protect: they authorise messages that cost money and reach real phones, so keep
them in secure configuration, not plain config that lands in git. Restrict who can
administer the framework and who can trigger sends.

This guide is written for a **human** setting the framework up through the admin
UI. If you want terse, token‑cheap references for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and pick the submodules you need.
2. [Configuration](configuration/index.md) — add a gateway, set the default,
   verify phone numbers, and lock down permissions.

## Where it lives in the admin menu

Gateways are managed at **`/admin/config/smsframework/gateways`**, under
**Configuration → SMS & messaging**.

## How to use it

Once a gateway is configured and set as default, other modules (and your own code)
send SMS through the framework's services rather than talking to a provider
directly. For example, to send to a user (using their verified phone number) or
straight to a number:

```php
// To a user/entity, via the phone-number service.
$phoneNumberService = \Drupal::service(\Drupal\sms\PhoneNumber\SmsPhoneNumberInterface::class);
$user = \Drupal\user\Entity\User::load(1);
$notification = (new \Symfony\Component\Notifier\Notification\Notification())->subject('Test message');
$phoneNumberService->send($user, $notification);

// Or directly to a phone number.
$notifier = \Drupal::service(\Symfony\Component\Notifier\NotifierInterface::class);
$recipient = new \Symfony\Component\Notifier\Recipient\Recipient(phone: '+123123123');
$notifier->send($notification, $recipient);
```

Support is available in the project's issue queue and in the `#sms` channel on
Drupal Slack.
