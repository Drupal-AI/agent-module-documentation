# password_policy — agent start

Enforces per-role password **constraints** + password **expiration**. Constraints are
`PasswordConstraint` plugins (shipped as submodules); policies are config entities
targeting roles. Depends on core `datetime`. Config UI:
**Admin → Config → Security → Password Policies** (`/admin/config/security/password-policy`,
route `entity.password_policy.collection`).

- Create/manage policies, roles, expiration → [configure/policies.md](configure/policies.md)
- The PasswordConstraint plugin type (define your own rule) → [plugins/password-constraint.md](plugins/password-constraint.md)
- Bundled constraint submodules (length, blacklist, history, …) → [configure/constraints.md](configure/constraints.md)
- Expiration engine, cron, emails, event subscriber → [configure/expiration.md](configure/expiration.md)
- Permissions → [permissions/permissions.md](permissions/permissions.md)
- Alter hook (`hook_password_policy_show_policy_alter`) → [hooks/hooks.md](hooks/hooks.md)
