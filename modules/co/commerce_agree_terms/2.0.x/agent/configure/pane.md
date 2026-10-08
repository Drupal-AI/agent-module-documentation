# Configure the Agree to Terms checkout pane

Plugin: `src/Plugin/Commerce/CheckoutPane/AgreeTerms.php` (`@CommerceCheckoutPane id = "agree_terms"`,
`default_step = "review"`). It is a standard Commerce checkout pane — there is no module settings
route. Enable and configure it per checkout flow.

## Enable it (UI)
*Commerce → Configuration → Checkout flows* (`/admin/commerce/config/checkout-flows`) → edit a flow →
drag **Agree to the terms and conditions** into a step (default `review`) → click its **Edit** and set
the fields below.

## Settings (defaults from `defaultConfiguration()`)
| Key | Type | Default | Purpose |
|---|---|---|---|
| `nid` | node id (entity_autocomplete, **required**) | `NULL` | Node the terms link points to (`entity.node.canonical`). |
| `link_text` | string (**required**) | `Terms and Conditions` | Visible text of the link. |
| `prefix_text` | string | `I agree with the %terms` | Checkbox label; the `%terms` token is replaced by the link. |
| `description` | string (textarea) | `''` | Optional help text under the checkbox (also shown as raw markup in the config summary). |
| `invalid_text` | string | `You must agree with the %terms before continuing` | Form error set when the box is left unchecked. |
| `new_window` | bool (checkbox) | `1` | When true the terms link gets `target="_blank"`. |

## Where config is stored
On the checkout flow config entity, under the pane id. Config schema:
`config/schema/commerce_agree_terms.schema.yml` →
`commerce_checkout.commerce_checkout_pane.agree_terms`.

Export/set with drush, e.g.:
```
drush cget commerce_checkout.commerce_checkout_flow.default
```
The pane config lives at `configuration.panes.agree_terms` inside that flow entity.

## Runtime behavior
- `buildPaneForm()` only renders the checkbox if `nid` is set; the label is
  `str_replace('%terms', <link>, prefix_text)`.
- `validatePaneForm()` calls `$form_state->setError()` with `invalid_text` when
  `terms_and_conditions` is falsy — this is what prevents checkout from completing.
- `buildConfigurationSummary()` prints the stored `description` via `Markup::create()` (raw). Only a
  user who can administer checkout flows can set that value, so it is trusted admin config.
