Commerce Product defines the Product and Product Variation entities plus product attributes, so you can build a catalog of purchasable items with options like size and color.

---

This submodule provides the catalog layer of Drupal Commerce. A **product** is the marketing-level item (title, description, images, store assignment) and one or more **product variations** are the actual purchasable, priced, SKU-bearing units under it. **Product attributes** (e.g. Size, Color) with attribute values combine to generate variations, and the storefront renders an add-to-cart form that lets shoppers pick the attribute combination. Product types and variation types are configurable bundles you extend with Field UI, and variations are the "purchasable entities" the rest of Commerce (cart, order, pricing) works with. It depends on Commerce, Commerce Price and Commerce Store and integrates with Path (product URLs) and Text. Manage catalog structure at Admin → Commerce → Configuration → Product types / Product variation types / Product attributes (`commerce_product.configuration`), and products at Admin → Commerce → Products.

---

- Build a product catalog of purchasable items.
- Sell products with variations (size, color, material).
- Assign each variation its own SKU and price.
- Define product attributes and attribute values.
- Auto-generate variations from attribute combinations.
- Create multiple product types (e.g. clothing vs. downloads) with distinct fields.
- Create variation types with their own fields and order-item type.
- Add product images and rich descriptions.
- Assign products to one or more stores.
- Give products clean URL aliases via Path.
- Render an attribute-driven add-to-cart form.
- Model single-variation (simple) products.
- Model complex products with dozens of variations.
- Sell digital/downloadable products as variations.
- Reference product variations as purchasable entities in orders.
- Add custom fields (brand, specs) to product or variation types.
- Control which attribute widget (select/radios) renders per attribute.
- Translate products and attributes on multilingual stores.
- Build catalog listings and facets over product data with Views.
- Manage the full product catalog from the admin listing.
