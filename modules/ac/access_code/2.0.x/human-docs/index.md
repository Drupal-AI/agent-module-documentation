# Access code — manual setup guide

**Access code** (`access_code`) provides an alternative way for users to log in:
instead of (or in addition to) a username and password, a user authenticates with
an **access code**. It is handy for scenarios like event access or a simplified
login flow where handing someone a code is easier than issuing full credentials.

The module builds on core's User system and adds its own permissions —
**`change own access code`** and **`change any access code`** — so you control who
can set or change codes. Importantly, its login form uses Drupal's built-in
**flood control** (`UserFloodControl`), which means failed access-code login
attempts are rate-limited using core's `user.flood` configuration. That protection
against brute-forcing is built in, not something you have to bolt on.

The single most important thing to understand is this: **an access code is a login
credential, exactly like a password.** A code grants account access in the same
way a password does. So its safety depends entirely on the codes being long and
randomly generated — a short or sequential code is easy to guess and brute-force,
even with flood control in place. Generate codes securely, serve login over
HTTPS, keep core's flood limits reasonable, and rotate codes the way you would
rotate passwords.

This guide is written for a **human** setting the module up through the admin UI.
If you want the terse, token-cheap reference written for an AI coding agent, read
the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and set the access-code permissions.

## How to use it

After enabling the module, decide who may manage codes: grant **`change any access
code`** to staff who administer accounts, and optionally **`change own access
code`** to let users maintain their own. Then issue each user a **long, randomly
generated** access code — never a short or predictable one — and they can use it to
log in. Because failed attempts are rate-limited through core's flood control,
keep the `user.flood` limits sensible, and always serve the login form over HTTPS.
Treat and rotate access codes exactly as you would passwords.
