Provides a Password Policy constraint that rejects passwords matching (or containing) a configurable blacklist of words and phrases.

---

This submodule adds the `password_blacklist` constraint plugin. You enter a list of forbidden passwords (one per line) in `blacklist`, and a `match_substrings` toggle decides the matching mode. With substring matching off, a password is rejected only if it equals a blacklisted value (case-insensitive, `strcasecmp`); with it on, a password is rejected if it merely *contains* any blacklisted phrase (`stripos`). This is ideal for banning your organization's name, product names, common weak passwords, or seasonal patterns. Add it to a policy on the Password Policy admin screen. Config schema lives at `password_policy.constraint.plugin.password_blacklist`.

---

- Ban your company or brand name from passwords.
- Block a curated list of common weak passwords (e.g. "password", "123456").
- Reject passwords containing product or project names.
- Forbid seasonal patterns like "Summer2024".
- Ban support/service account terms from user passwords.
- Reject passwords equal to a known-compromised value.
- Use substring matching to catch embedded blacklisted phrases.
- Use exact matching to block only whole-value passwords.
- Apply a stricter blacklist to admin roles.
- Provide a clear "restricted words in your password" error.
- Show the rule in the live compliance table.
- Deploy the blacklist as exportable policy config.
- Maintain a shared org-wide banned-password list.
- Combine with length/complexity for layered strength.
- Block internal jargon or acronyms from passwords.
- Differentiate blacklists per role via separate policies.
- Add the constraint to an existing multi-constraint policy.
- Catch trivially guessable passwords tied to the site.
