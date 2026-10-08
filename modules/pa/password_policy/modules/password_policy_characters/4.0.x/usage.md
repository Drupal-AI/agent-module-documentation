Provides a Password Policy constraint requiring a minimum count of characters of one specific type (uppercase, lowercase, letter, numeric, or special).

---

This submodule adds the `password_policy_character_constraint` plugin. Unlike the character-types rule (which counts distinct classes), this rule targets one class and requires a minimum number of it. Its settings are `character_count` (how many) and `character_type` — one of `uppercase`, `lowercase`, `letter`, `special`, or `numeric`. During validation it tabulates the password's character distribution with `count_chars` and fails if the chosen type appears fewer than the required number of times. Because each instance targets a single type, you add several instances to a policy to require, say, "at least 2 digits and at least 1 special character." Config schema lives at `password_policy.constraint.plugin.password_policy_character_constraint`.

---

- Require at least 1 uppercase letter in every password.
- Require at least 2 digits in a password.
- Require at least 1 special character.
- Require a minimum number of lowercase letters.
- Require a minimum number of letters overall.
- Combine multiple instances for granular composition rules.
- Enforce "2 digits and 1 symbol" by adding two constraints.
- Apply strict per-type minimums to admin roles.
- Meet a compliance rule specifying counts of each character type.
- Pair with a length rule for precise strength control.
- Show each requirement in the live compliance table.
- Provide type-specific error messages (e.g. "must contain 2 uppercase").
- Differentiate per-type requirements by role via separate policies.
- Add a numeric-minimum rule to an existing policy.
- Deploy exact composition rules as exportable config.
- Require symbols specifically for privileged accounts.
- Enforce at least one digit for all authenticated users.
- Layer with character-types and blacklist for defense in depth.
