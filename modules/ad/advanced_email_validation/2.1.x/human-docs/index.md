# Advanced Email Validation — manual setup guide

**Advanced Email Validation** (`advanced_email_validation`) rejects unwanted
email addresses on user accounts — and, optionally, on Webform email fields —
before they get in. It is a practical way to cut down spam‑bot signups and keep
your user list clean, using a set of rules you turn on and off independently.

There are four checks, each toggled on its own:

- **MX record lookup** — the address's domain must actually be able to receive
  mail.
- **Disposable** — reject throwaway / temporary email providers.
- **Free** — reject free consumer providers (Gmail, Yahoo, and the like), useful
  on B2B sites that want corporate addresses only.
- **Banned** — reject any domain on a block‑list you maintain (competitors,
  abusive domains, etc.).

Each rule comes with an editable domain list and a friendly, translatable error
message. The disposable and free checks ship with a bundled list from the
underlying `stymiee/email-validator` library, and you can either add to that list
or switch to using *only* your own. You choose whether validation runs on new
account registrations, on email changes to existing accounts, or both. When the
contributed **Webform** module is installed, a Webform handler lets you apply the
same rules to email fields on any form.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent — the validator service, the
entity constraints, and the Webform handler — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (including the
   required validation library) and enable the module.
2. [Configuration](configuration/index.md) — the settings form field by field:
   the four rules, domain lists, error messages, and when validation runs.

## Where it lives in the admin menu

The settings form is at **Configuration → People → Advanced Email Validation**
(`/admin/config/people/advanced-email-validation`). You need the **Administer
advanced email validation** permission to open it.

## How to use it

1. Install and enable the module.
2. Open the settings form and turn on the rules you want (for example MX lookup
   plus disposable).
3. Choose whether to validate on account creation, on email change, or both.
4. Optionally add your own banned domains, and — if you use Webform — add the
   validation handler to a form's email field. Validation then runs
   automatically whenever a matching address is submitted.
