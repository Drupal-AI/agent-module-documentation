# Commerce AutoSKU — agent index

Auto-generates Commerce product-variation SKUs from a token pattern, per variation type. Config
lives in the variation type's third-party settings; generation runs on variation save. No global
config page (`configure` null), no Drush. Requires `commerce_product` + `token`.

- **Per-variation-type config (modes, token pattern, the "Automatic SKU" form, permissions)** →
  [configure/settings.md](configure/settings.md)
- **The `commerce_autosku_generator` plugin type (add a custom SKU generator)** →
  [plugins/generator.md](plugins/generator.md)

Key facts:
- Third-party settings key `commerce_autosku` on `commerce_product_variation_type`: `mode` (`disabled`|`enabled`|`optional`), `plugin` (generator id), `configuration` (plugin config, e.g. `pattern`).
- Config form route derived per entity type (link template `auto-sku`), local task `commerce_autosku.config`.
- Permission `administer <entity_type> SKU` (e.g. `administer commerce_product_variation_type SKU`), **`restrict access: TRUE`**.
- Shipped generator `token`; sentinel `%AutoSku%` seeds hidden field in `enabled` mode; SKUs made unique with `_N` suffix, capped at 255 chars.
- Services: `commerce_autosku.manager`, `commerce_autosku.entity_decorator`, `commerce_autosku.route_subscriber`.
