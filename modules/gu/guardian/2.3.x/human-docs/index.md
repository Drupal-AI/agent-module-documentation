# Guardian — manual setup guide (2.3.x)

**Guardian** (`guardian`) protects your most dangerous account — user 1, and any
other account you designate as "guarded" — by making password login impossible for
it. The only ways in become a **password reset link** sent to the account's
mailbox, or **`drush uli`** run on a machine that already has shell access.

User 1 is Drupal's structural weak point: it bypasses every permission check by
design, it exists on every site, its username is often literally `admin`, and it
is the target of essentially all automated Drupal credential attacks. The usual
advice — a long random password nobody uses — fails in practice because that
password ends up in a password manager, a deployment script, an old handover
document, and a former contractor's memory. Guardian makes the password
**worthless** rather than strong.

## What 2.3.x enforces

This version is more thorough than 2.2.x about *how* it removes the password as an
entry point. On every account save and on cron it:

- **nulls the guarded account's password hash**, so there is nothing for the login
  form or HTTP basic auth to match against;
- **pins the account's email** to the address you configure (so reset always goes
  to the mailbox you control);
- **disables the account and password fields** on the user‑edit form for guarded
  users;
- **blocks non‑guarded users from editing guarded accounts** (and restricts user 1
  to user 1);
- **destroys a guarded user's session after an inactivity timeout**, bouncing them
  to the password‑reset page.

A key difference from 2.2.x: the guarded account's **email and inactivity window
are set in `settings.php`**, not in the UI — `$settings['guardian_mail']` (required)
and `$settings['guardian_hours']` (optional). It can also guard **more than just
user 1** through a hook, and it enriches its reset/notification mails with client
details. See [Configuration](configuration/index.md).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

> **This is the 2.3.x guide.** The earlier 2.2.x series has the same goal but a
> lighter mechanism (no `settings.php` keys, no forced password‑null on every save,
> no session timeout, no guard‑extra‑accounts hook). If you are on 2.2.x, read that
> version's guide instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, set the required
   `settings.php` keys, and enable the module.
2. [Configuration](configuration/index.md) — the `settings.php` keys, the single UI
   field, how enforcement works, and guarding extra accounts.

## Where it lives in the admin menu

The settings form is at **Configuration → System → Guardian**
(`/admin/config/system/guardian`), gated by **Administer site configuration** —
but note the account's mail and timeout come from `settings.php`, not this form.

## Three things to work through before enabling it

The failure mode is being locked out of the account exactly when you need it most.
Decide all three in advance:

1. **The account's mailbox becomes the credential.** It must still exist, be
   monitored, and be protected. A reset flow pointing at a departed employee's
   address is *worse* than a password.
2. **Shell access becomes the other credential.** Correct on a well‑run deployment;
   a lockout on a platform where nobody has a shell.
3. **Plan the emergency path.** Decide who can send a reset, who can run
   `drush uli`, and what happens if neither is available.
