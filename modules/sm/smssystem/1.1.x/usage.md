<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
SMS System is a tool with an API used for sending SMS using event triggering.

---

SMS System provides an API and tooling for sending SMS messages — sending texts triggered by events
(e.g. on content publish, order status, or custom events), integrating with an SMS gateway. It depends on
Date Popup and provides its own permissions.

Use it to send event-triggered SMS from Drupal. The security-relevant points: it authenticates to an SMS
gateway with credentials — store them as secrets; SMS sends money/cost per message, so ensure event
triggers can't be abused to send mass/unwanted SMS (a spam/cost-abuse vector if a public action triggers
sends); and recipient phone numbers are personal data — handle with consent/privacy. It is an integration/
messaging feature with no access-control role. Configure the SMS gateway and event triggers carefully.

---

- Send SMS from Drupal.
- Trigger SMS on events.
- Integrate an SMS gateway.
- Depend on Date Popup.
- Provide its own permissions.
- Store gateway credentials as secrets.
- Prevent SMS spam/cost abuse.
- Guard event triggers from abuse.
- Handle phone numbers as personal data.
- Obtain consent for SMS.
- Have no access-control role.
- Configure the gateway.
- Send event-triggered texts.
- Configure event triggers.
- Send transactional SMS.
- Handle credentials securely.
- Send text messages.
- Configure SMS sending.
- Trigger texts.
- Send SMS via API.
