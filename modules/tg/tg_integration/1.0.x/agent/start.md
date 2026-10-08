<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Telegram integration — agent index

**Cross-posts content announcements to Telegram** + displays **Telegram comments** on content. Config at
`tg_integration.settings`. Version **1.0.4**. Core `^8.8||^9||^10||^11`.

**Security:** store the Telegram **bot token** as a secret (leak = post-as-your-bot); displayed Telegram
comments are **external user input** — sanitize/escape on output (avoid XSS). No access role.
