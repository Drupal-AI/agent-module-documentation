# Registration Confirm Email Address — manual setup guide

**Registration Confirm Email Address** (`reg_confirm_email`) adds a second
"Confirm e-mail address" field to the user registration form and checks that it
matches the first — a simple double-entry safeguard against typos in the address a
new account is created with. Fewer mistyped addresses means fewer failed activation
emails and fewer "I never got the email" support tickets. If you've used
LoginToboggan's email-confirmation feature, this is that one feature packaged as a
tiny standalone module.

It is deliberately minimal. A single checkbox on the core account settings page
turns the confirm field on site-wide, and you can set the help text shown beneath
it. When enabled, the module inserts a required email field immediately after the
standard email field on the register form and adds a validation check that blocks
submission unless the two addresses are identical.

What it does **not** do is just as important to understand: it does not touch account
activation, approval, email verification, one-time login links, or the login flow.
It only enforces that the two typed addresses match before the registration form
submits — there's no token handling or activation bypass to worry about. There are
no permissions, no Drush commands, and no dependencies beyond Drupal core.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — turn the confirm field on and set its
   help text on the account settings page.

## Where it lives in the admin menu

The module has no page of its own. Its two settings live in a **"Confirm email
address"** section it adds to the core account settings form at **Configuration →
People → Account settings** (`/admin/config/people/accounts`). See
[Configuration](configuration/index.md).
