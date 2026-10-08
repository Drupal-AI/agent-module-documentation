Provides a Password Policy constraint requiring a minimum number of distinct character types (lowercase, uppercase, digits, special) in a password.

---

This submodule adds the `character_types` constraint plugin. Its single setting, `character_types` (a value of 2, 3, or 4), sets how many of the four character classes — lowercase letters, uppercase letters, digits, and special characters — a password must include. During validation it uses regular expressions to detect which classes are present and counts them, failing if the total is below the configured threshold. It is the classic "complexity" rule: instead of demanding a specific count of each type, it demands variety across types. Add it to a policy on the Password Policy admin screen. Config schema lives at `password_policy.constraint.plugin.character_types`. Use it to raise overall password entropy without micromanaging exact character counts.

---

- Require passwords to mix at least 3 of 4 character classes.
- Enforce full complexity (all 4 types) for admin roles.
- Require a lighter 2-of-4 mix for low-risk member roles.
- Increase password entropy without exact per-type counts.
- Satisfy a policy mandating "letters, numbers and symbols".
- Combine with a length rule for balanced strength requirements.
- Nudge users away from all-lowercase passwords.
- Apply stricter complexity to privileged roles via separate policies.
- Show the requirement live in the compliance table as users type.
- Provide a clear "must contain N character types" error message.
- Meet compliance frameworks that require character variety.
- Deploy the complexity rule as exportable policy config.
- Add complexity to an existing multi-constraint policy.
- Encourage passphrases that mix case and symbols.
- Differentiate complexity requirements per role.
- Avoid dictionary-style single-class passwords.
- Pair with a blacklist to block both weak and simple passwords.
- Raise the bar for externally facing account creation.
