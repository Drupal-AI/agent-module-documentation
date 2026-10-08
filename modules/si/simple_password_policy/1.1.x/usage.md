<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Simple password policy applies a fixed set of configurable password rules — length, character-class counts, similarity-to-username, password history and expiry — as a lighter alternative to the full Password Policy module. It enforces server-side on the user form and marks non-compliant programmatic changes as expired.

---

A single settings form at `/admin/config/people/password_policy` (route `simple_password_policy.simple_password_policy_settings`, permission **`administer password policy`**, marked `restrict access: TRUE`) drives one config object, `simple_password_policy.settings`. The rules are fixed, not pluggable: minimum length, minimum count of lowercase / uppercase / numeric / special characters (a value of `0` inverts to *must not contain* that class, empty skips the check), a similarity-to-username percentage threshold, and password history (`min_old` re-uses allowed, optionally scoped to a `min_old_age` window in seconds). Enforcement is real and server-side: the module overrides core's `password` field-type plugin (`hook_field_info_alter`) and adds a `#validate` handler to `user_form`, so a non-compliant password on **registration or profile edit** is rejected with a form error before save. Programmatic saves (`$user->save()`, and Drush `user:password`/`upwd`) are *not* hard-blocked — instead the pre-hash `preSave` records a `policy` flag and, if non-compliant, `hook_user_update`/`_insert` stores the password as **expired** (a `KernelEvents::REQUEST` subscriber then redirects the user to their edit form until they set a compliant password). Beyond rules it adds password **expiry** (`expire_period`, `expire_warning`, a token-driven warning email via `hook_mail`), decorates core's `password_generator` service so generated passwords already satisfy the policy, and can disable core's password-reset route (`user.pass`) or, on config save, batch-expire (`force_password_reset`) or force-logout (`force_logout`) all users. Exemptions: the **`bypass password policy`** permission, plus `ignore_users` (username/email patterns) and `ignore_routes`. Core requirement `^10.1 || ^11 || ^12`; installs a `user_pass` history table and disables core's `password_strength` meter.

The usual caution applies whenever a complexity policy comes up: current guidance (**NIST 800-63B**, **UK NCSC**) recommends *against* mandatory character-class rules and *against* periodic forced expiry — they push people toward predictable transformations (`Password1!` satisfies most rule sets and appears in every breach corpus; forced rotation produces `Password2!`). The same guidance recommends a generous **length minimum** plus **checking against known-breached passwords** — the latter is what `pwned_passwords` does. So a defensible configuration of this module is often a high `min_length`, the character-class and expiry knobs left empty, and a breach check doing the real work. Two practical notes: verify the policy fires where you expect (registration, profile edit, programmatic user creation, Drush) — the reset route is a special case; and the module states the rules inline on the form before submission, which is the right behaviour.

---

- Require a minimum password length on all accounts.
- Require lowercase, uppercase, numeric and special characters.
- Forbid a specific character class (set its minimum to `0`).
- Reject a password too similar to the username.
- Enforce password history — block re-use of recent passwords.
- Scope history re-use to a time window (e.g. no re-use within a year).
- Expire passwords after a period (seconds or a `strtotime` phrase).
- Email users a warning before their password expires.
- Force users with an expired password to reset before continuing.
- Batch-expire every user's password after tightening the policy.
- Force-logout all users after a policy change.
- Generate policy-compliant passwords via the core generator (e.g. admin "generate password").
- Enforce the policy on Drush `user:password` and programmatic `$user->save()`.
- Exempt a service account with the `bypass password policy` permission.
- Exempt specific users by username or email pattern (`ignore_users`).
- Skip the policy check on specific routes (`ignore_routes`).
- Disable the core password-reset link entirely (`user.pass`).
- Apply a basic password standard without the full Password Policy module.
- Meet an audit's password-complexity requirement cheaply.
- Strengthen editor and membership-site account passwords.
- Set a length floor and leave complexity off (NIST/NCSC-aligned).
- Translate the warning email and rule labels (config translation supported).
- Replace core's password-strength meter with explicit, enforced rules.
- Redirect a user with a non-compliant hashed password to reset it on next request.
