# Configuration

E-Mail Username has **no admin settings form and no configuration entity**. It works
as soon as it is enabled. The only settings are two optional validation toggles you
set in `settings.php`.

## The `settings.php` toggles

Both default to **on**. Add these lines to `settings.php` (or your environment‑
specific settings file) to turn the extra checks off where they are unwanted or
unavailable:

```php
// Both default to TRUE. Set to FALSE to skip the corresponding check.
$settings['email_username']['validate_dns']   = FALSE; // skip the MX/DNS lookup
$settings['email_username']['validate_spoof']  = FALSE; // skip the confusable-character check
```

- **`validate_dns`** — when on (and PHP's `intl` extension is present), the module
  performs a DNS (MX) lookup so addresses on domains that can't receive mail are
  rejected. Turn it off on environments without outbound DNS, or where you don't want
  the extra latency.
- **`validate_spoof`** — when on (and `intl` is present), the module runs a
  spoof/confusable‑character check to reject deceptive look‑alike characters. Turn it
  off if it is not wanted.

If the `intl` extension is not loaded, both of these checks are skipped
automatically, and only the RFC‑compliance check runs.

## What the module changes

Even though there's no form, it's worth knowing exactly what the module does so you
can predict its behaviour:

- **On the user form** — the **E-mail** field is made required; the **Username** field
  is disabled, hidden, and no longer required, with its description changed to
  "Username is synchronized with e-mail address". A validate handler copies the
  submitted e-mail into the username.
- **On the account fields** — the core `user.name` field is made optional and has its
  constraints cleared, while `user.mail` is made required and gains a custom `UserMail`
  validation constraint.
- **On every save** — a presave handler re‑copies the e-mail into the username, so
  updates made outside the form (imports, programmatic saves) also stay in sync.
- **On install** — every existing user with an e-mail has their username set to that
  e-mail and is re‑saved.

## The e-mail validation, step by step

The `UserMail` constraint validates account e-mail addresses in this order, with
specific messages:

1. **Empty** → "You must enter a email address."
2. **Contains a space** → "The email address contains invalid characters."
3. **RFC validation** (always runs) — via `egulias/email-validator`.
4. **DNS/MX check** — only if `validate_dns` is on and the environment supports it.
5. **Spoof/confusable check** — only if `validate_spoof` is on and `intl` is loaded.

Specific failures map to clear messages — for example multiple `@` symbols,
consecutive dots, a domain that can't receive mail, or a local/reserved domain each
get their own message; anything else reports "The email address is not valid."

## Login

Authentication is unchanged. Core's login form authenticates against the username
field, which now equals the e-mail address, so users sign in with their e-mail with
no custom login route involved.
