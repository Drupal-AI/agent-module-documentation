# password_policy_blacklist — agent start

Password Policy submodule. One `PasswordConstraint` plugin **`password_blacklist`**
(`src/Plugin/PasswordConstraint/PasswordBlacklist.php`). Depends on `password_policy`.

Add to a policy at `/admin/config/security/password-policy`. Settings: `blacklist`
(list of forbidden passwords, one per line) + `match_substrings` (bool). Off =
exact case-insensitive match (`strcasecmp`); on = reject if password *contains* a
blacklisted phrase (`stripos`). Schema
`password_policy.constraint.plugin.password_blacklist`. Plugin type: parent
module's plugins/password-constraint.md.
