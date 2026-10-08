<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Unified Mail Dispatcher (unified_mail_dispatcher) — agent index

Alters the Drupal mail system to **redirect ALL outgoing mail to Discord (webhook) or a single email**.
Version **1.x**. Core `^10 || ^11`.

**Security (significant):** it redirects **every** site email — incl. **password-reset links**,
account notifications, order confirmations — to the configured Discord webhook / single inbox. The
webhook URL is a **secret**; the destination now holds all mail content (use a trusted private
channel). On **production** this means real users **don't get their mail** — it belongs in dev/staging
or a deliberate notification setup, not a normal production site.