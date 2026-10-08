Commerce AutoSKU automatically generates Drupal Commerce product-variation SKUs from a configurable token pattern, either always (hiding the SKU field) or only when the SKU is left empty, guaranteeing uniqueness.

---

The module configures SKU generation per **product variation type** and stores it in that bundle's third-party settings (`third_party.commerce_autosku`: `mode`, `plugin`, `configuration`), edited on an "Automatic SKU" local task/form added by a route subscriber + derivative. Three modes exist: `disabled`, `enabled` (always generate, and hide the SKU field — the field is seeded with the sentinel `%AutoSku%`), and `optional` (generate only when the SKU field is empty). Generation runs on variation insert/update through `CommerceAutoSkuManager`, which loads the configured generator plugin and writes the result to the `sku` field. Generators are plugins of the `commerce_autosku_generator` type (manager `plugin.manager.commerce_autosku_generator`, both `@Annotation` and the `#[CommerceAutoSkuGenerator]` PHP attribute are supported). The shipped `token` generator resolves a Token pattern (e.g. `[commerce_product_variation:product_id]-[commerce_product_variation:variation_id]`) via `\Drupal::token()->replace(..., ['sanitize' => FALSE, 'clear' => TRUE])`; the base class strips tags/control chars and appends `_0`, `_1`, … until the SKU is unique (checked against existing variations), truncating to 255 chars. If the pattern yields an empty string, an alternative SKU is built from the bundle label and entity ID. A `CommerceSkuNotNull` validation constraint accompanies it. Dynamic per-entity-type permissions (`administer <entity_type> SKU`, marked `restrict access: TRUE`) gate the config form. Requires Commerce (commerce_product) and Token.

---

- Auto-generate product variation SKUs from a token pattern instead of typing them by hand.
- Hide the SKU field entirely and always compute the SKU (`enabled` mode).
- Keep the SKU field visible but auto-fill it only when left blank (`optional` mode).
- Build SKUs like `[commerce_product_variation:product_id]-[commerce_product_variation:variation_id]`.
- Incorporate site or user tokens into the SKU pattern.
- Guarantee SKU uniqueness with an automatic numeric suffix on collision.
- Fall back to a bundle-label + ID SKU when the token pattern resolves to empty.
- Configure SKU generation separately for each product variation type.
- Store SKU config in exportable third-party settings on the variation type.
- Enforce non-empty SKUs via the shipped validation constraint.
- Migrate legacy products by regenerating SKUs on the next save.
- Standardize SKU formatting across a large catalog.
- Prevent editors from creating inconsistent or duplicate SKUs.
- Restrict who can change SKU automation via a per-entity-type admin permission.
- Add a custom generator plugin (e.g. sequential counter, hashed) via the `commerce_autosku_generator` plugin type.
- Truncate overly long generated SKUs to the 255-char limit safely.
- Strip HTML/control characters from generated SKUs automatically.
- Use the token browser in the pattern field to discover available tokens.
- Apply automatic SKUs to imported or programmatically created variations on save.
- Switch a variation type's SKU strategy without code by changing mode/plugin/pattern.
