<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Store Domain — agent index

Resolves the Commerce **current store** by request hostname. Adds a `domain` base field to
`commerce_store` and registers a store resolver (priority 80). No admin UI (`configure` null),
no permissions, no config, no Drush. Depends on `commerce` + `commerce_store`.

- **The domain field, the two resolvers, Domain-module integration, and the cart-provider override** →
  [api/resolution.md](api/resolution.md)

Key facts:
- `hook_entity_base_field_info` adds `domain` (string, unlimited cardinality) to `commerce_store`;
  when the **Domain** module is on it also adds `domain_entity` (entity_reference → `domain`) and
  hides the plain `domain` widget.
- Service `commerce_store_domain.store_domain_resolver` is tagged `commerce_store.store_resolver`
  priority 80. Default class `StoreDomainResolver` matches `getHost()` against the `domain` field.
- `CommerceStoreDomainServiceProvider::alter()` swaps the class to `StoreDomainNegotiatorResolver`
  (uses `domain.negotiator`) if Domain is enabled, and replaces `commerce_cart.cart_provider` with
  `commerce_store_domain\CartProvider` so cart lookups default to the current store.
- Store queries in the resolvers use `accessCheck(FALSE)`.
