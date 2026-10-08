Admin Denied hardens Drupal's superuser account by randomizing uid 1's username and password on every cron run, so nobody can log into user 1 with a password.

---

Admin Denied is a tiny, dependency-free hardening module for the Drupal superuser (uid 1). On each `hook_cron()` run it overwrites uid 1's `name` with a fresh random 16-character string (optionally prefixed) and its `pass` column with another random 16-character string that is deliberately not a valid password hash — so Drupal's password check can never match and password login for uid 1 always fails. This removes the highest-value credential on the site (the all-powerful, often `admin`-named user 1) as a brute-force / phishing target and pushes administrators onto their own named accounts, restoring per-person accountability. The module has no admin UI, no permissions, no routes, and no config entities; its only tunable is the optional `$settings['admin_denied_prefix']` value in settings.php. Because password login for uid 1 is removed, the intended way back in is `drush uli` (a one-time magic login link) — so the module is only appropriate on sites where you can run Drush, and you should make sure at least one trusted named account holds the administrator role before relying on it. The module also adds a small convenience: it logs a watchdog entry whenever site maintenance mode is toggled.

---

- Disable password-based login for the Drupal superuser (uid 1).
- Randomize uid 1's username on every cron run.
- Randomize uid 1's password on every cron run.
- Remove the highest-value admin credential as a brute-force target.
- Defeat brute-force attempts against the default `admin` user 1.
- Force administrators to use their own named accounts.
- Restore per-person accountability for administrative actions.
- Harden a public-facing site against superuser account compromise.
- Add a lightweight, dependency-free account-hardening layer.
- Apply the well-known "no login as user 1" best practice automatically.
- Add an optional prefix to the generated uid 1 username via settings.php.
- Recover superuser access on demand with `drush uli`.
- Keep uid 1 reserved as a break-glass account reachable only via Drush.
- Reduce the value of a leaked/old uid 1 password hash.
- Log every maintenance-mode toggle to watchdog for auditing.
- Complement a password-policy or 2FA module on named admin accounts.
- Meet a security-review requirement to lock down the superuser.
- Prevent shared-uid-1 logins that obscure who did what.
- Ensure a stolen production database's uid 1 hash cannot be reused.
- Roll credentials continuously without any manual rotation process.
- Deploy across many sites where you already run cron and Drush.
- Pair with named admin roles as part of an account-hygiene baseline.
