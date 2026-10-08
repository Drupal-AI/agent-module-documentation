<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Viber Channel sends Viber messages to a channel.

---

Viber Channel **sends messages to a Viber channel/bot** — pushing notifications/content to a Viber public
account or channel via the Viber API, for messaging/broadcast. It provides its own permissions, in the Web
services package.

Use it to broadcast to Viber. It is an integration/messaging feature. Security/data handling: it authenticates
with a **Viber bot/API token** (store it as a **secret** — env/Key — over HTTPS; a leaked token lets anyone post
as the bot) and sends messages to Viber (external egress) — keep message content free of sensitive data and gate
who can send via its permission. It has no access-control role beyond its permission. Configure the Viber token
and channel.

---

- Send messages to a Viber channel.
- Push notifications/content.
- Use the Viber API.
- Provide its own permissions.
- Broadcast via Viber.
- Serve messaging.
- Store the Viber token as a secret over HTTPS.
- Know a leaked token = post as bot.
- Keep message content non-sensitive.
- Gate who can send.
- Have no access-control role beyond permission.
- Configure the token and channel.
- Handle Viber messaging.
- Send messages.
- Configure the channel.
- Broadcast messages.
- Handle the integration.
- Push to Viber.
- Secure the token.
- Provide Viber messaging.
