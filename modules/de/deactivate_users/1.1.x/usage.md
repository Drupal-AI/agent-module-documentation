Deactivate Inactive Users blocks Drupal accounts that have gone unused for a configured number of days, running from cron, with advance-warning emails and an optional self-service unblock flow.

---

The module is a cron-driven account-hygiene control. On each cron run (when the `enabled` flag is set) it queries active users whose last `access` (or, for never-logged-in accounts, `created`) time is older than the configured inactivity limit plus a grace period, and blocks them — optionally emailing each one a deactivation notice and dispatching a `UserDeactivatedEvent` for other modules to react to. Before blocking, it can send one or more warning emails on a comma-separated day schedule (e.g. 5, 10, 20 days before expiry), using the `[user:expire-timeout:days]` token to show the days remaining. A "changed record" grace window prevents cron from immediately re-blocking a user an admin just unblocked, and a "minimum warning time" delays all blocking for N days after the module is first switched on so live users get a chance to be warned first. Every status change (block or unblock, by system or by another user) is written to a custom `account_status_record` content entity for auditing. Optionally, blocked users can request an unblock link at `/user/unblock`; the link carries a `user_pass_rehash()` hash and expires after a configurable grace period, and clicking a valid one reactivates the account and redirects to login. Two admin forms (Settings and Mail Templates, both under Configuration → Users → Deactivate Users) configure timeouts, the notification schedule, and the three token-aware email templates. The module depends only on Token and defines no permissions of its own — the admin routes are gated by core's `administer site configuration`.

---

- Enforce a NIST 800-53 / policy-style "block accounts inactive for 90 days" control on a Drupal site.
- Automatically deactivate (block) users whose last login is older than a configured threshold.
- Add a grace period on top of the inactivity limit (e.g. 85 days inactive + 5 days grace = 90).
- Also expire accounts that were created but never logged in, using their creation date.
- Send users one or more advance-warning emails before their account is blocked.
- Configure the warning schedule as a comma-separated list of days-before-expiry (e.g. 5, 10, 20).
- Show each user how many days remain before deactivation via the `[user:expire-timeout:days]` token.
- Email a notice to users at the moment their account is deactivated.
- Customize the From address, subject, and body of the warning, deactivation, and unblock emails.
- Delay all blocking for a number of days after first enabling the module so existing users are warned first.
- Prevent cron from re-blocking a user an administrator just manually unblocked (changed-record grace window).
- Let blocked users request their own unblock link from a public `/user/unblock` form.
- Reactivate an account through a signed, time-limited unblock link without admin intervention.
- Expire self-service unblock links after a configurable number of seconds.
- Keep an audit trail of every account block/unblock in the `account_status_record` entity.
- Record whether each status change was made by the system or by another user, and by whom.
- React to deactivations in custom code by subscribing to the `deactivate_users_user_deactivated` event.
- Log deactivations and (optionally) notifications to the `deactivate_users` logger channel / Watchdog.
- Run the whole lifecycle unattended via standard Drupal cron with no Drush commands required.
- Use Token replacement (site name, user fields, unblock link) in all email templates.
- Toggle warning and deactivation emails independently while keeping cron blocking active.
- Reduce attack surface by removing standing access from dormant employee or member accounts.
