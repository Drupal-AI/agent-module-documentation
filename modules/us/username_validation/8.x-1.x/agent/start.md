<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Username Validation (username_validation) — agent index

**Admin-configurable rules on the account-name field of the user registration and profile-edit forms: min/max length, a comma-separated blacklist of characters and words, and an optional no-spaces rule, with optional live AJAX feedback.**

- **Version:** 8.x-1.x (info.yml: 8.x-1.4) · **Core:** `^9.3 || ^10 || ^11` · **Depends:** none · **Package:** Other
- **Config route:** `username_validation.username_validation_config` — `/admin/config/people/user-name-validation`, permission `access configuration pages` (restrict access: true), `_admin_route`. Menu link under `user.admin_index`.
- **Permissions:** provides `access configuration pages` (title "Username validation config page access", restrict access: true) — the only gate on the settings form.
- **Config object:** `username_validation.usernamevalidationconfig`. Keys: `min_char`, `max_char`, `blacklist_char`, `avoid_spaces`, `ajax_validation`, `user_label`, `user_desc`, `skip_existing_username`. **No config schema is shipped** (only `config/install`, whose default is empty: `username_validation: null`) — until an admin saves the form, length keys are unset and length checks are inert.

## Mechanism (read the source, not the project page)
- **Form-level only.** `hook_form_alter()` (in `username_validation.module`) appends `username_validation_username_validate` to `#validate` on `user_register_form` and `user_form`. There is **no** entity Constraint/Validator — `User::create()->save()`, migrations, and any other programmatic path bypass every rule.
- **Rules** enforced in `username_validation_username_validate()`:
  - Length: `strlen($username) < min_char` / `> max_char` (byte length, not multibyte).
  - Blacklist: `blacklist_char` is split on commas; `_username_validation_search_excludes_in_title()` does **literal** matching — single-char entries via `strpos`, multi-char entries as comma-split whole "words". No regex, no Unicode/confusable logic. Blacklist is only checked when the submitted name differs from the stored one (`$name->name != $username`).
  - Spaces: `avoid_spaces` rejects any whitespace via a hardcoded `preg_match('/\s/', $username)` (pattern is fixed, not admin-supplied).
- **Cosmetic:** `user_label` overrides the field `#title`, `user_desc` overrides `#description` on those two forms.
- **skip_existing_username:** if the resubmitted name equals the DB value, validation is skipped. The stored name is fetched by `username_validation_get_username_from_db()`, which parses the current path (`explode('/', path)[2]`) as the uid — reliable on `/user/{uid}/edit`, meaningless on `/user/register` (returns no row).
- **AJAX (optional):** `ajax_validation` attaches an AJAX handler on the field's `change` event; `username_validation_ajax()` re-runs the same checks and injects error markup into a `#username-validation-ajax` div.

## Security
Form-level validation is a UX/data-hygiene aid, **not a security boundary** (programmatic paths bypass it). Config form is gated by a dedicated restrict-access permission. The only admin-supplied `preg_*` input is not exposed (spaces pattern is hardcoded), so no ReDoS/pattern-injection. See the private security notes if present alongside this doc; nothing here is anonymous-facing or a privilege issue.

See [configure/setup.md](configure/setup.md).
