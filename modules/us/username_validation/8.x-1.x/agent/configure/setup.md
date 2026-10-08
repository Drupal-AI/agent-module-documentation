<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring Username Validation

All settings live on one form: `/admin/config/people/user-name-validation` (route `username_validation.username_validation_config`, permission **access configuration pages**, restrict access). Values are saved into the config object `username_validation.usernamevalidationconfig`. There is no config schema, so no per-key typing/translation is provided.

## Fieldset "Username condition" (`username_validation_rule`)
- **Blacklist Characters/Words** (`blacklist_char`, textarea) — comma-separated. Each entry is matched **literally**: a single-character entry is rejected if it appears anywhere in the name (`strpos`); a multi-character entry is treated as a whole comma-delimited "word". Example: `!,@,#,$,%,admin,root`. There is no regex support and no wildcard.
- **Minimum characters** (`min_char`, required) — form requires numeric and `>= 1`.
- **Maximum characters** (`max_char`, required) — form requires numeric and `1 <= max <= 128`, and `min <= max`. Length is compared with `strlen()` (bytes), so multibyte names count each byte.
- **Avoid spaces** (`avoid_spaces`, checkbox) — rejects any whitespace (`preg_match('/\s/')`).
- **Enable Ajax Validation** (`ajax_validation`, checkbox) — adds a live check on the field's `change` event that renders the same errors into an inline `#username-validation-ajax` div. Purely additive; the server-side `#validate` handler always runs regardless.

## Fieldset "Username Configuration" (`username_validation_config`)
- **Username Label** (`user_label`) — replaces the "Username" field `#title` on the register/edit forms.
- **Username description** (`user_desc`) — sets the field `#description`.
- **Skip validation for existing usernames** (`skip_existing_username`, checkbox) — when the submitted name equals the currently stored name, skip all rules. Prevents legacy names (that predate a newly added rule) from blocking an unrelated profile save.

## Reset
The **Reset Configuration** button (`::clearConfiguration`) deletes the entire config object. After a reset (or on a fresh install before the form is first saved) the config is empty, so `min_char`/`max_char` are unset and length validation does nothing until you save the form again.

## Scope / caveats
- Rules apply to `user_register_form` and `user_form` only. Bulk imports, migrations, `drush user:create`, and any `User` entity saved in code are **not** validated.
- Rules apply going forward; existing accounts violating a new rule are not migrated. Use **Skip validation for existing usernames** so those users can still edit their profiles.
