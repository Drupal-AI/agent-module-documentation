<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Push Framework Email adds an "email" delivery channel to the Push Framework, sending each framework notification as an email to the recipient user's own address.

---

The Push Framework (`push_framework`) abstracts the delivery of user notifications over pluggable channels. Push Framework Email is the email channel: it provides a `ChannelPlugin` with id `email` that, for each targeted user, hands the already-rendered notification (subject, body, and an HTML/plain flag) to Drupal's mail manager (`plugin.manager.mail`) and mails it to that user's account email via `hook_mail()`. HTML messages are wrapped in a minimal HTML document with a `<base href>` pointing at the site root so relative links resolve. The channel is toggled and defaulted through a settings form at `/admin/config/system/push_framework/email`, which extends the framework's own channel settings form and writes the `pf_email.settings` config object (`active`, `use_default_settings`). Recipients are always the framework's chosen users' registered email addresses; there is no arbitrary-address entry, no external mail API, and no message composition UI of its own — content comes from the framework's notification templates.

---

- Deliver Push Framework notifications to users by email.
- Register email as a selectable delivery channel alongside other pf_* channels.
- Send DANSE / Push Framework subscription notifications to subscribers' inboxes.
- Notify a user by email when content they follow changes (via the framework).
- Send plain-text notification emails to users' account addresses.
- Send HTML notification emails wrapped in a proper HTML document.
- Have relative links in HTML notifications resolve against the site root via `<base href>`.
- Respect each user's preferred language when picking the notification content variant.
- Fall back to the first available language when a user's preferred language has no content.
- Turn the email channel on or off site-wide from the framework's channel settings.
- Choose whether the email channel uses the framework's default per-notification settings.
- Combine the email channel with other channels (Mattermost, Twilio, OneSignal, Alerta) so users get notified over several transports.
- Route all notification email through your site's configured mail transport (SMTP, Symfony Mailer, etc.).
- Localize notification subjects/bodies per recipient through the framework's templates.
- Add email delivery to a custom Push Framework notification without writing a channel.
- Report per-user send success/failure back to the framework for retry accounting.
- Provide a Push package channel that only administrators with "administer site configuration" can configure.
- Use as a reference implementation for building additional Push Framework channels.
