# password_policy_history — agent start

Password Policy submodule. One `PasswordConstraint` plugin
**`password_policy_history_constraint`**
(`src/Plugin/PasswordConstraint/PasswordHistory.php`). Depends on `password_policy`.
Stores past password hashes in the `password_policy_history` table.

Add to a policy at `/admin/config/security/password-policy`. Setting
`history_repeats`: N = block reuse of last N passwords; `0` = block any past
password. Candidate checked against stored hashes via the core `password` service.
Injects `@database` + `@password`. Schema
`password_policy.constraint.plugin.password_policy_history_constraint`. Plugin
type: parent module's plugins/password-constraint.md.
