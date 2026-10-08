# Password Strength — manual setup guide

**Password Strength** (`password_strength`) adds a smarter password rule to Drupal's
**Password Policy** system. Instead of the usual rigid checklist ("must contain one capital,
one number, one symbol"), it scores each password from **0 (very weak) to 4 (very strong)**
using the well‑known [zxcvbn](https://github.com/dropbox/zxcvbn) algorithm, and rejects
anything below the minimum score you require. zxcvbn looks at *why* a password is weak —
dictionary words, l33t‑speak ("p@ssw0rd"), keyboard patterns ("qwerty"), sequences
("123456"), repeats, dates and years, and even the user's own name and email — so it blocks
guessable passwords while happily accepting strong passphrases.

The module works as a bridge: it plugs the zxcvbn PHP library into Drupal's **Password
Policy** module and registers one new constraint, **Password Strength**, whose only setting
is the minimum score a password must reach. You add that constraint to a Password Policy and
assign the policy to roles — so you can, for example, demand score 4 from administrators and
score 2 from ordinary members. A separate site‑wide settings form lets you fine‑tune which
zxcvbn "matchers" (the individual weakness detectors) are active.

Password Strength **requires the Password Policy module** (`^3.1 || ^4.0`) and the
`bjeavons/zxcvbn-php` library, both pulled in automatically by Composer. Note that the 2.0
release is a **beta** (`8.x-2.0-beta4`). Enabling the module does nothing on its own until
you add the constraint to a policy — that is the step that turns it on.

This guide is written for a **human** setting up password rules in the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (it brings in Password
   Policy and the zxcvbn library) and enable the module.
2. [Configuration](configuration/index.md) — add the strength constraint to a Password
   Policy, and tune the site‑wide zxcvbn matcher settings.

## Where it lives in the admin menu

There are two places you touch:

- **Configuration → Security → Password Policy**
  (`/admin/config/security/password-policy`) — core Password Policy's screen, where you add
  the **Password Strength** constraint to a policy and set its minimum score.
- **Configuration → Security → Password Strength → Settings**
  (`/admin/config/security/password_strength/settings`) — this module's own settings form,
  where you switch individual zxcvbn matchers on or off for the whole site.
