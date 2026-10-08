# password_policy_length — agent start

Password Policy submodule. One `PasswordConstraint` plugin **`password_length`**
(`src/Plugin/PasswordConstraint/PasswordLength.php`). Depends on `password_policy`.

Add it to a policy at `/admin/config/security/password-policy`. Settings:
`character_length` (int) and `character_operation` = `minimum` | `maximum`
(schema `password_policy.constraint.plugin.password_length`). Validation uses
`mb_strlen`. See the parent module's plugins/password-constraint.md for the plugin type.
