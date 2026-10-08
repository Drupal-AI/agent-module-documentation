<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
ECA Twilio Action adds a single configurable ECA action, "Send Twilio SMS", so ECA models can send text messages through the Twilio module as part of any event/condition/action workflow.

---

The action (`SendTwilioSms`, plugin id `send_twilio_sms`) extends ECA's `ConfigurableActionBase` and injects the `twilio.sms` service and a logger. Its configuration form exposes a Phone Number field and a Message textarea, both flagged for ECA token replacement. At execution time it runs the ECA token service (`replaceClear`) over both values, `html_entity_decode()`s the message, and calls `twilio.sms->messageSend($phone_number, $decoded_message)`, logging success or catching and logging any exception. Delivery, credentials, and the Twilio REST client all come from the separate Twilio contrib module.

Because it is an ECA action, it has no routes or permissions of its own — it is only invokable from within ECA models, whose editing is itself an administrative capability. Configure Twilio (account SID, auth token, from-number) in the Twilio module, then drop the "Send Twilio SMS" action into an ECA model and template the number/message with tokens from the triggering context.

---

- Send an SMS from any ECA model as an action step.
- Notify a user by text when content is published/updated.
- Alert an admin's phone when a form is submitted.
- Template the recipient number with a token from the triggering entity.
- Template the message body with tokens (fields, user, site data).
- Send order/booking confirmations via SMS from a workflow.
- Trigger SMS on entity CRUD, cron, or any ECA event.
- Send OTP-style or reminder messages driven by business rules.
- Reuse existing Twilio module credentials and from-number.
- Log delivery attempts to the `eca_twilio_action` channel.
- Continue an ECA model even if sending fails (errors are caught/logged).
- Decode HTML entities in the message before sending.
- Combine with ECA conditions to send only when criteria are met.
- Send to multiple recipients by chaining/iterating actions in the model.
- Build SMS notification flows entirely in the ECA UI, no code.