# Force Password Change — manual setup guide

**Force Password Change** (`force_password_change`) lets administrators require
users to change their password. You can force a change for **everyone in a role**,
for a **single named user**, for **all new accounts on their first login**, or
**automatically after a set expiry period** — a common requirement for security
policy and compliance.

Once a change is pending for a user, the module enforces it the next time that
user is active. You choose how strictly: it can check on **every page load**
(redirecting the user straight to their edit form the moment they browse, the most
secure option) or **only at login** (lighter weight). Either way, an ordinary user
simply gets sent to their own account‑edit form to set a new password before they
can continue — and they cannot re‑use their current password.

Beyond one‑off forces, the module supports **timed password expiry**: you can say
that a given role's passwords expire after, say, 90 days, and set different
expiry periods for different roles with a priority order so stricter rules for
privileged roles win. The settings page and per‑role detail pages also show
administrators how many users have a pending change and when each user last had
their password forced or actually changed it.

There is one safety valve worth knowing about up front: if the module ever locks
you out, you can disable all enforcement with a single line in `settings.php`
without uninstalling. The module requires only Drupal core's **User** module and
provides one administrative permission.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent — including the config keys,
storage tables, and the programmatic service — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the settings form and the four ways
   to force a change (by role, by user, on first login, by expiry), plus the
   emergency off‑switch.

## Where it lives in the admin menu

Once enabled, the settings form sits at **Configuration → People → Force Password
Change** (`/admin/config/people/force_password_change`), gated by the **Administer
force changing of passwords** permission. Per‑role detail pages are linked from
there.

## How to use it

Open the settings form to choose how enforcement is checked (every page load
versus login only) and to turn on first‑login enforcement and/or password expiry.
Then trigger a force where you need it — by ticking a role on the settings form,
on a role's edit form, or on an individual user's profile edit form. Affected
users are prompted to set a new password on their next visit. See
[Configuration](configuration/index.md) for each option in detail.
