# Configuration

This is a module that can **delete user accounts**, so treat its settings form as a
policy you set deliberately rather than something to accept on defaults. Configure
it fully, and test on a disposable account, before letting it act on real users.

## Open the settings form

1. Log in as an administrator.
2. Open the **Inactive Users** settings form under **Configuration**.

## The inactivity policy

- **Inactivity threshold** — how long an account may go without logging in before it
  counts as inactive (the module's baseline is around six months). Pick a period that
  matches your site's real usage; too short and you will chase active but infrequent
  users, too long and dormant accounts linger.
- **Warning email + grace period** — before any action, the module emails the user a
  warning (for example "Your account will be deleted in 7 days if no login occurs.")
  and waits a grace period. Set a grace period long enough that a real person can
  notice the email and log back in. Customize the message so it clearly explains what
  will happen and how to prevent it.
- **Action: block vs delete** — decide what happens when the grace period passes
  with no login:
  - **Block** is reversible — the account is disabled but preserved, so you can
    restore it and the user's authored content is untouched.
  - **Delete** is destructive and effectively irreversible — it removes the account
    and can affect content that user authored. Choose it only when you are sure you
    want accounts gone for good.

## Protect accounts that must never be removed

Before enabling any destructive action, make sure the following are **exempt**:

- **Admin, service, and system accounts** (including user 1 and any automation or
  integration accounts).
- **Any roles** that should never be auto‑blocked or auto‑cancelled.

Getting the exemptions right is the single most important step — it is what prevents
an automated run from disabling the very accounts that keep the site working.

## Make sure cron runs

The detection, warning, and action steps all happen on cron. Confirm your site's
cron is scheduled to run on a real system cron; without it, warnings and actions
never fire.

## Roll it out safely

1. Configure the threshold, warning message, grace period, exemptions, and choose
   **block** first if you are unsure.
2. Test on a disposable account in a non‑production environment: make it look
   inactive, run cron, and confirm the warning email and the post‑grace action
   behave as you expect.
3. Only after you have verified the exemptions and the action, enable it against real
   users — and prefer **block** over **delete** until you are confident.
