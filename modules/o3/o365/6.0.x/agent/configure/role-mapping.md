# Configure: map Microsoft 365 groups to Drupal roles

On login via `o365_sso`, the module can grant/revoke Drupal roles from the user's Microsoft 365
group membership. Form `o365.role_settings` (`\Drupal\o365\Form\RoleSettingsForm`) at
`/admin/config/system/o365/role-settings` (permission `access o365 settings page`) writes config
object **`o365.role_settings`**.

Config keys (`config/schema/o365.schema.yml`, all `string`):

| Key | Meaning |
|---|---|
| `default_role` | Role id given to every user on login (`_none`/empty = none). Also treated as a safe role. |
| `roles_map` | One mapping per line: `GroupIdentifier|role_a|role_b`. The group identifier may be the Graph group `id`, `displayName`, or `onPremisesSamAccountName`. |
| `safe_roles` | One role id per line; these are never removed. `anonymous`/`authenticated` are always excluded. |

Set via PHP:

```php
\Drupal::configFactory()->getEditable('o365.role_settings')
  ->set('default_role', 'authenticated')
  ->set('roles_map', "O365_TEACHER|teacher\nO365_ADMIN|content_editor|site_admin")
  ->set('safe_roles', "administrator")
  ->save();
```

## What happens at runtime

`RolesService` (service `o365.roles`, `src/RolesService.php`) drives it, invoked by
`RoleEventSubscriber` (service `o365.role_event`) which subscribes to
`\Drupal\externalauth\Event\ExternalAuthEvents::LOGIN` and only acts when the provider is
`o365_sso`:

1. `handleRoles(UserInterface $account)` loads `roles_map`; returns early if empty.
2. `getUserGroups()` calls `GraphService::getGraphData('/me/transitiveMemberOf/microsoft.graph.group?$select=id,displayName,onPremisesSamAccountName')` — so the `GroupMember.Read.All` (or equivalent) Graph scope must be granted.
3. `calculateUserRoles()` matches each configured group identifier against the user's groups (by `id`, `displayName`, or `onPremisesSamAccountName`) and collects the mapped role ids.
4. `updateUserRoles()` removes any current role that is **not** in `safe_roles` and not in the newly calculated set, adds the calculated roles, adds `default_role`, and saves the account only if something changed.

Failures (Graph/temp-store/identity-provider exceptions) are logged to the `o365` channel and
re-thrown as `EntityStorageException`. `clearCache()` resets the in-request memoised config/groups.

> Note: roles not listed in `safe_roles` are stripped on every o365 login. Put any locally
> granted, must-keep roles (e.g. `administrator`) in `safe_roles`.
