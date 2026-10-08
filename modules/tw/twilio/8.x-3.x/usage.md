<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Twilio integrates the Twilio cloud communication service, sending SMS from Drupal and letting users register and verify a mobile number against their account.

---

Sending SMS from a site covers a lot of ground — order notifications, appointment reminders, alerts to an on-call rota, a second factor at login — and Twilio is the default choice of provider. This module supplies the account settings, a test-send form, a per-user phone verification flow and a message log. Version is **8.x-3.0-alpha17**, which is where the caution starts: an alpha released in **2024**, with a core requirement of `^8 || ^9 || ^10 || ^11` that spans four majors and therefore tells you little about what is actually tested. Two things need weighing before it goes on a site. **Credentials**: the Twilio account SID and auth token are held in configuration, and an auth token is a live billable credential — put it in an environment variable and reference it through a Key entity rather than letting it sit in an exported config file. **The per-user verification route is not owner-checked**: `/user/{user}/edit/twilio` is gated only by the non-restricted `access twilio` permission, with no check that the `{user}` in the path is the person browsing — verified on a clean install, one ordinary account read another's confirmed mobile number and deleted its verification record. Treat `access twilio` as effectively site-wide over everyone's phone data until that route carries `_entity_access: 'user.update'`.

---

- Send an SMS notification from Drupal.
- Alert an on-call rota by text.
- Send an order confirmation by SMS.
- Verify a user's mobile number.
- Send appointment reminders.
- Notify an editor of new content.
- Send a one-time code by SMS.
- Test SMS delivery from the admin UI.
- Log outgoing messages.
- Send a delivery notification.
- Reach users without email.
- Send an emergency broadcast.
- Confirm a phone number at registration.
- Integrate an existing Twilio account.
- Send a password-reset code.
- Notify a customer of a status change.
- Support an SMS-based workflow.
- Send a reminder before an event.
