# password_policy_consecutive — agent start

Password Policy submodule. One `PasswordConstraint` plugin **`consecutive`**
(`src/Plugin/PasswordConstraint/ConsecutiveCharacters.php`). Depends on `password_policy`.

Add to a policy at `/admin/config/security/password-policy`. Single setting
`max_consecutive_characters` (2–5): forbids that many identical chars in a row
(regex `/(.)\1{n-1}/`, case-sensitive). Schema
`password_policy.constraint.plugin.consecutive`. Plugin type: parent module's
plugins/password-constraint.md.
