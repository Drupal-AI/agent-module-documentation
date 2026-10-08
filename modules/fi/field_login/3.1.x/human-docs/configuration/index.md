# Configuration

All of User Field Login's settings live on one form.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → People → Account settings → Field login**, or navigate
   directly to `/admin/config/people/accounts/field-login`.

## The settings, field by field

- **Select login field** — choose which user field's value people may use in place
  of the username when logging in (for example a phone-number or membership-ID
  field). Make sure the field you pick holds **unique** values across all accounts
  and contains no spaces or special symbols, so a login value resolves to exactly
  one account.
- **Override login form** — a checkbox that turns on the wording overrides below.
  Leave it off to keep Drupal's default "Username" label and description; turn it
  on if you want the login form to speak in terms of the field you chose (for
  example "Phone number").
- **Login form username title** — when the override is on, this replaces the title
  of the username field on the login form (for example "Phone number" or
  "Membership ID").
- **Login form username description** — when the override is on, this replaces the
  helper text shown beneath that field.

Click **Save configuration** to apply. From then on, the login form accepts the
configured field's value, still checks the password through core, and still
enforces login flood control.

## Logging in by a "special" field (phone numbers and similar)

Some fields store their value in a compound structure rather than a single plain
string — a phone-number field, for instance, may keep the number in a sub-property.
For those, matching the typed value needs a small amount of code: the module
provides a `hook_field_login()` hook and a `FieldLogin` plugin type so a developer
can define exactly how to query the account UID from the entered value. Plain
single-value fields work through the settings form alone; the hook/plugin route is
only needed for these structured fields. This is a developer task — see the
sibling [`agent/`](../agent/start.md) docs for the hook and plugin signatures.

## A word on security

This module does not lower Drupal's authentication bar — it looks the account up by
your chosen field and then verifies the password with core's own password checker,
and login flood control still applies. To keep it safe in practice: use a
genuinely **unique** login field, and keep login error messages **neutral** so the
form does not reveal whether a given phone number or ID belongs to an account.
