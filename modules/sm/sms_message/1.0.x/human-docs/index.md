# SMS Message — manual setup guide

**SMS Message** (`sms_message`) lets you send bulk SMS to your customers **using
your own Android phone** as the sending device, rather than paying an SMS gateway.
The idea is simple: Drupal holds a queue of messages to send, and a companion
Android app polls Drupal's API on an interval, downloads any unsent messages, and
sends them through your phone's normal SMS service. It's aimed at people who have
a customer list in Drupal and want to text them without a paid gateway account.

When you enable it, the module gives you a **SMS message** content entity and an
admin screen at `/admin/content/sms-message` to manage sent messages, plus a
configuration page where you set a **token** used to secure the API endpoint. It
depends on core's **Telephone** module and provides its own permissions, and it
lives in the *Custom* package.

To actually send, you install the companion Android app on your phone (the
project links to an APK), grant it SMS permission, and point it at your site's
endpoint — `https://yoursite.com/api/sms/YOURTOKEN` — then tap *On Service*. By
default the app queries the endpoint every couple of minutes (configurable) and
sends whatever messages are waiting.

Two things are worth flagging for security. First, that API endpoint is protected
only by the **token embedded in its URL**, so treat the token as a secret: use a
long, unguessable value, serve the site over HTTPS, and be aware that anyone who
learns the URL can read (and, with `?action=delete`, drain) your pending messages.
Second, sending texts from your own phone still involves your recipients' **phone
numbers as personal data** and carrier limits — handle them with the usual consent
and privacy care, and don't use this to send unsolicited messages.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — set the endpoint token, connect the
   Android app, and set up bulk sending.

## Where it lives in the admin menu

- **Manage SMS messages:** `/admin/content/sms-message`
- **SMS settings** (the endpoint token and polling): the module's configuration /
  *Sms setting* page.

## How to use it

You can create messages in three ways: manually at `/admin/content/sms-message`;
programmatically by creating an `sms_message` entity in custom code; or in bulk
using **Views Bulk Operations**. For bulk sends, build a customer content type
with a required phone field and a taxonomy of SMS templates, create a VBO View
over your customers, enable the VBO **SMS message** action, and select the phone
field and template vocabulary — when you run it, you pick which template term to
send. The messages queue in Drupal until your Android app collects and sends them.
