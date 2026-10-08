# Services, routes, controller and action (API)

## Query service — `address_suggestion.query_services`

`Drupal\address_suggestion\QueryService` (args: `plugin.manager.address_provider`,
`entity_type.manager`, `state`). Use it to run a lookup from PHP without going through the route.

```php
$service = \Drupal::service('address_suggestion.query_services');

// Resolve settings from a field's default form-display component, then query.
$results = $service->getData('node', 'article', 'field_address', '10 Downing Street');

// Or query with an explicit settings array (must include a 'provider' plugin id).
$results = $service->getProviderResults('10 Downing Street', [
  'provider' => 'nominatim',
  'country' => 'GB',
]);
```

- `getData($entity_type, $bundle, $field_name, $query)` — loads the `<type>.<bundle>.default` form
  display component `settings`, merges the country stored in `State`
  (`{entity_type}|{bundle}|{field_name}` and `…|Country`), then calls `getProviderResults()`.
- `getProviderResults($string, $settings)` — `createInstance($settings['provider'])->processQuery(...)`.

Returned items use the keys documented in
[../plugins/address-provider.md](../plugins/address-provider.md).

## Plugin manager — `plugin.manager.address_provider`

`AddressProviderManager` (extends `DefaultPluginManager`); alter hook
`address_suggestion_provider_info`. Discovers `Plugin/AddressProvider/*`.

## Routes & controller

Controller `Drupal\address_suggestion\Controller\AddressSuggestion`.

| Route | Path | Method | Notes |
|---|---|---|---|
| `address_suggestion.addresses` | `/address/suggestion/{entity_type}/{bundle}/{field_name}` | `handleAutocomplete` | Reads the field's default form-display component `settings` for provider/endpoint/key; input `?q=`, `?country=` are `Xss::filter`-cleaned; returns a JSON suggestion list. |
| `address_suggestion.ckeditor` | `/address/suggestion/{format}` | `ckeditor` | Requires `use text format <format>` **and** a matching `?token=`; provider config from the editor settings. See [../configure/ckeditor.md](../configure/ckeditor.md). |

Both routes declare `_access: 'TRUE'` in routing; the CKEditor handler adds the permission + token
check in code. The provider host is taken from stored widget/editor config, never from the request.

## Render element — `address_suggestion`

`Element\AddressSuggestion` (`#[FormElement('address_suggestion')]`) extends the address module's
`Address` element and adds a `processAutocomplete` process callback that attaches the JS library and
sets `#autocomplete_route_name`. The `address_suggestion` widget swaps the address element to this
`#type`.

## VBO action — `address_suggestion_action`

`Plugin\Action\AddressSuggestionAction` (extends `views_bulk_operations`'
`ViewsBulkOperationsActionBase`; only usable when VBO is installed). Configure it with `field_address`
and `field_geo`; on execute it geocodes the entity's address via
`address_suggestion.query_services` and writes a WKT point (via `geofield.wkt_generator`) into the geo
field, then saves the entity. Use it to backfill coordinates on existing content in bulk.

## Hooks

`Hook\AddressSuggestionHooks` implements `hook_help` only (renders README via the `markdown` filter
when present). No integrator-facing hooks are invoked by this module besides the provider alter hook
above.
