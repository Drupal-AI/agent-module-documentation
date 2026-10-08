# Commerce AutoSKU — per-variation-type configuration

## Where config lives
Third-party settings on the **product variation type** config entity
(`commerce_product_variation_type.<id>`), namespace `commerce_autosku`:
```yaml
third_party_settings:
  commerce_autosku:
    mode: enabled            # disabled | enabled | optional
    plugin: token            # a commerce_autosku_generator plugin id
    configuration:
      pattern: '[commerce_product_variation:product_id]-[commerce_product_variation:variation_id]'
```
Schema: `config/schema/commerce_autosku.schema.yml`. Constants (`CommerceAutoSkuManager`): `DISABLED='disabled'`, `ENABLED='enabled'`, `OPTIONAL='optional'`.

## The form
- Form `\Drupal\commerce_autosku\Form\CommerceAutoSkuForm` (`getFormId` = `commerce_autosku_settings_form`), reached via a local task "Automatic SKU" on the variation type edit UI. The route is provided dynamically by `RouteSubscriber` for entity types exposing an `auto-sku` link template; the task is derived by `CommerceAutoSkuConfigTask`.
- Fields: **mode** (radios), **plugin** (radios, AJAX-refreshing), **configuration** (`commerce_plugin_configuration` element for the selected generator).
- Submit writes `mode`, `plugin`, `configuration` via `setThirdPartySetting()` and saves the variation type.

## Modes
- `disabled` — no automatic SKU.
- `enabled` — always generate; the SKU form field is hidden and seeded with sentinel `%AutoSku%`. `autoSkuNeeded()` regenerates when the stored SKU equals `%AutoSku%`.
- `optional` — generate only when the SKU field is left empty.

## Generation flow (on variation insert/update)
`CommerceAutoSkuManager::setSku()` → loads generator `createInstance(plugin, configuration)` → `generate($variation)`:
1. `getSku()` (token generator: `\Drupal::token()->replace($pattern, [variation_type => $variation], ['sanitize' => FALSE, 'clear' => TRUE])`).
2. If empty → `getAlternativeSku()` = bundle label (+ entity id if saved).
3. `makeUnique()` — `strip_tags` + remove control chars, then append `_0`, `_1`, … while a variation with that SKU already exists, truncating to 255 chars.

## Token generator config validation
`Token::validateConfigurationForm()` requires at least one real token in a non-empty pattern (`$this->token->scan()`), otherwise a form error. A `token_tree_link` (types: `user`, `site`, `commerce_product_variation`) is shown under the pattern textarea.

## Permissions
Dynamic, one per entity type with an `auto-sku` link template and a `label` key:
`administer <entity_type> SKU` (e.g. `administer commerce_product_variation_type SKU`), all defined with **`restrict access: TRUE`** (`CommerceAutoSkuPermissionController::autoSkuPermissions`).

## Validation constraint
`CommerceSkuNotNull` (+ validator) enforces a non-null SKU, complementing the automation.
