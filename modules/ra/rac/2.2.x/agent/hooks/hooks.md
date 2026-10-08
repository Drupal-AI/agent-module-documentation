# Hooks implemented (`rac.module` / `*.install`)

These are the procedural hooks RAC implements that matter to integrators. Access enforcement is not
here — it is in the ADVA provider plugins (see plugins/access-providers.md).

| Hook | Purpose |
| --- | --- |
| `rac_form_user_admin_permissions_alter` | Hides all `RAC_view_*` / `RAC_update_*` permissions from the standard permissions page (they are managed programmatically / via the relations grid). |
| `rac_form_user_role_form_alter` + `_rac_form_user_role_form_submit` | On saving a user role, auto-grants `RAC_view_<role_id>` to that role if not already held. |
| `rac_user_role_delete` | When a role is deleted, revokes `RAC_update_<deleted_role_id>` from every remaining role. |
| `rac_form_field_storage_config_edit_form_alter` + `_rac_form_field_storage_config_edit_form_submit` | On an `entity_reference`→`user_role` field whose host entity type has a RAC consumer, adds the "Enable Role Access Control on this field" checkbox and stores third-party setting `rac.enabled`. |
| `rac_install` | Grants `RAC_view_<role_id>` to every existing role. |
| `rac_update_8100` | Sets `rac.settings:update_unpublished = TRUE`. |
| `rac_update_8101` | Installs `rac_relations`, adds it as a provider on each `access_consumer` that uses `rac`, and migrates old per-field config into the new `grants` / `unpublished` structure (view→`rac`, view+update(+delete)→`rac_relations`). |

## Helper functions

- `_rac_get_account_roles($op, $account)` — returns the `RoleInterface[]` for which `$account` holds
  `RAC_<op>_<role_id>`. Used by the `rac_relations` provider (op `update`).
- `_rac_get_supported_entity_types()` — entity type ids served by a `rac` ADVA consumer
  (`plugin.manager.adva.consumer`→`getConsumersForProviderId('rac')`); gates the field-storage form alter.
- `_rac_update_unpublished()` — reads `rac.settings:update_unpublished`.

> Present but not wired in 2.2 (defined, no hook invokes them): `_rac_get_entity_reference_roles()`,
> `_rac_get_entity_reference_role_fields()`, and the field-widget option-restriction chain
> `_rac_restrict_field_values()` / `_rac_field_validate()` / `_rac_restore_field_values()`. Do not rely
> on these — they are legacy helpers with no active caller in this release.
