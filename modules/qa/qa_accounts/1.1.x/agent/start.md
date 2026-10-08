# QA Accounts — agent index

Development-only module: creates one active dummy user per role, with username = email-local-part =
**password** = `qa_<role_machine_name>`. Never enable in production. Depends on core `user`. Provides a
settings form (`configure: qa_accounts.settings`), a config object, one permission, a service, and Drush
commands. No plugins, no submodules.

- **Settings form, config keys, install/auto behavior, the permission (and its route-id mismatch)** →
  [configure/settings.md](configure/settings.md)
- **`qa_accounts.create_delete` service — create/delete accounts programmatically** →
  [api/service.md](api/service.md)
- **Drush commands to create/delete the QA account set** → [drush/commands.md](drush/commands.md)

Key facts:
- Account creation logic: `src/QaAccountsCreateDelete.php`. Username `qa_<role>`, email
  `qa_<role>@example.com`, password `qa_<role>`, account activated, role added (except `authenticated`),
  `anonymous` skipped.
- Runs on `hook_install` (`qa_accounts.install`) and via the two Drush commands.
- Config `qa_accounts.settings`: `auto_create_user_per_new_role` (false), `auto_delete_user_per_deleted_role`
  (false) — react to role insert/delete in `qa_accounts.module`.
- Development-only tool: the accounts are active with real roles and predictable credentials, and
  there is no environment guard in code — never enable it in production.
