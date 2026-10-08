# Notifier — manual setup guide

**Notifier** (`notifier`) brings the **Symfony Notifier** component into Drupal.
It provides a framework for sending messages where the *what* is separated from
the *how*: you construct a message and send it to a recipient without your code
needing to know whether it will go out as an email, an SMS, or a chat message, or
which API and address details are involved. In Drupal terms, you can send a
message to a user (or any entity) without hard‑coding the delivery channel.

The channels themselves are provided as separate modules that plug into Notifier:

- **Email** — dispatches through Symfony Mailer (see the
  [Notifier Email Channel](https://www.drupal.org/project/notifier_email_channel)
  module).
- **Chat** — chat‑style messages, including services you might not immediately
  think of as "chat" (see the
  [Notifier Chat Channel](https://www.drupal.org/project/notifier_chat_channel)
  module, which covers Slack, Discord, Telegram, and many more).
- **SMS** — text messages to phones, implemented via the SMS Framework.

So Notifier is the **base integration**; you add the channel module(s) for the
delivery methods you actually need. Note that the current 3.x series is the
modern iteration of the project — the old v1/v2 releases were for Drupal 6 and
served a completely different purpose. This version requires **PHP 8.3** and
Drupal **10.3 or newer**.

Because channels talk to external services, the security posture that matters
here is **credential handling**. Transports are defined with connection strings
(DSNs) that carry provider API keys, tokens, or SMTP credentials; those are
secrets and must be stored as secrets, and the connections should use secure
(TLS) endpoints. Notifier has no access‑control role of its own — but the
notifications it sends may carry user data (recipients and message content), so
be deliberate about what you send and where.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, check the
   PHP 8.3 requirement, enable it, and add the channel module(s) you need.
2. [Configuration](configuration/index.md) — defining transports and, crucially,
   storing their credentials safely.

## How to use it

With Notifier and at least one channel module enabled, custom code sends a
message to a recipient and lets the configured transport(s) decide how it is
delivered. The value of the abstraction is that the sending code stays the same
whether the message ultimately leaves as an email, an SMS, or a Slack post —
you change the delivery by configuring transports, not by rewriting code.
