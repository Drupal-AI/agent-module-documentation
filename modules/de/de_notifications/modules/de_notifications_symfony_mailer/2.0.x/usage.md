<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Delivers Decoupled Entity Notifications as email via Symfony Mailer.

---

Decoupled Notifications Symfony Mailer (DENSM) is the bundled email delivery channel for the
Decoupled Entity Notifications (DEN) module. It provides a `notification_type` plugin with id
`symfony_mail`; once selected in DEN's settings, every DEN notification kind — confirm, subscription
confirmed, already subscribed, entity notification, subscription overview and archived — is composed
and sent as a Symfony Mailer typed email. A Symfony Mailer `EmailBuilder` (`de_notifications_mailer`)
declares the six sub-types, and default mailer policies (subject/body) ship as install config so you
can theme each message. Front-end confirm/unsubscribe/overview URLs and entity links are supplied by
DEN's context service. Requires the Symfony Mailer contrib module and the parent DEN module.

---

- Deliver DEN notifications as email.
- Provide the `symfony_mail` notification type for DEN's settings.
- Send double opt-in confirmation emails with a tokenized confirm link.
- Send "subscription confirmed" emails after opt-in.
- Send "already subscribed" emails on a duplicate subscribe attempt.
- Send entity-update notification emails with the change description and entity link.
- Send "archived" emails when a subscribed entity is unpublished.
- Email a subscriber an overview of their active subscriptions.
- Include unsubscribe and unsubscribe-all links in every email.
- Include a request-subscription-overview link in every email.
- Localize each email to the subscribed entity's language.
- Theme subject and body per notification kind via Symfony Mailer policies.
- Extend or override the shipped mailer policies in your own config.
- Serve as the reference implementation for writing other notification channels.
