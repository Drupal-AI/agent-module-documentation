<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Birthday Wish Mail emails a templated birthday greeting to each active user automatically on their birthday, driven by Drupal cron.

---

Birthday Wish Mail is a small, single-form module that sends an automated birthday email. An admin points it at an existing user **date-of-birth field** (by machine name), writes a **Subject** and a rich-text **Message** template (Token-aware, user tokens supported), and optionally a **BCC** address. On every cron run it looks up active users whose stored DOB matches today's month-and-day, and sends each of them the templated mail in their preferred language. A small dedupe table records what was sent so a given address is not mailed twice on the same day. There is no dashboard, entity, permission, or Drush command — configuration is one admin form gated by *administer site configuration*, and the actual sending is entirely `hook_cron`-driven. It depends only on the Token module.

---

- Send an automatic "Happy Birthday" email to users on their birthday.
- Drive all sending from Drupal cron — no manual trigger or queue.
- Match on the current month-and-day against a configured DOB field.
- Reuse an existing user *date of birth* field by entering its machine name (e.g. `field_date_of_birth`).
- Write a plain-text-safe email **Subject** in the settings form.
- Compose a rich-text (full HTML) email **Message** body with a text-format selector.
- Insert user data into the greeting with Token — e.g. `[user:display-name]`, `[user:account-name]`, `[user:mail]`.
- Include a password-reset link with the module's `[user:one-time-login-url]` token.
- Include an account-cancel link with the module's `[user:cancel-url]` token.
- Send each greeting in the recipient's **preferred language** (config override language is switched per user).
- BCC every birthday mail to a monitoring/admin address.
- Skip users whose account is blocked (only `status = 1` users are mailed).
- Avoid duplicate sends to the same address on the same day via the `birthday_wish_mail` log table.
- Let other modules adjust the recipient list with the `hook_birthday_wish_mail_users_alter()` alter hook.
- Localize the greeting for multilingual sites (integrates with config translation).
- Keep setup minimal: enable the module, add a DOB field to users, fill one form.
- Run entirely server-side so no visitor-facing routes are exposed.
- Use it for HR/community sites that want to acknowledge member birthdays.
- Use it to nudge dormant users with a friendly, personalized touchpoint on their birthday.
- Pair it with any date/datetime user field that stores a value containing the `MM-DD` of the birthday.
- Clean up after itself — the log table is dropped on uninstall.
