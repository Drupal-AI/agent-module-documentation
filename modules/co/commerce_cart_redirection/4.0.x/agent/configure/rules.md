# Configure — redirection rules, fields, schema, drush

**Config entity type:** `commerce_cart_redirection_rule` (class `Entity\RedirectionRule`,
config prefix `commerce_cart_redirection.rule.*`). There is **no** `config/install` default:
a fresh install has zero rules and redirects nothing until you create an enabled rule.

**UI / configure route:** `entity.commerce_cart_redirection_rule.collection` at
`/admin/commerce/config/commerce_cart_redirection` (under *Commerce → Configuration → Orders*,
menu link `commerce_cart_redirection.configuration`). The listing is a `DraggableListBuilder`
(`RedirectionRuleListBuilder`) — drag to reorder; order = evaluation order.
Routes (from the entity's `AdminHtmlRouteProvider`): collection, `.../add`,
`.../manage/{rule}` (edit), `.../manage/{rule}/delete`.

**Permission:** `configure commerce_cart_redirection` (`restrict access: true`). It is the
entity's `admin_permission`, so it gates viewing the collection, add/edit/delete and reorder.

## Rule fields (config_export keys)

| Key | Type | Meaning |
|---|---|---|
| `id` | string | Machine name (immutable after create). |
| `label` | label | Human name; translatable via Config Translation. |
| `status` | bool | Enabled flag (core `status` key). Disabled rules are skipped. |
| `weight` | integer | Evaluation order, ascending. First matching enabled rule wins. |
| `conditions` | sequence | List of `{plugin, configuration}` Commerce **order-item** condition plugins. |
| `condition_operator` | string | `AND` (all pass) or `OR` (any passes). Constraint-limited to those two. |
| `redirect_target` | string | `checkout` (default), `cart`, or `other`. Constraint-limited. |
| `redirect_custom_url` | string | Used only when target is `other`; max 2048 chars; supports tokens. |
| `button_text` | label | Replacement "Add to cart" button text; supports tokens; empty = keep default. |
| `clear_cart` | bool | Remove all other order items before adding the new one (single-item cart). |

Config schema: `config/schema/commerce_cart_redirection.schema.yml` (so `provides_config_schema`
is true in 4.x — it was absent in 3.x).

## Conditions

The form field is `#type => commerce_conditions` restricted to `#entity_types =>
['commerce_order_item']`, so only order-item condition plugins are offered (match by product,
product type, variation, variation type, product category, etc. — whatever Commerce condition
plugins are installed). A rule with **no conditions matches every added item** (shown as
"None (matches every item)" on the listing). `applies()` fails **closed**: if a configured
condition plugin is missing, or all conditions get filtered out as non-order-item, the rule
matches nothing (it is not silently turned into a catch-all).

The rule derives config dependencies on the bundles its conditions reference
(`product_types` → `commerce_product_type`, `variation_types` →
`commerce_product_variation_type`). On dependency removal: a condition whose providing module is
uninstalled is dropped and the rule is **disabled**; deleting a referenced bundle narrows the
condition, or disables the rule if the condition would no longer restrict anything.

## Token support

If the **Token** module is enabled the form shows a token browser for
`commerce_order_item`, `commerce_product`, `commerce_product_variation`. Both the custom URL
and the button text accept these tokens. See [../api/mechanism.md](../api/mechanism.md) for how
tokens are resolved at redirect time and the open-redirect handling.

## Form validation (`RedirectionRuleForm`)

- `redirect_custom_url` is required server-side when `redirect_target === 'other'` (the client
  `#states` requirement is re-enforced in `validateForm`).
- Token-free custom URLs are validated now: external URLs via `UrlHelper::isValid(..., TRUE)`,
  otherwise the value must start with `/`. URLs **containing tokens are not validated at save
  time** — they can only be checked after replacement at redirect time, where an invalid
  result falls back to checkout.

## Manage with drush (no UI)

Rules are config entities, so manage them as config. List / inspect:

```bash
drush config:status
drush config:get commerce_cart_redirection.rule.default
```

Create by importing a single-file config (recommended), e.g. a rule that sends every item to
the cart page:

```yaml
# commerce_cart_redirection.rule.to_cart.yml
langcode: en
status: true
id: to_cart
label: 'To cart'
weight: 0
conditions: {  }
condition_operator: AND
redirect_target: cart
redirect_custom_url: ''
button_text: ''
clear_cart: false
```

```bash
drush config:import --partial --source=/path/to/dir -y   # dir containing the file above
```

## 3.x → 4.x upgrade

`commerce_cart_redirection_post_update_convert_settings_to_rule()` (run by `drush updb`)
converts the legacy `commerce_cart_redirection.settings` object into a rule with id `default`:
old `product_bundles` become an `order_item_variation_type` condition; the old `negate` option
is converted to a **snapshot** of the non-selected variation types (types created later must be
added to the rule manually); old target/custom-url/button-text/clear-cart carry over. If the
old settings redirected nothing (no selection, or negate-all), no rule is created and the old
object is deleted.
