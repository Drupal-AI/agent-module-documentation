<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Telegram integration cross-posts announcements of content entities to Telegram, and can display Telegram comments on content entities.

---

Telegram integration cross-posts announcements of content entities to Telegram — so when content is
published, an announcement is sent to a Telegram channel/chat — and can display Telegram comments on content
entities. It is configured at `tg_integration.settings` and is in the Web services package.

Use it to syndicate content to Telegram and surface Telegram discussion. The security-relevant points: it
authenticates to Telegram with a **bot token** — store it as a secret (a leaked bot token lets an attacker
post as your bot); and if it displays Telegram comments on the site, that content is **external/user-supplied
input** from Telegram — ensure it is sanitized/escaped on output to avoid injecting untrusted content (XSS)
into your pages. It is an integration/social feature with no access-control role. Configure the Telegram bot
and channels.

---

- Cross-post content to Telegram.
- Announce publications to a channel.
- Display Telegram comments on content.
- Configure at tg_integration.settings.
- Store the Telegram bot token as a secret.
- Prevent bot-token leaks.
- Treat displayed Telegram comments as external input.
- Sanitize/escape Telegram content on output.
- Avoid XSS from external comments.
- Have no access-control role.
- Syndicate content to Telegram.
- Surface Telegram discussion.
- Configure the bot and channels.
- Handle the bot token securely.
- Post announcements.
- Display external comments safely.
- Integrate Telegram.
- Handle Telegram content.
- Configure Telegram integration.
- Cross-post announcements.
