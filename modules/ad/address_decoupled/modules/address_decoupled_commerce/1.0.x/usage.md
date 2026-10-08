Address Decoupled Commerce adds a Commerce-aware REST resource that returns the current store's supported shipping and billing countries without needing a store id in the request path.

---

This submodule of Address Decoupled targets decoupled Drupal Commerce storefronts. Where the base module's supported-countries resource requires the caller to pass a `commerce_store` id in the URL, this submodule provides a resource at the fixed path `/address-decoupled/api/store/supported-countries` that resolves the active store itself through Commerce's `commerce_store.current_store` service. It returns the store's `shipping_countries` and `billing_countries` as full country objects (code, name, three-letter/numeric code, currency, locale), expanded via the parent `address_decoupled` service, and adds cacheable dependencies on the store entity and the request URL so the response caches correctly in single- and multi-store/multi-domain setups. It reuses the same REST plugin id (`address_decoupled_store_supported_countries`) and the same `cookie`-auth, `json`, per-resource-permission model as the base module. Requires the parent module plus `commerce` and `commerce_store`.

---

- Build a checkout country dropdown in a decoupled Commerce storefront without hard-coding or passing a store id.
- Serve the correct supported-countries list automatically per domain in a multi-store / multi-domain Commerce site (current store resolved server-side).
- Populate separate shipping-country and billing-country selectors from a single `GET /address-decoupled/api/store/supported-countries` call.
- Show full country metadata (currency code, ISO codes, locale) for each supported country, not just the code.
- Cache the supported-countries response safely — the resource attaches the store and `url` as cacheable dependencies.
- Let a JAMstack/static build fetch the active store's country constraints at build time.
- Keep the front end in sync with the store's `shipping_countries` / `billing_countries` field configuration, since values are read live from the store entity.
- Restrict endpoint access per role by granting the `restful get address_decoupled_store_supported_countries` permission (RESTful Web Services group).
- Switch authentication (cookie / basic_auth / oauth2) by editing the resource config for the submodule's install config.
- Localize returned country names via the request/interface language handled by the parent `address_decoupled` service.
- Use as a drop-in replacement for the base module's id-in-path store resource when the app always operates on the current store.
- Combine with the parent module's `country-data` and `validate-address` endpoints to build a complete headless address form limited to the store's supported countries.
- Provide a mobile Commerce app with the store's allowed destinations without embedding store configuration in the app.
- Diagnose empty responses via the `address_decoupled_rest` dblog channel when no current store or no country fields are set.
- Prototype a Commerce storefront's shipping/billing coverage widget quickly with a single GET returning JSON.
