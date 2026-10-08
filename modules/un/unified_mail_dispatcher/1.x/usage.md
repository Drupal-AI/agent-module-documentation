<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Unified Mail Dispatcher alters the Drupal mail system so all outgoing mail is redirected — either to a Discord channel via webhook, or to a single email address instead of the real recipients.

---

Redirecting all mail to one place is useful for development/staging (so test emails do not reach real users) and for small-team notification (routing site emails into a Discord channel the team watches). This module provides that redirect.

Because it redirects ALL mail, the security consideration is significant: every email the site would send — including password-reset links, account notifications, order confirmations and anything else containing sensitive or actionable content — now goes to the configured Discord webhook or single inbox instead of the intended recipient. Two things follow. First, the Discord webhook URL is a secret (anyone with it can post to the channel) and the destination now holds the content of every site email, so it must be a trusted, private channel/inbox. Second, on a production site this redirect means real users do not receive their mail (password resets, confirmations) — so it belongs in development/staging, or in a deliberately-chosen notification setup where redirecting mail is the intent, not on a normal production site expecting users to get their emails.

---
- Redirect all mail to Discord.
- Send site emails to one inbox.
- Catch test emails in development.
- Avoid emailing real users on staging.
- Route notifications to a Discord channel.
- Keep the Discord webhook secret.
- Use a trusted private destination.
- Understand password-reset links are redirected too.
- Keep it out of production (users need their mail).
- Use for dev/staging mail catching.
- Watch site emails in Discord.
- Treat the destination as holding all mail content.
- Configure a single-email redirect.
- Confirm the redirect intent.
- Avoid leaking sensitive mail content.
- Route mail deliberately.