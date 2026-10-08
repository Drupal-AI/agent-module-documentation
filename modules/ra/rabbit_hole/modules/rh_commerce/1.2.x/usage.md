Registers Commerce products with Rabbit Hole so you can control what happens when a product is viewed at its canonical page — display, access denied, page not found, or redirect — per product type or per product.

---

`rh_commerce` is the Rabbit Hole submodule for Drupal Commerce. Enabling it registers a Rabbit Hole entity plugin for the `commerce_product` entity type, adding the "Rabbit Hole settings" vertical tab to product type edit forms and (when overrides are allowed) individual product edit forms. Stores often want product canonical pages to behave in non-default ways — redirecting discontinued items, sending certain product types to a category page, or hiding products that are only sold as variations elsewhere. This submodule enables that without custom access or routing code. All behavior logic, redirect codes, tokens, and fallbacks come from the base `rabbit_hole` module; this submodule only wires up product support. It depends on `rabbit_hole` and `commerce_product`.

---

- Permanently 301-redirect a discontinued product to its replacement.
- Redirect a product page to its category or catalog view.
- Return 404 for products that are only sold as variations of another.
- Set a per-product-type default behavior, overridable per product.
- Deny access to unpublished/internal product types.
- Redirect using a token such as `[commerce_product:field_url]`.
- Return "page not found" instead of "access denied" to hide existence.
- Override the product-type default on a featured product.
- Configure a fallback action for empty/invalid redirect targets.
- Redirect legacy product URLs to new SKUs during a migration.
- Use a temporary 302 redirect for out-of-stock items.
- Let store admins bypass the action to preview real product pages.
- Grant a role permission to administer Rabbit Hole on products only.
- Send seasonal products to a promo landing page.
- Redirect a product page to `<front>`.
- Consolidate SEO by redirecting thin product pages.
- Route bundle/kit products to a configurator page.
- Prevent product pages from resolving on a headless commerce front end.
