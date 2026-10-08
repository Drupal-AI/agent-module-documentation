# password_policy_delay — agent start

Password Policy submodule. One `PasswordConstraint` plugin
**`password_policy_delay_constraint`**
(`src/Plugin/PasswordConstraint/PasswordDelay.php`). Depends on `password_policy`.

Add to a policy at `/admin/config/security/password-policy`. Setting `delay` =
hours that must pass after the last change before another is allowed (checked
against `field_last_password_reset`). "Minimum password age" — pair with
password_policy_history. Injects `@database` + `@password`. Schema
`password_policy.constraint.plugin.password_policy_delay_constraint`. Plugin type:
parent module's plugins/password-constraint.md.
