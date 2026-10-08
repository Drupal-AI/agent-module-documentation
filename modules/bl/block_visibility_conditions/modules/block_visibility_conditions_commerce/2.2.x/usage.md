Submodule of Block Visibility Conditions that provides the "Not Product Type" (`not_product_type`) block visibility condition, hiding a block on selected Commerce product types' pages while keeping it visible elsewhere.

---

This submodule ships a single concrete condition plugin, `NotProductType` (id `not_product_type`, label "Not Product Type"), which extends the parent module's `NotConditionPluginBase` with `CONTENT_ENTITY_TYPE = 'commerce_product_type'`. In the core Block layout or Layout Builder "Configure block" form it renders a checkboxes list of Commerce product types; the block is hidden only on product pages of the checked product types and shown everywhere else, unlike core's negated "Product type" condition which disappears on non-product routes. It depends on the parent module and Drupal Commerce's `commerce_product` module. No settings page, permissions, Drush commands, or config schema. Unlike the node and taxonomy submodules, it is not auto-enabled by the parent's update hook.

---

- Hide a footer block on specific Commerce product-type pages while showing it site-wide.
- Keep a promotional block off certain product types but visible on catalog views and content.
- Select multiple product types at once to hide a block on any of their pages.
- Replace a core negated "Product type" condition that wrongly hides a block on non-product pages.
- Configure the condition per block in Block layout without editing config by hand.
- Apply the condition to a block placed via Layout Builder.
- Show a cross-sell block everywhere except on a chosen product type's pages.
- Export the block's visibility config for deployment across environments.
- Combine "Not Product Type" with core role/path conditions on one block.
- Give store editors a friendly product-type checkbox list for block visibility.
- Enable only this submodule when you need Commerce-based conditions but not node or taxonomy.
- Reason precisely: an empty product-type selection means the block is always shown.
- Hide a shipping-info block on digital product-type pages only.
- Restrict a menu block from appearing on specific product-type pages.
- Keep a review-request block off pre-order product types while showing it on others.
