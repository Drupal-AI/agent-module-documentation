Better Passwords enforces a minimum length and a minimum zxcvbn strength score on any Drupal `password_confirm` field (registration, user edit, password reset) following NIST guidance, and can auto-generate initial passwords for admin-created accounts.

---

The module is a lightweight password-policy layer built entirely around core's `password_confirm` render element. Via `hook_element_info_alter()` it attaches an `#after_build` callback to every `password_confirm` field, which appends a description of the active rules and prepends `better_passwords_validate()` to the element's validators so it runs before core's own checks. Validation enforces two rules from one config object (`better_passwords.settings`): a **minimum length** (`length`, default 8) and a **minimum strength** (`strength`, default 3) checked with the [zxcvbn-php](https://github.com/bjeavons/zxcvbn-php/) library, which scores a password 0–4 against brute-force cost, dates, years, repeats, sequences, keyboard-adjacency, and English dictionaries — feeding the user's name and email in as extra dictionary words. A failing password produces a "Please choose a stronger password" error with a per-weakness bulleted list. The third setting, `auto_generate`, controls whether admin-created accounts (the `user_register_form` submitted by an authenticated user) get a generated 64-character password: `0` Never, `1` Optional (adds an "Auto-generate password" checkbox), `2` Required (hides the password fields). Everything is administered at `/admin/config/people/passwords` behind the `administer better passwords` permission; there are no plugins, no Drush commands, and no field types.

---

- Require passwords of at least 8 characters site-wide to meet the NIST 800-63B minimum.
- Raise the minimum length above 8 (e.g. 12 or 16) for a higher-security site.
- Reject weak passwords by requiring a minimum zxcvbn strength score (0–4).
- Block passwords that match a common-password dictionary entry.
- Block passwords that are wholly numeric (e.g. a PIN or a phone number).
- Block passwords that are just a date or a year.
- Block sequential passwords like `abcdef` or `123456`.
- Block keyboard-adjacent passwords like `qwerty` or `asdfgh`.
- Block repetitive passwords like `aaaaaa`.
- Prevent users from choosing a password that contains their own username or email address.
- Show users the active rules ("Passwords must be at least N characters", "Passwords will be rated for their strength") right under the password field.
- Give editors granular, per-weakness feedback on why a password was rejected.
- Turn strength checking off entirely (strength `0`) while still enforcing a length minimum.
- Enforce only strength while leaving length unset for a softer policy.
- Auto-generate a strong 64-character initial password for accounts admins create.
- Offer admins an optional "Auto-generate password" checkbox on the user-register form.
- Require auto-generation (hide the password fields) so admins never hand-pick weak initial passwords.
- Apply the same policy consistently across registration, user-edit, and one-time-login password forms.
- Meet a compliance requirement to compare new passwords against known-compromised/common lists.
- Strengthen an existing site's password hygiene without writing custom validation code.
- Export the policy (`length`, `strength`, `auto_generate`) as config for repeatable deployment across environments.
- Delegate password-policy administration to a role via the `administer better passwords` permission.
- Layer alongside core's password features without replacing the login or account system.
