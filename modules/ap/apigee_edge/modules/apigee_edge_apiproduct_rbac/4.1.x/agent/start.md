# Apigee Edge API product RBAC (apigee_edge_apiproduct_rbac) — agent index

Replaces apigee_edge's **visibility-based** API-product access (public/private/internal → roles) with
**role-based** access: each API product is granted to specific Drupal roles, and only those roles can
view/assign the product to their apps. Grants are stored as an **attribute on the API product** in
Apigee (default attribute `DRUPAL_RBAC`), so the mapping lives with the product in the org.

- Depends on `apigee_edge`. No permissions or Drush of its own (reuses the parent's
  `bypass api product access control`).
- `configure` route: **`apigee_edge.settings.developer.api_product_access`**
  (`/admin/config/apigee-edge/developer-settings/access-control`) — this module alters that form.
- Provides config schema. No new plugin types.

## Solution docs
- **How role-based product access works and how to configure it** → [configure/rbac.md](configure/rbac.md)

## Key facts
- Config object `apigee_edge_apiproduct_rbac.settings`: `attribute_name` (default `DRUPAL_RBAC`),
  `grant_access_if_attribute_missing` (default **false**).
- `apigee_edge_apiproduct_rbac_module_implements_alter()` unsets apigee_edge's `api_product_access`
  hook so only this module's `hook_api_product_access` decides `view` / `view label` / `assign`.
- The form alter builds a role × product grid; saving writes the selected role ids into the product's
  `attribute_name` attribute via a batch (`RoleBasedAccessSettingsBatch`).
