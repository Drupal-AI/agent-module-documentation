# Password Core Validator — manual setup guide

**Password Core Validator** (`pcv`) adds configurable **password-strength rules** to
Drupal's built-in password fields. It is a lightweight, core-only password policy:
when a user sets a password, the module checks it against the rules you have turned
on — minimum length, and whether it must contain lowercase letters, uppercase
letters, numbers, and punctuation — and blocks the form until the password
satisfies them. It also feeds hints into Drupal's native password strength meter so
users get live guidance as they type.

Because the checks run on the **core password element** (`password_confirm`), they
apply everywhere that element appears: user registration, the "edit account" form,
and admin-created accounts. Each rule is independently toggleable and carries its
own customizable error message, so you can tune the policy to your site's needs
without a heavier password-policy framework.

You can also **exempt specific roles** from the rules — handy if, say, you want to
enforce strong passwords for regular members but not for a legacy service account
role. (Keep in mind that exempting a role genuinely skips the checks for those
users, so use it deliberately.)

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.
2. [Configuration](configuration/index.md) — turn on the rules you want, set the
   thresholds and messages, and choose exempt roles.

## Where it lives in the admin menu

The settings form is at **`/admin/config/people/pcv`** (route `pcv.settings.form`),
gated by the **Administer site configuration** permission.
