# E-Mail Username — configuration & validation

No admin form and no config entity. The only configuration is in `settings.php`:

```php
// Both default to TRUE. Turn off the extra checks where needed.
$settings['email_username']['validate_dns']   = FALSE; // skip MX/DNS lookup
$settings['email_username']['validate_spoof']  = FALSE; // skip confusable-char check
```

Read by `UserMailConstraintValidator::shouldRunValidation()` (`Settings::get('email_username', …)`).

## What the module changes
- **User form** (`form_user_form_alter`): *E-mail* `#required = TRUE`; *Username* is
  `#disabled`, `#required = FALSE`, `#validated = TRUE`, description set to "Username is
  synchronized with e-mail address". A validate handler
  (`UserFormHooks::userFormValidate`) is prepended to `#validate` and copies
  `mail` → `name`.
- **Base fields** (`entity_base_field_info_alter`, user only): `name` set non-required with
  its constraints cleared; `mail` set required and gains the `UserMail` constraint.
- **Presave** (`user_presave`): if `mail` is non-empty, `name` is set to `mail` — also covers
  updates made outside the form (imports, programmatic saves).
- **Install** (`hook_install`): every existing user with an e-mail has `name` set to that
  e-mail and is re-saved.

## The `UserMail` constraint (`Plugin/Validation/Constraint/UserMail*`)
Validation order and messages:
1. Empty value → "You must enter a email address."
2. Contains a space → "The email address contains invalid characters."
3. `RFCValidation` (always) — via `egulias/email-validator`.
4. `DNSCheckValidation` — only if `validate_dns` and `idn_to_ascii()` exists.
5. `SpoofCheckValidation` — only if `validate_spoof` and the `intl` extension is loaded.

Egulias error codes are mapped to specific messages: multiple `@` (128), consecutive dots
(132), unable-to-receive/DNS (3/5/154 → "…seems to be unable to receive email messages"),
local/reserved domain (153), other → "The email address is not valid." If `intl` is missing,
the DNS and spoof checks are silently skipped (RFC still runs).

## Notes
- Authentication is unchanged: core's login form authenticates by the `name` field, which now
  equals the e-mail — no custom login route is added.
- Because `mail` overwrites `name` on every save, any username set elsewhere is not preserved.
