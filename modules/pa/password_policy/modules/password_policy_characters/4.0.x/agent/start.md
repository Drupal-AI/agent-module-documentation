# password_policy_characters — agent start

Password Policy submodule. One `PasswordConstraint` plugin
**`password_policy_character_constraint`**
(`src/Plugin/PasswordConstraint/PasswordCharacter.php`). Depends on `password_policy`.

Add to a policy at `/admin/config/security/password-policy`. Settings:
`character_count` (int) + `character_type` = `uppercase` | `lowercase` | `letter` |
`special` | `numeric`. Requires at least N chars of that one type (counted via
`count_chars`). Add multiple instances for multi-type rules. Schema
`password_policy.constraint.plugin.password_policy_character_constraint`.
Plugin type: parent module's plugins/password-constraint.md.
