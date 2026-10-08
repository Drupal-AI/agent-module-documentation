# Telegram API — manual setup guide

**Telegram API** (`telegram_api`) provides a **Telegram bot client** that other
modules can use to post messages into a Telegram chat — and a ready‑made
**`telegram_api_webform`** submodule that sends Webform submissions straight to a
chat without any code. It is aimed at developers who want a simple, reliable way to
push notifications from Drupal into Telegram: a new order, a failed cron run, a
fresh registration or a contact enquiry landing in a channel the relevant people
already have open.

The reason teams reach for Telegram is that a bot posting into a group reaches
people where they already are — unlike email, which has to be checked, and unlike
SMS, which costs per message. The `telegram_api_webform` handler covers the most
common case directly; for anything else, the module exposes a service
(`telegram_api.service`) that custom code calls with a small value object
describing the message (its text, bot token and chat ID). Version 2.0.x adds the
option to **queue** messages for delayed sending (run with
`drush queue:run telegram_api_queue`) and to send to a custom endpoint. It supports
Drupal 10 and 11.

Three things belong in every deployment, because Telegram is a third party:

- **The bot token is the bot.** Anyone holding it can read what the bot sees and
  post as it — store it in an environment variable, ideally behind a **Key**
  entity, and rotate it by talking to BotFather rather than editing config.
- **A group chat is not a private channel.** Everyone in the group sees every
  message the bot posts, and groups accumulate members over time — so a bot posting
  form submissions is publishing whatever those submissions contain (for a contact
  form, names, email addresses and free text) to whoever has been added since. This
  is the failure that turns a convenience into a data‑protection incident.
- **Telegram is a third‑party processor, outside the EU for most deployments.** A
  notification carrying personal data is a transfer, and "it's just our team chat"
  is not a lawful basis. Often the right shape is to **send a link** to the
  submission rather than the content itself.

This guide is written for a **human** setting the module up. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module and the Webform submodule.

## How to use it

**For the common case — Webform notifications:** enable the `telegram_api_webform`
submodule, then add its **handler** to the Webform whose submissions you want to
forward, supplying the bot token and target chat ID. New submissions are posted to
that chat.

**For custom notifications in code:** call the service with a message value object.
For example:

```php
use Drupal\telegram_api\ValueObject\TelegramMessage;

$message = new TelegramMessage(
  text: 'Hello from Drupal!',
  token: '618218965:AAG...',
  chatId: '12345678',
);
\Drupal::service('telegram_api.service')?->sendToTelegramBot($message);
```

To send in the background instead, queue it with
`\Drupal::service('telegram_api.service')?->queue($message);` and process the queue
with `drush queue:run telegram_api_queue`. Keep the real bot token out of code —
the literal above is only illustrative.
