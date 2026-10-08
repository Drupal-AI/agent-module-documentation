Provides a Password Policy constraint that prevents a user's password from containing their username.

---

This submodule adds the `password_username` constraint plugin. It has a single (hidden) setting, `disallow_username`, defaulting to TRUE, and its validation checks whether the password contains the account's username case-insensitively (`stripos` against `getAccountName()`), failing if it does. This blocks an obvious weak-password pattern where people base their password on their login name. Because the check is per-user at validation time, it works even though usernames differ between accounts. Add it to a policy on the Password Policy admin screen. Config schema lives at `password_policy.constraint.plugin.password_username`.

---

- Prevent passwords that contain the account username.
- Block the common "username = password" weak pattern.
- Stop passwords like "jsmith123" for user "jsmith".
- Enforce a basic personal-info exclusion in passwords.
- Add the rule to a policy for authenticated users.
- Apply it to admin roles for extra protection.
- Provide a clear "password must not contain the username" error.
- Show the rule in the live compliance table.
- Combine with length/complexity for stronger passwords.
- Deploy the rule as exportable policy config.
- Catch case-insensitive username substrings in passwords.
- Add it to an existing multi-constraint policy.
- Discourage predictable password construction.
- Reduce risk from credential-stuffing that guesses username-based passwords.
- Enforce the rule site-wide via a broad policy.
- Differentiate application per role via separate policies.
- Layer with the blacklist constraint for weak-pattern coverage.
- Satisfy compliance rules barring identifiers in passwords.
