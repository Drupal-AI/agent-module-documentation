# Permissions & routes

## Permission (`w3c_validator.permissions.yml`)

| Permission | `restrict access` | Grants |
|---|---|---|
| `administer w3c_validator` | **yes** | Configure and use the validator (settings + all report actions) |

The report and confirm routes accept `administer w3c_validator` **or** core `access site reports`
(comma-separated `_permission` = OR). The settings route requires `administer w3c_validator` only.

## Routes (`w3c_validator.routing.yml`)

| Path | Controller/Form | Permission |
|---|---|---|
| `/admin/config/development/w3c_validator` | `W3cValidatorSettingsForm` | `administer w3c_validator` |
| `/admin/reports/w3c_validator` | `W3CLogController::overview` (the `configure` route) | `administer w3c_validator,access site reports` |
| `/admin/reports/w3c_validator/confirm` | `W3CValidatorOperationConfirmForm` | `administer w3c_validator,access site reports` |

## Note

All state-changing actions (editing the endpoint, launching a full re-validation batch) are behind the
restricted `administer w3c_validator` permission. `access site reports` only reaches the read/confirm
report pages, not the endpoint settings.
