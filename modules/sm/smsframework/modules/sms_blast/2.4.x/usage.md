<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
SMS Blast is a submodule of SMS Framework. It adds one form at `/sms_blast` that sends a single text message to every registered user who has a verified phone number.

---

Where you want to reach your whole membership at once by text — an announcement, an outage notice, an event reminder — SMS Blast provides the simplest possible tool: one message field, one Send button. It looks up every user with a verified phone number (via the framework's phone-number verification records), deduplicates so each person receives one message, and sends through the parent SMS Framework's phone-number provider, meaning the message is queued and delivered by whatever gateway you have configured. Access is gated by the `Send SMS Blast` permission, and users only receive messages if a phone-number field has been bound to the user bundle and confirmed. It has no configuration of its own; all gateway, queue and phone-number setup lives in SMS Framework.

---

- Text an announcement to all registered users.
- Send an outage or maintenance notice by SMS.
- Broadcast an event reminder to your membership.
- Send a one-off promotional message to all users.
- Notify all users of a policy or schedule change.
- Reach every user with a verified phone number at once.
- Send a bulk alert through your configured gateway.
- Restrict bulk-send ability with the Send SMS Blast permission.
- Deliver one message per user (deduplicated).
- Queue a mass SMS for cron-driven delivery.
- Message only users who confirmed their phone number.
- Provide a simple staff tool for site-wide SMS.
- Send a weather or safety warning to all users.
- Push a time-sensitive update to subscribers.
- Follow a bulk email with a bulk SMS.
