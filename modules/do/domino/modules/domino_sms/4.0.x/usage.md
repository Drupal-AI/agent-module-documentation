<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Domino SMS displays outgoing SMS messages as Drupal messages instead of sending them, so SMS flows can be tested on non-production environments without a live gateway.

---

Domino SMS is a submodule of Domino and the SMS equivalent of Domino's "display emails as Drupal messages" feature. It subscribes to the SMS Framework (`sms`) pre-process event (`SmsEvents::MESSAGE_PRE_PROCESS`) via `DominoSmsSubscriber`. When Domino's `application_mode` is not `production` and the `domino_sms.settings` flag `display_sms_as_messages` is on (default `1` on install), the subscriber takes every message about to be sent, wraps any six-digit sequence in a `<span class="otp-code">` (so one-time passcodes stand out), adds the text as a Drupal status message, and then clears the event's message list so nothing is actually dispatched to the SMS gateway. On production, or when the flag is off, it does nothing and SMS is sent normally. The submodule ships only `config/install/domino_sms.settings.yml` (single key `display_sms_as_messages`), has no config schema, no admin UI, no routes, and stores or reads no gateway credentials of its own — those belong to the SMS Framework gateway you configure. It requires the `domino` and `sms` (SMS Framework) modules.

---

- Test SMS-sending flows (e.g. OTP login, notifications) in development/staging without a live SMS gateway.
- Read the exact SMS body on screen during manual QA instead of on a phone.
- Verify one-time passcodes in automated tests — 6-digit codes are highlighted with an `otp-code` span.
- Avoid incurring SMS costs while developing SMS features.
- Prevent development/staging environments from sending real SMS to real numbers.
- Combine with Domino's email-as-messages feature for full message QA coverage in non-production.
- Enable it only where needed: `drush en domino_sms -y` alongside Domino and SMS Framework.
- Toggle behaviour with `$config['domino_sms.settings']['display_sms_as_messages']` per environment.
- Keep production SMS delivery untouched (the feature short-circuits when `application_mode` is `production`).
- Style the highlighted OTP codes in your theme via the `.otp-code` CSS class.
- Use it as the SMS test harness behind acceptance tests that assert on message content.
- Rely on it needing no gateway API key of its own — it never contacts an SMS provider.
