# Configuration

Block Inactive Users has two separate screens: the **main settings** form (the
automatic, cron‑driven blocking and its emails) and the **Cancel Users** tool (a
deliberate bulk cancellation). Both require the core **Administer site
configuration** permission.

## Auto‑block settings

Open **Configuration → People → Block Inactive Users**
(`/admin/config/people/block_inactive_users`). Saving this form stores your
choices but does **not** block anyone by itself — blocking happens on the next
cron run, or immediately if you use the "Disable inactive users" button at the
bottom of the form.

### Who gets blocked, and when

- **Idle time (months)** — block users whose last activity is at least this many
  **months** ago. This is the core threshold.
- **Include users who never logged in** — when on, accounts that have never
  logged in are also considered inactive, measured from when the account was
  created.
- **Exclude roles** — roles that are never auto‑blocked. The administrator is
  excluded by default; add any other roles that should be protected.

### The block notification email

- **Send email** — whether to email a user when their account is blocked. The
  email includes a one‑time reactivation link.
- **From email** — the From address for the block email.
- **Email subject** and **Email content** — the subject and body. These accept
  tokens: standard `[site:*]` and `[user:*]` tokens, plus the module's own
  `[activation-link]` (the reactivation URL) and `[days-until-blocked]`.

### The advance warning email

- **Send warning email** — email users ahead of time that they are about to be
  blocked. Each user is warned only once, and logging in clears the pending
  warning so they are not spammed.
- **Days until blocked** — how many days before the block the warning is sent.
- **Warn from email**, **Warn email subject**, **Warn email content** — the From
  address, subject and body of the warning email (same tokens available).

## The Cancel Users tool

Open **Configuration → People → Block Inactive Users → Cancel Users**
(`/admin/config/people/block_inactive_users/cancel_users`). This is a one‑off bulk
action that runs Drupal core's account cancellation over the accounts your rules
match. When you press **Cancel Users**, the module counts the matching accounts
and takes you to a **confirmation step** before anything is actually cancelled.

### Which accounts to match

- **Idle time (months)** — only accounts idle at least this many months.
- **Include users who never logged in** — also include accounts that never logged
  in.
- **Include roles** — only cancel accounts that have one of these roles.
- **Include status** — only accounts with the selected status(es) — active,
  blocked, or both.

### Whitelists (never cancel these)

- **Username whitelist** — a newline‑separated list of usernames that must never
  be cancelled.
- **Email whitelist** — a newline‑separated list of email fragments (for example a
  domain); any account whose email matches is protected.

The anonymous user, the administrator (uid 1) and the `administrator` role are
always excluded regardless of your rules.

### What cancellation does

- **Cancellation method** — which core cancellation method to run:
  - **Block the account** (keep everything, just disable login),
  - **Block the account and unpublish its content**,
  - **Delete the account and reassign its content** to the anonymous user, or
  - **Delete the account and its content**.
- **Send cancellation email** — whether to send core's standard cancellation
  confirmation email to each affected user.

Because deletion methods are irreversible, review the match count on the
confirmation step before proceeding, and lean on the whitelists to protect
important accounts.
