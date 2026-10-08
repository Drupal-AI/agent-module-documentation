<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Config actions

All plugins live in `src/Plugin/ConfigAction/`, are declared with the core
`#[ConfigAction(...)]` attribute, implement `ConfigActionPluginInterface` +
`ContainerFactoryPluginInterface`, and are `@internal` / experimental. A config action's key
is the config-object name; the action id is the YAML key under it; the action value is passed
to `apply(string $configName, mixed $value)`. They run at **config-import / recipe-apply /
install time** only — there is no runtime entry point.

## `enableCommerceTrait` (`EnableCommerceTrait.php`)

Enables a single Commerce entity trait on a bundle. Value = the trait id (string).
`apply()` loads the bundle (`CommerceBundleEntityInterface`), returns early if the trait is
already present, else appends it via `setTraits()`, saves, then calls
`EntityTraitManager::installTrait()` to install the trait's fields on the bundle's entity type.

```yaml
config:
  actions:
    commerce_product.commerce_product_variation_type.default:
      enableCommerceTrait: purchasable_entity_shippable
```

## `enableCommerceTraits` (`EnableCommerceTraits.php`)

Plural variant: value = a list of trait ids (a bare string is coerced to a one-element list).
Iterates, skipping traits already on the bundle; if none remain to add it is a no-op; otherwise
saves the bundle once and installs each new trait. Use this to add more than one trait to the
same bundle from a recipe (the singular action can't be repeated for one config object because
recipe actions are keyed by action id).

```yaml
config:
  actions:
    commerce_product.commerce_product_variation_type.media_digital:
      enableCommerceTraits:
        - commerce_license
        - commerce_file
```

## `currencyImport` (`CurrencyImport.php`)

Declared with `entity_types: ['commerce_currency']`. Value = a currency code. Uses
`Exists::ReturnEarlyIfExists`: it resolves the target entity name by replacing the literal
`XYZ` in the config name with the value, loads it, and returns early if it already exists;
otherwise calls `commerce_price.currency_importer` `->import($value)` to pull the currency
definition from Commerce Price's currency repository.

```yaml
config:
  actions:
    commerce_price.commerce_currency.XYZ:
      currencyImport: USD
```

## `grantExistingPermissions` (`GrantExistingPermissions.php`)

Declared with `entity_types: ['user_role']`. Value = a permission string or list of them.
Normalizes to an array, then **filters out any permission not present in
`user.permissions`** (`PermissionHandlerInterface::getPermissions()`) — so it only ever grants
permissions that some enabled module actually defines. Loads the role, calls
`grantPermission()` for each surviving permission, saves.

```yaml
config:
  actions:
    user.role.content_editor:
      grantExistingPermissions:
        - 'access commerce_product overview'
        - 'update any commerce_product'
```

## `movePropertyBefore` / `movePropertyAfter` / `movePropertyToOffset`

Shared base `MovePropertyActionBase`. Reorders a key inside an associative-array config
property (core's `setProperties` always appends new keys at the end; these let a recipe place a
key where array order is meaningful, e.g. Views `fields`). Value is always an array with:

- `property` — dotted path to the array to reorder.
- `element` — the key to move.
- plus a position key per action (below).

`apply()` gets the editable config, reads the array; if it isn't an array or `element` is
absent, it's a **no-op**. It removes `element`, asks the subclass for a target index (via
`resolveTargetIndex()`, computed against the array with `element` already removed), splices the
key/value back in at that index, and saves. A `NULL` target index leaves the element out
(no-op). `element` values are preserved; index resolution uses `array_flip(array_keys())` so
numeric-string keys coerce the same way `array_key_exists()` does.

- **`movePropertyBefore`** — extra key `before`; inserts `element` at the sibling's index
  (no-op if `before` absent).
- **`movePropertyAfter`** — extra key `after`; inserts at the sibling's index + 1
  (no-op if `after` absent).
- **`movePropertyToOffset`** — extra key `offset` (asserts an int); `array_splice` offset
  semantics (0 = start, `>=` count appends, negative counts from the end).

```yaml
config:
  actions:
    views.view.commerce_cart_form:
      movePropertyAfter:
        property: display.default.display_options.fields
        element: variation_alternative
        after: purchased_entity
```

## `setPropertyByTheme` (`SetPropertyByTheme.php`)

Sets config property values chosen by the **site's default theme** (read from
`system.theme:default`). Value = a map keyed by dotted config-property path; each entry is a
map of theme machine name → value, with an optional `_default` used when no theme key matches.
A property whose map yields neither a theme match nor `_default` is left untouched. Applies all
resolved properties on the editable config and saves once.

```yaml
config:
  actions:
    views.view.commerce_cart_form:
      setPropertyByTheme:
        display.default.display_options.fields.variation_alternative.list_classes:
          belgrade: 'belgrade-list'
          _default: ''
```
