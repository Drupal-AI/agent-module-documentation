Provides a Password Policy constraint that enforces a minimum (or maximum) character length on passwords.

---

This submodule of Password Policy adds a single `PasswordConstraint` plugin, `password_length`, that checks a password's character count with `mb_strlen`. Its settings are a `character_length` number and a `character_operation` of either `minimum` or `maximum`, so one instance can require "at least N characters" and another can cap length at N. You add it to a policy on the Password Policy admin screen and it is enforced whenever a targeted user sets or changes their password. It injects the entity type manager but otherwise has no dependencies beyond the parent module. Config schema lives at `password_policy.constraint.plugin.password_length`. It is the most commonly used constraint and the recommended baseline for any policy.

---

- Require passwords to be at least 8 characters long.
- Require a stronger 12+ character minimum for administrator roles.
- Cap password length at a maximum to fit a downstream system.
- Add both a minimum and a maximum length using two instances.
- Enforce NIST-style long-passphrase minimums (e.g. 15+).
- Set a modest minimum for low-risk member roles.
- Combine with character-type rules for layered strength requirements.
- Ensure imported/legacy accounts meet a length floor on next change.
- Use multibyte-safe counting for non-ASCII passwords.
- Provide a clear "at least N characters" error at signup.
- Apply different length minimums per role via separate policies.
- Export the length rule as part of a deployable policy.
- Prevent trivially short passwords across the whole site.
- Meet a compliance requirement mandating minimum length.
- Add a length constraint to an existing multi-constraint policy.
- Warn users live via the compliance table as they reach the minimum.
- Set a maximum to avoid excessively long passwords in a form field.
- Baseline every policy with a length constraint before adding others.
