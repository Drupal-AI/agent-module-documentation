# TCA permissions

Permissions are generated **per supported entity type** by
`\Drupal\tca\TcaPermissionGenerator::permissions` (registered via `permission_callbacks` in
`tca.permissions.yml`). For each enabled `tca_plugin` you get two permissions:

| Permission | Gates |
|---|---|
| `tca administer <entity_type>` | Whether the user sees/edits the **TCA fieldset** (active/public/token) on that entity type's add/edit form (`FormManglerService`, and `hook_form_alter` in `tca.module`). |
| `tca bypass <entity_type>` | Whether the user **skips the token check entirely** for that entity type — `TcaAccessCheck::access()` returns neutral immediately, and `tca_node` search/Views query filters are not applied. Effectively "see all TCA-protected content of this type". |

Example concrete permissions when `tca_node` + `tca_commerce_product` are on:
`tca administer node`, `tca bypass node`, `tca administer commerce_product`,
`tca bypass commerce_product`.

## Notes on trust
- These permissions are **not** marked `restrict access: true`, but their capability is scoped:
  `tca administer <type>` only lets a holder set the token/flags on entities they can already
  edit; `tca bypass <type>` lets a holder view token-protected entities of that type (grant it
  to trusted reviewer/QA roles). Neither grants cross-boundary privilege escalation.
- Even without `administer`, if a **bundle forces** TCA (`force`), the fieldset is still added
  so the token is generated on save.
- The permissions declare a module dependency on the plugin's provider, so config export tracks
  which submodule they belong to.
