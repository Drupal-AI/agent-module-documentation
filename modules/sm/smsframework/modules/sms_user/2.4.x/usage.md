<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
SMS User is a submodule of SMS Framework that ties SMS to Drupal user accounts: it can hold automated messages until a user's "active hours", and can create user accounts from inbound SMS.

---

SMS User adds two user-facing behaviours on top of SMS Framework. Active hours lets you define allowed time windows (per the user's timezone) so that automated outgoing messages queued outside those hours are rescheduled to the next window rather than waking people at night. Account registration lets an inbound SMS create a Drupal user: either for any sender number that isn't already linked to a user, or when the message body matches a configurable pattern with `[username]`, `[email]` and `[password]` placeholders; optional reply messages and the core activation email round out the flow. Both are configured at `/admin/config/smsframework/user` and are off by default, and both build on the parent framework's phone-number model and inbound-message handling — account creation requires phone-number settings on the user bundle and only runs for messages received through a gateway. It defines no permissions of its own.

---

- Hold automated SMS until a user's waking hours.
- Define per-day active-hours windows for messaging.
- Respect each user's timezone when scheduling SMS.
- Reschedule night-time messages to the morning.
- Create a user account from an inbound SMS.
- Register any unknown sender number as a new user.
- Create accounts by matching an SMS message pattern.
- Extract username/email/password from an inbound text.
- Send an activation email after SMS registration.
- Reply to a new registrant with their credentials.
- Bind a sender's phone number to the created account.
- Let users onboard by texting the site.
- Avoid messaging users outside allowed hours.
- Integrate SMS Framework with Drupal user accounts.
- Delay queued automated messages by active hours.
