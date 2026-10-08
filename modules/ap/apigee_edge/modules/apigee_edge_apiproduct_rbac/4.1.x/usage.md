Apigee Edge API product RBAC changes API-product access in the Apigee Edge module from a
visibility-based model (public/private/internal mapped to roles) to a role-based one: administrators
grant each API product to specific Drupal roles, and only members of those roles can view and assign
that product to their apps.

---

When enabled, the module disables apigee_edge's own `api_product_access` hook and takes over the
`view`, `view label`, and `assign` decisions for API products. Grants are stored as an attribute on
each API product in Apigee (default attribute name `DRUPAL_RBAC`), configured through a role-by-product
checkbox grid added to the API product access-control admin form; saving writes the selected role ids
into the product attribute via a batch. Users with the "Bypass API product access control" permission
always have full access, products with no attribute can optionally be shown to everyone, and a user
may still view a product their existing app already uses even without a matching role — but assigning a
new product always requires a role grant. It depends on `apigee_edge`.

---

- Grant an API product only to specific Drupal roles.
- Hide premium API products from anonymous or basic roles.
- Show internal/partner API products only to a partner role.
- Store product-to-role grants on the product itself in Apigee (portable across environments).
- Change the Apigee attribute used to store grants (default `DRUPAL_RBAC`).
- Let trusted admins bypass all product access checks via a permission.
- Optionally show products that have no grant attribute to everyone.
- Prevent developers from assigning products their role isn't granted.
- Still let a developer view a product their existing app already uses.
- Replace the default public/private/internal visibility model with roles.
- Manage all product-role grants from one admin grid.
- Bulk-update grants across many API products in one save (batch).
- Migrate grants when renaming the storage attribute.
- Enforce least-privilege API-product exposure on a developer portal.
- Cache access decisions per user for performance.
