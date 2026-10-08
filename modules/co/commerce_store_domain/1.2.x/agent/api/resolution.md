<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Store resolution by domain

## The added base field(s)

`commerce_store_domain_entity_base_field_info(commerce_store)`:

| Field | Type | When | Notes |
|---|---|---|---|
| `domain` | string, cardinality **unlimited** | always | Editable string widget on the store form. One host per value (e.g. `shopa.com`). |
| `domain_entity` | entity_reference → `domain` | only if **Domain** module enabled | Autocomplete (tags) widget; the plain `domain` widget is moved to a hidden region. Installed at runtime by `hook_modules_installed` when Domain is enabled, uninstalled (values cleared first) by `hook_modules_uninstalled`. |

Neither field is display-configurable on view (`setDisplayConfigurable('view', FALSE)`).

## The resolver (Commerce store resolver chain)

Service `commerce_store_domain.store_domain_resolver`, tagged
`{ name: commerce_store.store_resolver, priority: 80 }`.

- **Default — `Resolvers\StoreDomainResolver`** (no Domain module): `resolve()` reads
  `requestStack->getCurrentRequest()->getHost()` and returns the first `commerce_store`
  whose `domain` field equals that host (`accessCheck(FALSE)`), else `NULL`.
- **With Domain — `Resolvers\StoreDomainNegotiatorResolver`**: `resolve()` gets
  `domain.negotiator->getActiveDomain()`; if none, returns `NULL`; otherwise returns the store
  whose `domain_entity` references that domain's id.

Returning `NULL` lets the next resolver in the chain (e.g. Commerce's default-store resolver)
decide. The current store is exposed as usual via `commerce_store.current_store` /
`$store = \Drupal::service('commerce_store.current_store')->getStore()`.

## Domain-aware cart provider

`CommerceStoreDomainServiceProvider::alter()` (a `ServiceProviderBase`, runs at container
compile) also, **when `commerce_cart` is present**, sets `commerce_cart.cart_provider`'s class to
`commerce_store_domain\CartProvider`. That subclass overrides `getCartIds()` to default the
`$store` argument to the current store, so carts are scoped per store/domain rather than shared.

## Extending

To customise matching (wildcards, subdomains, ports), subclass `StoreDomainResolver` and either
retag your service or use your own `alter()` to point the resolver service at your class. The
resolver only needs to implement `Drupal\commerce_store\Resolver\StoreResolverInterface::resolve()`.
