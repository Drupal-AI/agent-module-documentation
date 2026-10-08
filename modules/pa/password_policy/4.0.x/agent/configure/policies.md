# Policies (config entity)

![Password Policies list](../../../../../../../screenshots/password_policy/4.0.x/policies.png)

Policies are `password_policy` config entities (`config_prefix: password_policy`,
schema `password_policy.password_policy.*`). Managed at
`/admin/config/security/password-policy` (list, add, edit, delete). Requires
`administer site configuration`.

Exported keys (`config_export` on `Entity/PasswordPolicy`):

| Key | Meaning |
|---|---|
| `id` / `label` | Machine name and human label. |
| `roles` | Role machine names the policy applies to. |
| `policy_constraints` | Ordered list of constraint instances, each `{ id: <plugin_id>, ...settings }`. |
| `password_reset` | Expiration interval in **days** (0 = no time-based expiration). |
| `send_reset_email` | Email the user when their password is reset/expired. |
| `send_pending_email` | Sequence of "days before expiry" on which to send reminder emails. |
| `show_policy_table` | Show the live compliance table on the user form. |

Add/edit forms (`Form/PasswordPolicyFormAdd|Edit`) let you pick roles, set the
expiration days + email options, then add constraints. Each constraint is added
via a sub-route (`entity.password_policy.constraint.add/edit/delete`) that renders
the plugin's own `buildConfigurationForm()`.

Constraint plugins are stored in a `DefaultLazyPluginCollection`. A user is subject
to a policy if they hold any of its roles; when multiple policies apply, all their
constraints must pass. Config is deployable like any other Drupal configuration.
