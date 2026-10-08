# Hooks — for integrators

## Hooks this module invokes (implement in your module)

Documented in `apigee_edge.api.php`:

- `hook_apigee_edge_app_listing_page_title_alter(TranslatableMarkup &$title)` — change the title of
  the "My apps" listing page and its menu link.
- `hook_apigee_edge_user_agent_string_alter(array &$user_agent_parts): void` — extend the User-Agent
  the SDK client sends to Apigee.

## `hook_api_product_access` — the API-product visibility extension point

`apigee_edge_api_product_access(EntityInterface $entity, $operation, AccountInterface $account)`
(operations `view`, `view label`, `assign`) is the module's own implementation of the pattern; other
modules may implement the same hook to decide who can see/assign an API product.

Built-in logic: `bypass api product access control` short-circuits to allowed; otherwise the product's
`access` attribute (`public`/`private`/`internal`, default `public`) is mapped to roles via config
`apigee_edge.api_product_settings:access`. If the user's roles don't match, `view` is still allowed
when the user already owns an app that uses the product; `assign` is forbidden.

To replace the whole model, implement `hook_module_implements_alter()` and unset `apigee_edge`'s
implementation of `api_product_access` — this is exactly what the `apigee_edge_apiproduct_rbac`
submodule does to swap visibility-based access for role-based access.

## Other hook implementations worth knowing
- `apigee_edge_entity_access()` blocks revoking/deleting an app's **only** active credential.
- `apigee_edge_user_presave/_user_cancel/_user_delete` keep the Drupal user ↔ Apigee developer in
  sync; `apigee_edge_cron()` runs queued sync jobs.
- `apigee_edge_form_user_register_form_alter()` / `_user_form_alter()` add the developer-email
  handling to user forms.
