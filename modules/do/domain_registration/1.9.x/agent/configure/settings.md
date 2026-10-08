<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Domain Registration — configuration

## Admin form / access
- Route `domain_registration.admin_form`, path `/admin/config/system/domain_register`
  (also a menu link under System config and a task tab). Form
  `Drupal\domain_registration\Form\DomainRegistrationAdminForm` (a `ConfigFormBase`).
- Permission: `administer domain registration` (`restrict access: TRUE`).

## Settings (config `domain_registration.settings`)
Defaults from `config/install/domain_registration.settings.yml`: `method: 0`, `pattern: ''`,
`message: 'You are not allowed to register for this site.'`.

- **Restriction Type** (`method`, required radios):
  - `0` = `DOMAIN_REGISTRATION_ALLOW` — allow ONLY listed domains to register (default).
  - `1` = `DOMAIN_REGISTRATION_DENY` — prevent listed domains from registering.
- **Email domains** (`pattern`, textarea) — one domain per line. Wildcards:
  `*` = any sequence, `?` = any single char (e.g. `example.com`, `*.example.com`).
- **Error message** (`message`, required textfield) — shown when validation fails
  (set on the `account` element via `setErrorByName`).

## Matching logic (`domain_registration.module`)
- `hook_form_user_register_form_alter()` appends
  `domain_registration_user_register_validate` to the register form's `#validate`.
- The validator: returns early if the `mail` field already has an error; splits the email on
  `@` and takes `$mail[1]` (the domain); loads patterns from the
  `domain_registration.pattern` service; if the list is non-empty, counts matches via
  `domain_registration_wildcard_match()` and:
  - ALLOW: sets the error when there is **no** match.
  - DENY: sets the error when there **is** a match.
- `domain_registration_wildcard_match($pattern, $string)` compiles the pattern to
  `#^ <preg_quote, with \* → .* and \? → .> $#i` — anchored, case-insensitive. So
  `example.com` matches only `example.com`, not `sub.example.com` (use `*.example.com`).
- If `pattern` is empty, `getPatterns()` returns `[]` and NO restriction is applied
  (registration open). Safe default for a fresh install.

## Service
`domain_registration.pattern` → `DomainRegistrationPattern` (implements
`DomainRegistrationPatternInterface`), injected with `config.factory`. `getPatterns()`
reads `domain_registration.settings:pattern` and `explode("\r\n", $domains)` into an array
(returns `[]` when empty). Call it to reuse the configured domain list elsewhere.

## Scope / caveats
- Enforcement is limited to the standard user **registration** form. Users created via the
  admin "Add user" form, migrations, or programmatic `User::create()` are NOT validated.
- Multi-`@` emails: `explode('@', ...)[1]` takes the segment after the first `@`; core email
  validation normally rejects malformed addresses before this runs (early return on `mail`
  errors).
- Newline handling is brittle — patterns are split on `\r\n` only, so config set with `\n`
  newlines collapses into a single unusable pattern.
