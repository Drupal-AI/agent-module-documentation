# Configuration

Purge Users can be driven either from a single global settings form or from named
**policies**. Everything ships disabled, so nothing is deleted until you turn on
rules and trigger a purge.

## Open the settings form

1. Log in as a user with the **Access purge setting page** permission (or an
   administrator).
2. Go to **Configuration → People → Purge Users**, or navigate directly to
   `/admin/config/people/purge-users`.

## The four age-based rules

Each rule is independent, and each has a value, a period, and an enable checkbox
(all off by default):

- **Never logged in, account older than** — delete accounts that registered but
  never logged in, once they're older than the set age.
- **Last login older than** — delete accounts whose most recent login is older
  than the set age.
- **Never activated (inactive) for** — delete accounts that were never activated
  after the set period.
- **Blocked for** — delete accounts that have been blocked for longer than the set
  period.

The period for each can be minutes, hours, days, weeks, months, or years.

## Scope and exclusions

- **Do not purge content authors** — skip users who have authored content.
- **Do not purge commenters** — skip users who have posted comments.
- **Included roles** — only purge users who hold one of these roles.
- **Excluded roles** — never purge users who hold these roles.
- **Disregard inactive/blocked users** — skip already inactive/blocked users from
  certain rules.

## How accounts are cancelled

- **Cancel method** (default *Block the account*) — how a purged account is
  handled, using Drupal core's standard options:
  - **Block the account** (`user_cancel_block`).
  - **Block the account and unpublish its content** (`user_cancel_block_unpublish`).
  - **Delete the account and reassign its content** to the anonymous user
    (`user_cancel_reassign`).
  - **Delete the account and its content** (`user_cancel_delete`).
  - **Follow the site's default policy** (`user_cancel_site_policy`).

Because deletion goes through core's cancel process, it fires the normal
account-cancellation hooks and emails.

## Notifications

- **Notify on deletion** — email users when their account is deleted, with a
  configurable subject and body.
- **Warn before deletion** — send a pre-deletion warning email a configurable
  lead time before removal, again with its own subject and body.

## Automatic purging on cron

- **Purge on cron** (default **off**) — when enabled, each cron run queues the
  users matched by your enabled rules for purging. **This is the automatic
  trigger.** Leave it off if you'd rather run purges manually.

## Policies (reusable, composable rule sets)

For more control than the flat global form, build **policies** at
**Configuration → People → Purge Users → Policies**
(`/admin/config/people/purge-users/policies`) — these require the **Administer
site configuration** permission. A policy is a named set of **condition plugins**
you combine:

| Condition | Selects users… |
|---|---|
| **Never logged in** | who never logged in (older than the configured age). |
| **Not logged in** | whose last login is older than the configured age. |
| **Inactive** | who are inactive / never activated for the configured period. |
| **Blocked** | who have been blocked for the configured period. |
| **Included roles** | who hold one of the selected roles. |
| **Excluded roles** | who do **not** hold the selected roles (protects them). |
| **Author / commenter** | filters out users who authored content or commented. |
| **Notification required** | who are due a pre-deletion notification. |

Add conditions to a policy, and every enabled policy is evaluated on cron (and by
the Drush commands below). You can also run a single policy on demand from its own
confirmation page.

## Triggering a purge

- **On cron** — enable *Purge on cron* (global rules) and/or create policies;
  cron queues matching users automatically.
- **In the UI** — go to the confirmation form at
  `/admin/config/people/purge-users/confirm` (needs *Access purge confirmation
  form*) to run a purge on demand.
- **With Drush** — see below.

Queued work is processed in the background by the module's queue workers (for
example on cron, or via `drush queue:run`).

## Drush commands

```bash
# Preview which users a purge would select — makes no changes
ddev drush purge-users:purge --dry-run

# Queue matching users for purge (drained by the queue worker / cron)
ddev drush purge-users:purge

# Queue pre-deletion warning emails for users due one
ddev drush purge-users:notify
```

The `purge-users:purge` command evaluates your **policies** and queues matches;
`--dry-run` simulates the selection without deleting anything. The global-settings
age rules are queued by cron when *Purge on cron* is enabled.

## Protecting specific accounts (developers)

If you need to add or protect specific user IDs beyond what the UI offers, the
module provides `hook_purge_*_user_ids_alter()` hooks (for each rule and for policy
evaluation). Removing a uid in one of these hooks reliably protects that account
across the cron, Drush, and UI purge paths.
