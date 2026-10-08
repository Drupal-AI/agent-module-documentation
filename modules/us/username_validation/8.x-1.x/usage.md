<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Username Validation adds admin-configurable rules to the account-name field on user registration and profile edit: minimum and maximum length, a comma-separated blacklist of forbidden characters and words, and an optional no-spaces rule, with optional live AJAX feedback.

---

The module has no dependencies and ships one settings form at `/admin/config/people/user-name-validation` (permission `access configuration pages`). The rules it stores in `username_validation.usernamevalidationconfig` are: `min_char` / `max_char` (numeric length bounds, admin form clamps max to 1–128), `blacklist_char` (a comma-separated list of single characters *and* whole words that may not appear in the name), and `avoid_spaces` (rejects any whitespace via `preg_match('/\s/')`). There is no regex or Unicode/confusable-character logic — blacklisting is literal substring/word matching done by `_username_validation_search_excludes_in_title()`, so an admin who wants to block a character or word must add it to the list by hand. Enforcement is wired through `hook_form_alter()`, which appends `username_validation_username_validate` to the `#validate` array of `user_register_form` and `user_form` only; the rules are **not** an entity-level constraint, so `User::create()`/`->save()` in code, migrations, and other programmatic paths bypass them entirely. Two cosmetic options relabel (`user_label`) and re-describe (`user_desc`) the name field on those forms, and `skip_existing_username` short-circuits validation when an unchanged existing name is resubmitted. Turning on `ajax_validation` attaches an AJAX change handler that renders the same error messages into a `#username-validation-ajax` div for immediate feedback. Note the shipped default config is empty (`username_validation: null`): until an admin saves the form at least once, `min_char`/`max_char` are unset and length checks are effectively inert. Because the whole feature is form-level, treat it as a UX/data-hygiene aid, not a security boundary.

---

- Require usernames to be at least N characters long.
- Cap username length at a maximum (up to 128).
- Reject usernames containing spaces or other whitespace.
- Blacklist specific characters (e.g. `!`, `@`, `#`) in usernames.
- Blacklist whole reserved words (e.g. `admin`, `root`) in usernames.
- Enforce these rules on the public registration form.
- Enforce the same rules when a user edits their profile name.
- Show validation errors live via AJAX as the user types/changes the field.
- Relabel the "Username" field on the registration form.
- Add a custom description/help text under the username field.
- Reduce low-effort spam registrations that use junk characters.
- Discourage impersonation via obvious lookalike/reserved words you list.
- Keep usernames free of characters that break CSV exports or scripts.
- Enforce a house naming convention on a community site.
- Skip re-validating an existing username that has not changed.
- Reset all module configuration back to unset from the settings form.
- Apply a minimum-length policy without writing any code.
- Provide clearer field guidance to new registrants.
- Block a known bad character/word pattern seen in spam signups.
- Layer lightweight name hygiene on top of core's permissive username rules.
