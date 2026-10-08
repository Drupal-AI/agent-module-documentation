# Role-based API-product access

Enabling this module changes how API-product visibility is decided. In
`apigee_edge_apiproduct_rbac_module_implements_alter()` it removes apigee_edge's implementation of
`api_product_access`, so its own `hook_api_product_access` is the sole authority for the `view`,
`view label`, and `assign` operations on `api_product` entities.

## Configuration

Config object `apigee_edge_apiproduct_rbac.settings`:

| Key | Default | Meaning |
|---|---|---|
| `attribute_name` | `DRUPAL_RBAC` | Name of the Apigee **attribute** on each API product that stores the list of role ids allowed to see it. |
| `grant_access_if_attribute_missing` | `false` | If a product has no/empty attribute, whether everyone may see it. |

Configured on the parent's **API product access** form
(`/admin/config/apigee-edge/developer-settings/access-control`), which this module alters
(`apigee_edge_apiproduct_rbac_form_apigee_edge_api_product_access_control_form_alter()`): it hides the
visibility settings, shows a warning that visibility access is disabled, and adds a **role × product**
checkbox grid plus the attribute-name and "show products with missing attribute to everyone" options.
Saving runs a batch (`RoleBasedAccessSettingsBatch::batchOperation`) that writes the checked role ids
into each product's attribute (delimiter `", "`), migrating values if you rename the attribute.

Set config via PHP (the attribute on products is managed through the form/batch):
```php
\Drupal::configFactory()->getEditable('apigee_edge_apiproduct_rbac.settings')
  ->set('attribute_name', 'DRUPAL_RBAC')
  ->set('grant_access_if_attribute_missing', FALSE)
  ->save();
```

## Access decision (`apigee_edge_apiproduct_rbac_api_product_access()`)

For operations `view`, `view label`, `assign` (any other operation → neutral):

1. Users with **`bypass api product access control`** → allowed (and their roles show as pre-checked,
   disabled, in the grid; those roles are not stored redundantly in the attribute).
2. Product attribute **empty/missing**:
   - `assign` → **forbidden**;
   - else if `grant_access_if_attribute_missing` → allowed;
   - else → allowed only if the user already owns an app using that product, otherwise **neutral**.
3. Product attribute has roles:
   - if the user's roles intersect the product's roles → **allowed**;
   - else `assign` → **forbidden**; `view`/`view label` → allowed only if the user already owns an
     app using that product, otherwise **neutral**.

Neutral means no grant, so with no other module allowing it the operation is denied — access is
default-deny. The `assign` path is always stricter than `view`: a user may keep viewing a product
their existing app already uses, but cannot newly assign a product their roles don't cover. The result
is cached per user with a dependency on the entity and the settings config.
