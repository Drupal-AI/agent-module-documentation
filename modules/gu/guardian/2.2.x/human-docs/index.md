# Guardian — manual setup guide (2.2.x)

**Guardian** (`guardian`) protects your most dangerous account — user 1, and any
other account you designate as "guarded" — by stopping it from logging in with a
username and password at all. The only ways in become a **password reset link**
sent to the account's mailbox, or **`drush uli`** run on a machine that already
has shell access.

User 1 is Drupal's structural weak point: it bypasses every permission check by
design, it exists on every site, its username is often literally `admin`, and it
is the target of essentially all automated Drupal credential attacks. The usual
advice — give it a long random password nobody uses — fails in practice, because
that password ends up in a password manager, a deployment script, an old handover
document, and a former contractor's memory. Guardian removes the password as an
entry point entirely, so a leaked or guessed password is worth nothing. Legitimate
access instead flows through a reset link mailed to the account, or through
`drush uli` on a trusted machine — both of which are already your trust boundary.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

> **This is the 2.2.x guide.** Version 2.3.x reworks how the protection is
> enforced — nulling the password hash on every save and on cron, pinning the
> account's email, locking the user‑edit form, adding an idle‑session timeout, and
> moving the account's mail and timeout into `settings.php`. If you are on 2.3.x,
> read that version's guide instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, prepare user 1's
   mailbox, and enable the module.
2. [Configuration](configuration/index.md) — the settings form and, more
   importantly, the operational decisions to make before you switch it on.

## Where it lives in the admin menu

The settings form is at **Configuration → System → Guardian**
(`/admin/config/system/guardian`), gated by **Administer site configuration**.

## Three things to work through before enabling it

The failure mode with Guardian is being locked out of the account exactly when you
need it most. Decide all three of these in advance:

1. **The account's mailbox becomes the credential.** It must still exist, be
   monitored, and be protected. A reset flow pointing at a departed employee's
   address is *worse* than a password.
2. **Shell access becomes the other credential.** That is correct on a well‑run
   deployment — and a lockout on a platform where nobody has a shell.
3. **Plan the emergency path.** Decide who can send a reset, who can run
   `drush uli`, and what happens if neither is available.
