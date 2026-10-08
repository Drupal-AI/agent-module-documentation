<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Account policy applies a small, fixed baseline of account-hygiene rules: it can require the username to equal the email (or match regex patterns), block accounts that have gone unused for a configured period after an optional warning email, and delete long-dormant accounts — without the plugin machinery of the full Password Policy stack.

---

Many sites need only a handful of account rules: usernames that are email addresses, dormant logins that get disabled, and stale accounts that eventually get removed. Drupal core does not provide these, and the comprehensive contrib answer (Password Policy and its constraint plugins) is more than such a requirement needs. This module takes the lighter path. On the user form it enforces a username/email format policy — username-must-match-email, regex patterns the username or email must satisfy, and an option to lock the username after it is first set — with per-account exemptions by name pattern or via the `bypass account policy` permission. On cron it sweeps all accounts (throttled by `inactive_interval`): accounts idle past `inactive_period` are blocked (an optional warning email goes out `inactive_warning` beforehand), and accounts idle past `delete_after_time` are removed using the configured core user-cancel method. Administrators get "Activate" and "Block" row operations on the People list, gated by dedicated permissions. All decisions are dispatched as events (`simple_account_policy_block/activate/warning/delete`), so other modules can react to or replace the default behavior, and a `[account_policy:block_period]` token feeds the warning email. Configuration lives in one config object, `simple_account_policy.settings`, at `/admin/config/people/account_policy`. Requirements are core `user` and `^10.1 || ^11`. Note that this module does not implement password expiry, forced password change, or password complexity — its scope is username/email format, inactivity, and deletion.

---

- Require every username to be the account's email address.
- Enforce a regex pattern that usernames must match.
- Restrict registration emails to an allowed domain via a pattern.
- Lock the username so it cannot be changed after signup.
- Automatically block accounts after 3 months of inactivity.
- Send a warning email before a dormant account is blocked.
- Delete accounts that have been dormant for over a year.
- Choose the core cancel method used when accounts are deleted.
- Exempt service or integration accounts with the bypass permission.
- Exempt specific usernames from the policy by name pattern.
- Reactivate a blocked account from the People list.
- Manually block an active account from the People list.
- Clear a user's failed-login flood records when reactivating them.
- Disable dormant staff accounts automatically for account hygiene.
- Satisfy an IT policy requiring email-as-username.
- Meet a compliance control on removing stale accounts.
- Throttle the inactivity sweep frequency via cron interval.
- Customize the dormancy-warning email subject and body with tokens.
- Show applicable account rules inline on the user edit form.
- React to block/delete decisions from a custom module via events.
- Replace the default block/delete behavior with a custom subscriber.
- Reduce the number of stale accounts on a long-running site.
- Manage account lifecycle for contractors and temporary staff.
- Warn users their account will be blocked in "N weeks" via a token.
