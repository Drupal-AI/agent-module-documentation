# Password Policy Pwned Passwords — agent index

Adds one `pwned_passwords` constraint plugin to the Password Policy module: rejects passwords
found in the Have I Been Pwned breach corpus via the privacy-preserving k-anonymity range API.
No settings page (`configure` null), no permissions, no Drush. Depends on `password_policy`.

- **Add/configure the constraint on a password policy, its one setting (`min_occurrences`), fail-open behavior** → [configure/constraint.md](configure/constraint.md)
- **The `pwned_passwords_client` service, how the HIBP lookup works, calling/replacing it** → [api/client.md](api/client.md)

Key facts:
- Constraint plugin id `pwned_passwords` (`src/Plugin/PasswordConstraint/PasswordPwned.php`),
  extends `password_policy`'s `PasswordConstraintBase`. Config schema
  `password_policy.constraint.plugin.pwned_passwords` (mapping: `min_occurrences` integer, default 1).
- Lookup: `PwnedPasswordsClient::getOccurrences($password)` — `sha1()`, uppercased; sends only the
  first 5 chars to `https://api.pwnedpasswords.com/range/{prefix}`; matches the suffix locally.
  Full password/hash never sent. 10s timeout; on any Guzzle error returns 0 (fails open).
- Deprecated legacy alias class `PasswordPnwed` (typo) still ships; use `PasswordPwned`.
