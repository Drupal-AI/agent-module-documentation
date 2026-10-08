SMS Blast adds a simple form to broadcast one text message to every user who has a verified phone number.

---

Enabling the module exposes the route `sms_blast.blast` at `/sms_blast`, gated by the `Send SMS Blast` permission. `SmsBlastForm` shows a single message textarea; on submit it queries the `sms_phone_number_verification` entities with `status = 1` and `entity__target_type = user` (i.e. users with a verified number), de-duplicates by user, and calls `PhoneNumberProvider::sendMessage()` (service `sms.phone_number`) for each, reporting how many messages were sent or failed. It has no configuration, no schema, and relies entirely on SMS Framework's phone-number verification data and the configured gateway.

---

- Send an announcement text to all users with a verified phone number.
- Broadcast an outage or emergency notice by SMS.
- Send an event reminder to your whole verified-user base.
- Send a marketing/opt-in message to verified users (subject to consent).
- Reuse SMS Framework's verified-number data without writing code.
- Restrict who can broadcast via the `Send SMS Blast` permission.
- Queue mass sends through the configured (or fallback) gateway.
- Get a success/failure count after a blast.
- Send one-off notifications to members from an admin form.
- De-duplicate so each user gets a single message even with multiple numbers.
- Test bulk delivery quickly using the `log` gateway.
- Combine with a real gateway for production SMS broadcasts.
- Notify verified users of a new feature or policy change.
- Trigger a manual re-verification reminder campaign.
- Send time-sensitive alerts to opted-in users.
