Token Content Access commerce products brings TCA to Drupal Commerce **products**: it registers the `tca_commerce_product` TcaPlugin, swaps in a custom access-control handler so product view access honours the URL token, and hides token-protected products from product search and Views listings for users without bypass.

---

The submodule ships one `TcaPlugin` (`#[TcaPlugin(id: 'tca_commerce_product', entityType: 'commerce_product')]`, `isFieldable() = TRUE`) so products gain the `tca_active`/`tca_public`/`tca_token` base fields and the parent's `TcaAccessCheck` gating. Because Commerce products use their own access handler, `hook_entity_type_alter()` replaces `commerce_product`'s `access` handler with `TcaCommerceProductAccessControlHandler` (extending Commerce Entity's handler + injecting the request stack) so the token check is applied consistently. As with tca_node, `tca_commerce_product.module` implements `hook_query_search_commerce_product_search_alter()` and `hook_views_query_alter()` to strip protected products from result sets for users without `tca bypass commerce_product`. It requires `commerce_product` and the `entity` module; it adds no config or permissions of its own (the parent generates `tca administer commerce_product` / `tca bypass commerce_product`).

---

- Enable token-based view access on commerce products.
- Gate a specific product behind a `?tca=<token>` URL (private / pre-launch products).
- Offer VIP or partner-only products reachable only via a shared tokenized link.
- Keep protected products out of product search results for non-bypass users.
- Exclude token-gated products from catalog Views and listings.
- Grant `tca bypass commerce_product` to merchandisers/QA to see all products.
- Force TCA on a commerce product type so every product of it needs a token.
- Mark a product `public` so the token link works even for anonymous shoppers.
- Regenerate a product token to revoke shared preview links.
- Apply consistent token gating through Commerce's own access handler.
- Keep protected product titles out of search snippets for non-bypass users.
- Add token access to an existing commerce product type without code.
- Share a pre-launch product page with select partners via a link.
- Combine bundle-level `force` with per-product tokens for mandatory gating.
- Audit which product types have TCA active via the bundle settings.
- Provide "secret link" access to limited-edition or gated products.
- Let merchandisers preview gated products with `tca bypass commerce_product`.

