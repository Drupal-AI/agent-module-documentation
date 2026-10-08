<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Block Inactive Users automatically blocks (and optionally emails a reactivation link to) user accounts that have not been active for a configured number of months, and provides a separate bulk "Cancel Users" tool for deleting/blocking stale accounts by role, status, and whitelist rules.

---

On every cron run the module's `hook_cron` warns and then blocks users whose last access is older than the configured idle period. The idle threshold is measured in **months** (`block_inactive_users_idle_time`); users whose `last access` interval meets or exceeds it are blocked via the `InactiveUsersHandler` service, admin (uid 1) and users in excluded roles are skipped, and optionally a notification email containing a one-time reactivation URL is sent. A "warn" pass emails users a configurable number of days before they will be blocked (tracked in state key `block_inactive_users.warn` so each user is warned once; logging in clears the warning). A confirmed reactivation link (`/reactivate/{user}/confirm/{timestamp}/{hashed_pass}`) lets a blocked user request re-activation. Two settings forms exist: the main one at `/admin/config/people/block_inactive_users` (idle time, block email content/subject, exclude-roles, warn email + days-until-blocked) storing `block_inactive_users.settings`, and a separate **Cancel Users** form at `/admin/config/people/block_inactive_users/cancel_users` (idle time, include roles/statuses, username/email whitelists, cancellation method, confirmation email) storing `block_inactive_users.settings_cancel_users` — its "Cancel Users" button runs core `user_cancel()` in bulk. Both settings forms are gated by `administer site configuration`; the module also declares a restricted permission `administer block_inactive_users configuration`. Tokens (`[site:name]`, `[user:account-name]`, plus custom `[activation-link]`, `[days-until-blocked]`) are supported in the email templates.

---

- Automatically block accounts that have been inactive for e.g. 3 months.
- Email inactive users a reactivation link when their account is blocked.
- Warn users by email a set number of days before their account is blocked.
- Include users who have never logged in when calculating inactivity (from account creation).
- Exclude the administrator (and other chosen roles) from automatic blocking.
- Run the block sweep automatically on cron, or trigger it immediately from the settings form.
- Bulk-cancel stale accounts by role using the separate Cancel Users tool.
- Choose the account cancellation method (block, block+unpublish, or delete) for bulk cancel.
- Whitelist specific usernames so they are never cancelled by the bulk tool.
- Whitelist users by email substring/domain to protect them from bulk cancellation.
- Restrict bulk cancellation to users with a specific status (active/blocked).
- Send a confirmation email to users whose accounts are cancelled in bulk.
- Enforce an account-lifecycle policy on a membership or intranet site.
- Reduce attack surface by disabling dormant accounts on a schedule.
- Clean up abandoned test/registration accounts periodically.
- Customize the block-notification email subject and body with tokens.
- Provide blocked users a self-service reactivation confirmation URL.
- Log every automatic block to the `block_inactive_users` logger channel.
- Preview how many users match the cancel rules (count) before running the cancel.
- Keep the impending-block warning idempotent so users are not spammed.
- Comply with a security policy requiring inactive accounts to be disabled after N months.
