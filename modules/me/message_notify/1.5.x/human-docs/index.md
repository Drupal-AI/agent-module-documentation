# Message Notify — manual setup guide

**Message Notify** (`message_notify`) is a **developer‑facing notification
framework** for the [Message](https://www.drupal.org/project/message) module. It
takes a Message entity, renders it, and delivers it to a user through a pluggable
**notifier** — email works out of the box, and you can add your own (SMS, push,
Slack, a webhook) by writing a notifier plugin. It's the piece that turns
"something happened, and there's a Message recording it" into "the right person
gets an email about it."

Unlike most modules in this knowledge base, Message Notify has **no admin
settings page and no point‑and‑click configuration** — it is code‑facing. You
trigger a notification from your own module (typically from an entity hook or an
event) by calling the `message_notify.sender` service. What a notification
*contains*, however, is controlled through the normal Drupal UI: the module
manages two Message **view modes** — `mail_subject` and `mail_body` — and
auto‑creates their per‑bundle view displays, so by default the first line of a
message template becomes the email subject and the rest becomes the body. You can
edit those displays to change exactly what a notification shows.

Because it's a framework, the interesting parts are the sending API, the
options you can pass (recipient address, from address, language, whether to save
the message), and the notifier plugin type for adding your own delivery channels.
A small **example** submodule demonstrates wiring a notification to an entity
event.

This guide is written for a **human** (here, a developer) working with the
module. If you want terse, token‑cheap references for an AI coding agent, read
the sibling [`agent/`](../agent/start.md) docs instead — they cover the service
signature, options, and the notifier plugin type in full.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and note the example submodule.

## Where it lives in the admin menu

Message Notify adds no menu item and no settings page. The only UI touch‑points
are the two mail view displays on each message template, at **Structure →
Messages → [template] → Manage display**, under the **Mail subject** and **Mail
body** display modes.

## How to use it

### Send a notification (in code)

Create (and save) a Message entity, then hand it to the sender service. The
default notifier is `email`:

```php
$message = \Drupal\message\Entity\Message::create([
  'template' => 'my_template',   // an existing message template (bundle)
  'uid' => $recipient_uid,       // the owner; email defaults to this user's address
]);
$message->save();

$notifier = \Drupal::service('message_notify.sender');
$success = $notifier->send($message);          // returns TRUE/FALSE
```

To send to an explicit address instead of the message owner, pass the `mail`
option:

```php
$notifier->send($message, ['mail' => 'user@example.com']);
```

Useful options include `mail` (recipient), `from` (sender address), `language
override` (render in the message's own language), `save on success` (default
TRUE — the message row is saved after sending), `save on fail`, and `rendered
fields` (save the rendered output back into message fields). Delivery failures
are logged to the `message_notify` channel; `send()` returns FALSE rather than
throwing on a failed transport. (Note: the built‑in `sms` notifier is only a
stub — it requires the SMS Framework — so email is the one that works out of the
box.)

### Control what the notification contains

Edit the message template's **Mail subject** and **Mail body** view displays
(*Structure → Messages → [template] → Manage display*, then the `mail_subject` /
`mail_body` display modes) to add, remove, reorder, or reformat fields — exactly
like any entity view display. The notifier renders whatever those displays
output. If you create message templates by importing configuration (config
sync), the automatic display setup is skipped, so remember to export the
`mail_subject` / `mail_body` displays with your config.

### Add your own delivery channel

Write an `@Notifier` plugin extending `MessageNotifierBase` and implementing its
`deliver()` method to send through any channel you like, then call it by id:
`$notifier->send($message, $options, 'my_notifier')`. See the
[`agent/plugins/notifier.md`](../agent/plugins/notifier.md) reference for the
plugin contract.
