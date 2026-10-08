# Configuration

Everything this module does mutates node ownership in bulk, so configure it
deliberately and grant its permission only to trusted administrators.

## Permission

The module adds a single permission, **`administer author content transfer`**,
set at **People → Permissions** (`/admin/people/permissions`). It gates all
three admin screens below. Because holding it means being able to mass-reassign
authorship across the site, scope it tightly.

## Settings — the inactivity policy and target user

Go to **`/admin/config/ownership-transfer`**. Here you define:

- **Which users count as inactive** — the policy that decides whose content is
  eligible to be transferred.
- **The destination user** — the account that inactive authors' content is
  reassigned to.

These settings are stored in the `author_content_transfer.settings` config
object. Set both correctly before you leave cron running, because cron applies
this policy automatically on every run.

## Bulk dashboard — run a transfer now

Go to **`/admin/config/ownership-transfer-bulk`** to trigger an ad-hoc bulk
reassignment immediately, rather than waiting for the next cron run. Useful for
offboarding a specific person or handling a team change on the spot.

## Analytics dashboard — review activity

Go to **`/admin/config/ownership-transfer-dashboard`** to see transfer activity
and preview counts — which nodes were moved and when, so you can check the
policy is doing what you expect before and after runs.

## Automation (cron)

Once the policy and target user are set, the module's cron hook applies the
transfer on every cron run — content owned by inactive users is moved to the
destination account automatically, with no manual step.

## Caution

This runs a bulk ownership change on real content. Verify the target user and
the inactivity policy on the settings form before enabling cron-driven
transfers, and keep the permission restricted to trusted administrators.
