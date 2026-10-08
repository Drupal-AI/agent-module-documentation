# password_policy_character_types — agent start

Password Policy submodule. One `PasswordConstraint` plugin **`character_types`**
(`src/Plugin/PasswordConstraint/CharacterTypes.php`). Depends on `password_policy`.

Add to a policy at `/admin/config/security/password-policy`. Single setting
`character_types` = 2, 3, or 4 = how many of {lowercase, uppercase, digit, special}
the password must include (checked via regex). Schema
`password_policy.constraint.plugin.character_types`. Plugin type: see parent
module's plugins/password-constraint.md.
