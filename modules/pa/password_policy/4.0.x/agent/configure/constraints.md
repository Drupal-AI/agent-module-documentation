# Bundled constraint submodules

Each rule is a separate submodule providing one `PasswordConstraint` plugin. Enable
only the ones you need, then add them to a policy. Plugin ids and their settings:

| Submodule | Plugin id | Key settings | Enforces |
|---|---|---|---|
| password_policy_length | `password_length` | `character_length`, `character_operation` (minimum/maximum) | Min/max password length. |
| password_policy_character_types | `character_types` | `character_types` (2–4) | At least N of: lower, upper, digit, special. |
| password_policy_characters | `password_policy_character_constraint` | `character_count`, `character_type` (uppercase/lowercase/letter/special/numeric) | At least N chars of a chosen type. |
| password_policy_consecutive | `consecutive` | `max_consecutive_characters` (2–5) | Blocks runs of identical characters. |
| password_policy_blacklist | `password_blacklist` | `blacklist` (list), `match_substrings` (bool) | Disallows listed passwords / substrings. |
| password_policy_history | `password_policy_history_constraint` | `history_repeats` (0 = all) | Prevents reuse of previous passwords (table `password_policy_history`). |
| password_policy_username | `password_username` | `disallow_username` | Password may not contain the username. |
| password_policy_delay | `password_policy_delay_constraint` | `delay` (hours) | Minimum time between password changes. |

Each is documented in its own `modules/<submodule>/4.0.x/`. All implement
`PasswordConstraintBase` and return a `PasswordPolicyValidation` from `validate()`;
`history` and `delay` inject the database, `length` injects the entity type manager.
Config schema for each lives at `password_policy.constraint.plugin.<id>`.
