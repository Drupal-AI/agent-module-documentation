# Configure QA Accounts

Route `qa_accounts.settings` → `/admin/config/people/qa-accounts`, form
`QaAccountsSettingsForm`, config object `qa_accounts.settings`.

## Config keys (defaults in `config/install/qa_accounts.settings.yml`)

| Key | Default | Effect |
|---|---|---|
| `auto_create_user_per_new_role` | `false` | When true, `hook_user_role_insert` creates a `qa_<role>` account for every newly created role (except `anonymous`). |
| `auto_delete_user_per_deleted_role` | `false` | When true, `hook_user_role_delete` deletes the `qa_<role>` account when its role is deleted. |

Set from Drush:

```bash
drush config:set qa_accounts.settings auto_create_user_per_new_role true -y
drush config:set qa_accounts.settings auto_delete_user_per_deleted_role true -y
```

## What accounts get created

The `qa_accounts.create_delete` service (see [../api/service.md](../api/service.md)) creates, for each role
except `anonymous`, an account with:

- **username**: `qa_<role_machine_name>` (e.g. `qa_administrator`)
- **email**: `qa_<role_machine_name>@example.com`
- **password**: the same string as the username (`qa_<role>`)
- **status**: active
- **role**: the matching role is added (the `authenticated` account gets no extra role)

This happens on `hook_install` and via the Drush commands. Creation is idempotent — an already-existing
username is skipped and logged.

## Permission (note the route/permission id mismatch)

`qa_accounts.permissions.yml` defines exactly one permission: **`administer qa_accounts settings`**
("Administer QA Accounts settings"). It is NOT flagged `restrict access: true`.

The settings route (`qa_accounts.routing.yml`) requires `_permission: 'administer qa_accounts'` — a
DIFFERENT string than the defined `administer qa_accounts settings`. Because the required permission does
not exist, Drupal denies the route to everyone except user 1. Granting "Administer QA Accounts settings"
to a role does **not** open the form. Practically only uid 1 can reach the settings page in this release.

## Uninstall / teardown

There is no uninstall hook that removes the created accounts — they persist after the module is
uninstalled. Remove them first with `drush qa_accounts:delete` (see [../drush/commands.md](../drush/commands.md)).
