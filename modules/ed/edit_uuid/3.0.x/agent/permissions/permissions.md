# Permissions

Declared in `edit_uuid.permissions.yml` (all three `restrict access: false`).

| Permission | Title | Gates |
|---|---|---|
| `administer edit_uuid_config configuration` | Administer Edit UUID | All four config routes (collection, add, edit, delete) and the `EditUuidConfigAccessControlHandler` view/update/delete checks. |
| `show edit_uuid` | Show UUID in Entity Form | Whether the `uuid` field is injected onto entity forms at all (`hook_form_alter`), and whether the `edit_uuid` field formatter prints anything on view displays. |
| `edit edit_uuid` | Edit UUID | Referenced in the `#disabled` computation for the injected UUID field (see below and [../hooks/form-alter.md](../hooks/form-alter.md)). |

## Intended role split

Per the module's README, the design intent is: grant `show edit_uuid` to roles
that should only *see* the UUID, and additionally `edit edit_uuid` to roles that
should be able to *change* it; per-bundle, the config's `config_type` checkbox can
force a bundle to be view-only regardless of role.

## Actual gating in code

Field visibility on entity forms and in the formatter is gated solely by
`show edit_uuid`. The editable/disabled state of the injected field is computed in
`edit_uuid_form_alter` as:

```php
$form['uuid']['#disabled'] =
  $user->hasPermission('edit edit_uuid') && !$value->configType() ? FALSE : $value->configType();
```

So the field renders **disabled (view-only)** whenever the matching config's
`config_type` is TRUE, and **editable** when `config_type` is FALSE. The user must
also have edit access to the underlying entity form for the field to be reachable.

## Access handler

`EditUuidConfigAccessControlHandler::checkAccess` returns
`AccessResult::allowedIf($account->hasPermission('administer edit_uuid_config configuration'))`
for the `view`, `update`, and `delete` operations (cache-per-permissions), and
neutral otherwise.
