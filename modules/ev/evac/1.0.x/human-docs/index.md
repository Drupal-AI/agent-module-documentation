# Email Validator Customizer — manual setup guide

**Email Validator Customizer** (`evac`) makes Drupal's email validation stricter.
Drupal core checks emails with a basic RFC rule that even accepts addresses with no
real domain. This module exposes the extra validators from the `egulias/email-validator`
library as Drupal services and can transparently **replace** core's email validator,
so stronger rules — for example requiring a domain that actually resolves and has MX
records — apply everywhere Drupal validates an email: user registration, contact
forms, webforms, and any custom code that uses the shared validator service.

Because it swaps the core service rather than editing individual forms, the stricter
validation takes effect site-wide with no per-form changes. You choose how strict to
be from a single settings page: turn the replacement on or off, pick which validation
replaces core (DNS check, spoof check, Message-ID, no-RFC-warnings, or a combination
that must all pass), and optionally log why addresses were rejected. If you'd rather
leave core untouched, you can disable the replacement and still call the individual
validator services directly from your own code.

The available validators are DNS check (default replacement — requires a real domain
with MX records), spoof check (detects confusable/homograph characters, needs PHP's
`intl` extension), Message-ID, no-RFC-warnings, and "multiple with AND" (several
validations that must all pass).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (it pulls in the
   egulias library) and enable the module.
2. [Configuration](configuration/index.md) — the settings form, field by field.

## Where it lives in the admin menu

The settings form is at **Configuration → Email Validator Customizer**
(`/admin/config/evac`), gated by the restricted *administer evac configuration*
permission.

## How to use it

For most sites, enabling the module is enough: it turns on the DNS-check replacement
by default, so emails must have a resolvable domain. To change how strict it is, open
the settings form and pick a different replacement (or combination). After enabling
or changing the module, rebuild the cache (`drush cr`) so the core service swap takes
effect. To call a specific validator from custom code instead:

```php
$ok = \Drupal::service('email.validator.dns_check')->isValid('user@example.com');
```

Note: do **not** pass a second argument to `isValid()` — these validators throw an
exception if you do (matching core's direction).
