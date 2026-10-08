# Configuration

Guardian's most important "configuration" is operational, not a form: it is making
sure the guarded account's mailbox and your shell access are both reliable before
you switch password login off. The settings form itself is small.

## Open the settings form

1. Log in as a user with **Administer site configuration**.
2. Go to **Configuration → System → Guardian**
   (`/admin/config/system/guardian`).

## The account's email must be correct

The protection hinges on the guarded account (user 1) having a valid, monitored
email address that matches its `init` value — because password reset to that
mailbox becomes the primary way back in. Set this up as described in
[Installation](../installation/index.md) and confirm it before relying on Guardian.
A shared team inbox or group address is the recommended choice, so access does not
depend on any single person.

## Using the two entry paths

Once Guardian is active, everyone who needs the guarded account uses one of:

- **Password reset** at `/user/password` — request a reset, receive the one‑time
  login link at the account's mailbox, and set/replace the session from there.
- **`drush uli`** — run `drush uli [uid]` on a machine with shell access to
  generate a one‑time login URL directly.

Because both are already trust boundaries (whoever controls the mailbox, and
whoever has a shell), you no longer need to store or share a complex password for
the account across your organisation.

## Before you switch it on — re‑read these

The one real risk is locking yourself out. Confirm all three:

1. **The mailbox is real, monitored, and protected.** A reset flow pointing at a
   departed employee's address is worse than a password.
2. **Shell access exists** for whoever might need `drush uli` — and note that on a
   hosting platform where nobody has a shell, that path is unavailable.
3. **An emergency plan is written down** — who can send a reset, who can run
   `drush uli`, and what to do if neither is reachable.
