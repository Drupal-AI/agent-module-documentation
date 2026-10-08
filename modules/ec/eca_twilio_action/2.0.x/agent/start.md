<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ECA Twilio Action (eca_twilio_action) — agent index

**An ECA action plugin that sends an SMS via the Twilio module, with token replacement in the number and message.**

- **Version:** 2.0.x
- **Core:** ^10.3 || ^11
- **Requires:** eca, twilio, token
- **Action plugin:** `send_twilio_sms` — "Send Twilio SMS" (Drupal\eca_twilio_action\Plugin\Action\SendTwilioSms)
- **Config:** `phone_number`, `message` (both ECA token-replaceable)
- **Service used:** `twilio.sms` (messageSend); logs to the `eca_twilio_action` channel

**Security:** No routes or permissions of its own; usable only inside ECA models (an admin-level capability). Twilio credentials live in the Twilio module. The message is `html_entity_decode()`d before sending; both fields are token-replaced from the triggering context, so ECA model authors control the content.

See [plugins/eca_twilio_action.md](plugins/eca_twilio_action.md)