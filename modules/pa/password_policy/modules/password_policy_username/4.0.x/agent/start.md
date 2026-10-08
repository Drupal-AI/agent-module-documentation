# password_policy_username — agent start

Password Policy submodule. One `PasswordConstraint` plugin **`password_username`**
(`src/Plugin/PasswordConstraint/PasswordUsername.php`). Depends on `password_policy`.

Add to a policy at `/admin/config/security/password-policy`. Setting
`disallow_username` (bool, default TRUE): fails if the password contains the
account name (`stripos` vs `getAccountName()`, case-insensitive). Schema
`password_policy.constraint.plugin.password_username`. Plugin type: parent
module's plugins/password-constraint.md.
