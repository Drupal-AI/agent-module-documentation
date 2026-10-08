<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Adds a `domain` field to Drupal Commerce stores and registers a store resolver so the active/current store is chosen by the request's hostname, enabling one Drupal site to serve several stores on different domains.

---

Commerce Store Domain extends the `commerce_store` entity with an unlimited-cardinality `domain` string base field (via `hook_entity_base_field_info`) and tags a `StoreResolverInterface` service (`commerce_store_domain.store_domain_resolver`, priority 80) into Commerce's store resolver chain. On each request `StoreDomainResolver::resolve()` reads the current host (`RequestStack::getCurrentRequest()->getHost()`) and returns the store whose `domain` field matches, so the current store follows the domain the visitor is on. When the contrib **Domain** module is enabled, a service provider swaps the resolver for `StoreDomainNegotiatorResolver` (which resolves via `domain.negotiator`'s active domain against a `domain_entity` entity-reference field) and replaces `commerce_cart.cart_provider` with a subclass so `getCartIds()` defaults to the current store — keeping each domain's cart separate. The module has no admin settings page, no permissions, and no config: you set each store's domain(s) on the store edit form. It is a thin, code-only integration layer.

---

- Run multiple Commerce stores from one Drupal site, each on its own domain.
- Automatically select the current store based on the request hostname.
- Map several hostnames/aliases to a single store (the field is multi-value).
- Serve store A on `shopa.com` and store B on `shopb.com` from the same codebase.
- Keep shopping carts separated per store/domain so a cart on one domain does not leak to another.
- Integrate store selection with the contrib Domain module's active-domain negotiation.
- Reference Domain records from stores via the added `domain_entity` entity-reference field when Domain is installed.
- Resolve the default store without relying on Commerce's stored "default store" setting.
- Provide domain-based storefronts for affiliate or white-label sites.
- Let editors set a store's domain directly on the store form (no extra config UI to learn).
- Drop the domain resolver into Commerce's resolver chain at priority 80 alongside other resolvers.
- Support subdomain-per-store setups (e.g. `eu.example.com`, `us.example.com`).
- Migrate a single-store site to multi-store by assigning domains per store.
- Avoid custom code for host-based store negotiation.
- Cleanly uninstall: removing the Domain module clears `domain_entity` values and drops the field.
- Combine per-domain stores with per-store currencies, tax, and payment configuration.
- Build a marketplace where each seller/brand gets a dedicated domain.
- Use as the negotiation backend for a headless/multi-front storefront keyed by host.
- Extend `StoreDomainResolver` to add custom matching rules if needed.
