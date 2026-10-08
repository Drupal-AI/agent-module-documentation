<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Notification System Dispatch Mail delivers a user's notifications by email using Twig subject and body templates.

---

This is the email channel for the dispatch framework. It registers a single `mail` dispatcher plugin; when the dispatch pipeline decides a user should be emailed, the plugin sends to that user's account address through the Drupal mail system. The subject and body are not hard-coded — an administrator writes Twig templates for both, with a `notifications` variable exposing each notification's title, body, timestamp and link, so the same channel can render either a single-notification email or a bundled summary with a loop. Rendering happens in `hook_mail`, the from-address comes from the site email, and if the swiftmailer module is installed the message is marked as HTML. The mail dispatcher's settings appear inside the main dispatch settings form and are config-translatable.

---

- Email a user their notifications as they arrive.
- Send a daily or weekly digest email of bundled notifications.
- Customise the email subject with a Twig template.
- Customise the email body with a Twig template and a notifications loop.
- Show each notification's title, body, timestamp and link in the email.
- Send a single-notification email when only one is pending.
- Let users opt out of the email channel via their preferences.
- Route only chosen notification groups to email per user.
- Use the site's configured mail system and from-address.
- Send HTML email when swiftmailer is enabled.
- Translate the mail subject and body templates per language.
- Add email as one of several channels a notification reaches.
- Skip users who have no email address on their account.
- Reach users who rarely log in through their inbox instead.
- Combine with web push so critical items go out both ways.
