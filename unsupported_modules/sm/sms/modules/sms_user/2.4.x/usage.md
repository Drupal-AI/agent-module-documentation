SMS User integrates SMS Framework with Drupal users: it can delay outgoing messages to configured "active hours" and can create Drupal accounts from incoming SMS messages.

---

Settings live at `/admin/config/smsframework/user` (route `sms_user.options`, permission `administer smsframework`), stored in `sms_user.settings`. Two feature areas: **Active hours** — an on/off toggle plus a list of start/end ranges (expressed in PHP `strtotime` natural language) that the `ActiveHours` service uses (via `hook_entity_presave` on SMS message entities) to delay outgoing messages until the next allowed window. **Account registration** — reacts to incoming messages through an event subscriber (`SmsEventSubscriber`) and the `AccountRegistration` service to create user accounts, either for any unrecognized sender number or by matching configurable incoming-message patterns (e.g. `E [email]` / `U [username]`), optionally sending an activation email and/or an SMS reply. Both features are **disabled by default** (`status: false`). The module also rebuilds dynamic user menu links when `user.user` phone-number settings are added. Account creation is only as trustworthy as the inbound channel: it is driven by messages arriving on a gateway's (module-authenticated) incoming route.

---

- Delay non-urgent SMS so they are not sent during users' sleeping hours.
- Define multiple allowed send windows via natural-language time ranges.
- Automatically queue outgoing messages until the next active-hours window.
- Create a Drupal account when an SMS arrives from an unrecognized number.
- Create accounts by parsing incoming message patterns for email/username.
- Send an activation email when a new account is created from SMS.
- Send an SMS reply confirming (or reporting failure of) account creation.
- Associate a verified phone number with a user account.
- Build SMS-first onboarding for users without email.
- Reply to inbound messages with a templated confirmation.
- Keep user-facing SMS within business hours.
- Integrate phone verification into the user profile.
- Rebuild user phone-number menu links automatically.
- Toggle each feature independently (both off by default).
- Support membership flows where the phone is the primary identifier.
