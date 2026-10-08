# Configuration

All of the module's behaviour is set on one settings form. The goal is to turn the
protection on for both vulnerable forms and to provide the neutral messages users
will see.

## Open the settings form

1. Log in as a user with the permission to administer EEP (an administrator by
   default).
2. Go to **Configuration → EEP settings** (`eep.settings`).

## The settings, field by field

### Password-reset form

- **Enable prevention on the reset-password form** — when on, EEP normalises the
  form's response so it no longer reveals whether the submitted email/username
  belongs to an account.
- **Custom message for reset-password attempts** — the neutral message shown after
  a reset request, regardless of whether the account exists. Write it so it reads
  correctly in both cases (for example, "If an account matches, we've sent a reset
  link"). Tokens are available here via the Token module.

### Registration form

- **Enable prevention on the register-new-user form** — when on, EEP normalises the
  registration form's response so it no longer reveals that an email address is
  already registered.
- **Custom email subject** and **custom email body** — when someone tries to
  register with an email address that already exists, instead of the form revealing
  the collision, EEP can send an email to that address. These two fields set the
  subject and body of that message (Token support available), so a legitimate owner
  is informed while an attacker at the form sees only the same neutral outcome.

## Save

Click **Save configuration**. Enable protection on **both** the reset-password and
registration forms — leaving one on and one off still leaves an enumeration oracle
open.

## Grant the permission

EEP defines its own permission. Review it at **People → Permissions**
(`/admin/people/permissions`) and grant it to the appropriate role(s).

## Test it

From a logged-out browser, submit the password-reset form once with a known
address and once with an address that has no account — the response should be
identical. Do the same on the registration form with an existing email and a fresh
one. If either pair of responses still differs, re-check that prevention is enabled
for that form.
