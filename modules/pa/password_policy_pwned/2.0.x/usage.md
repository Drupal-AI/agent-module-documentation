Adds a "Pwned Passwords" constraint plugin to the [Password Policy](https://www.drupal.org/project/password_policy) module that rejects passwords found in the Have I Been Pwned breach corpus.

---

The module ships a single `pwned_passwords` password constraint plugin for Password Policy. When a user sets or changes a password, the constraint hashes it with SHA-1 and queries the [Have I Been Pwned](https://haveibeenpwned.com/) Passwords range API to find out how many times that password has appeared in known breaches. The lookup uses the [k-anonymity range API](https://haveibeenpwned.com/API/v2#SearchingPwnedPasswordsByRange): only the first 5 hex characters of the SHA-1 hash are sent to the third party (`GET https://api.pwnedpasswords.com/range/{prefix}`); the API returns all hash suffixes with that prefix and the plugin matches the remaining suffix locally, so the full password and full hash never leave the site. The constraint has one setting, `min_occurrences` (default 1): a password is rejected if its breach count is greater than or equal to this threshold. Network/HTTP errors are swallowed (logged, occurrences treated as 0), so an unreachable API "fails open" and does not block password changes. The constraint is added to a Password Policy config entity like any other Password Policy constraint; there is no standalone settings page. The HTTP call is made through Drupal's `http_client` (Guzzle) with a 10-second timeout, wrapped in the injectable `pwned_passwords_client` service.

---

- Block users from choosing passwords that have appeared in public data breaches.
- Reduce credential-stuffing risk by rejecting known-compromised passwords at set/change time.
- Add breach checking as one constraint within a larger Password Policy (length, character types, etc.).
- Require a password to have been seen fewer than N times in breaches via `min_occurrences`.
- Enforce breach checks only on specific roles by attaching the policy to those roles.
- Warn/force existing users to change compromised passwords via Password Policy's password-reset behavior.
- Meet NIST 800-63B guidance to screen new passwords against a breached-password list.
- Keep password checking privacy-preserving using the HIBP k-anonymity range API (only a 5-char SHA-1 prefix leaves the site).
- Avoid maintaining a local breach wordlist by delegating to the HIBP service.
- Fail open (allow the password) when the HIBP API is unreachable, so account changes are not hard-blocked by an outage.
- Tighten the policy over time by lowering `min_occurrences` toward 1.
- Combine with other Password Policy constraints to build a defense-in-depth password rule set.
- Swap in a custom `pwned_passwords_client` implementation to point at a self-hosted HIBP mirror.
- Log breach-API failures to the `password_policy_pwned` logger channel for monitoring.
- Programmatically check a password's breach count by calling the `pwned_passwords_client` service.
- Apply breach screening to administrator accounts to protect privileged logins.
