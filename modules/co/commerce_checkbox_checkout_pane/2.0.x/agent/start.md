<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Checkbox Checkout Pane (commerce_checkbox_checkout_pane) — agent index

Adds **one configurable checkbox** as a Drupal Commerce **checkout pane** — e.g. "I accept
the terms and conditions", an email-sharing opt-in, or any required acknowledgement — and saves
the customer's choice onto the order. Package `Commerce`. Core `^10.3 || ^11`. License
GPL-2.0-or-later. Installed **2.0.0-beta4** (version dir `2.0.x`). Maintainer: webks / DROWL.

## Dependencies

- Drupal module: **`commerce:commerce_checkout`** (from `.info.yml`) — ships with Drupal Commerce.
- No PHP libraries, no `composer.json` in the module, no other module deps.

## What it provides (from source — the whole module)

The entire module is **one plugin**: `src/Plugin/Commerce/CheckoutPane/CheckboxPane.php`, a
`@CommerceCheckoutPane` (id `commerce_checkbox_checkout_pane`, `default_step = "order_information"`)
extending `CheckoutPaneBase`. Plus a config schema and the `.info.yml`. No routes, controllers,
services, permissions, hooks, templates, JS, or install/update code.

### Configuration (pane config form — `buildConfigurationForm`/`submitConfigurationForm`)

Reachable per checkout flow at
`/admin/commerce/config/checkout/form/pane/commerce_checkbox_checkout_pane` (checkout-flow admin only).
Config keys (see `defaultConfiguration()`):

| Key | Type | Default | Meaning |
|-----|------|---------|---------|
| `pane_title` | textfield (required) | `NULL` | Pane heading; also returned by `getDisplayLabel()`. |
| `checkbox_machine_name` | machine_name (required) | `commerce_checkbox_checkout_pane` | Key the value is stored under on the order. `machineNameExists()` always returns FALSE (uniqueness never enforced). |
| `checkbox_title` | textfield (required) | `NULL` | The checkbox label shown to the customer. |
| `checkbox_description` | textarea | `NULL` | Optional help text under the checkbox. |
| `checkbox_required` | checkbox | `FALSE` | If set, customer must tick to proceed. |
| `checkbox_default` | checkbox | `FALSE` | Whether the box is pre-ticked. |
| `error_required_text` | textfield (required) | `%field is required.` | Error message when required-but-unchecked; `%field` = checkbox label. |

### Runtime behaviour (checkout pane methods)

- **`buildPaneForm()`** — renders a single `#type => checkbox`. Key = `Xss::filter(checkbox_machine_name, [])`
  (all tags stripped); `#title` = `Xss::filterAdmin(checkbox_title)`; `#description` =
  `Xss::filterAdmin(checkbox_description)`; `#default_value` from `checkbox_default`;
  `#required` from `checkbox_required`; `#weight` from the pane weight.
- **`validatePaneForm()`** — **server-side enforcement**: if `checkbox_required` is set and the
  submitted value is empty, calls `$form_state->setError()` with the (filtered) `error_required_text`,
  blocking the step. Not client-only.
- **`submitPaneForm()`** — stores the value via
  `$this->order->setData('commerce_checkbox_checkout_pane', [ <machine_name> => <0|1> ])`.
  Read it later with `$order->getData('commerce_checkbox_checkout_pane')`.
- **`buildConfigurationSummary()`** — admin summary of the config (all values interpolated through
  escaped `t()` placeholders).

### Config schema (`config/schema/commerce_checkbox_checkout_pane.schema.yml`)

Extends `commerce_checkout_pane_configuration`. Note: the schema keys drift from the plugin —
it declares `pane_description` and `checkbox_label`, and omits `checkbox_default` / `error_required_text`,
whereas the plugin uses `checkbox_title` and reads/writes `checkbox_default` / `error_required_text`
(produces harmless config-schema warnings).

## Notes for agents

- To read a customer's choice: `$order->getData('commerce_checkbox_checkout_pane')[<machine_name>]`
  returns `1` (ticked) or `0`/absent. The wrapper key is always the literal
  `commerce_checkbox_checkout_pane`, regardless of the configured machine name.
- Only one instance of this pane can be configured per checkout flow (single plugin id).
- Label/description support admin HTML (`Xss::filterAdmin`), not raw markup — safe for a
  terms link, not for scripts.
- Alternative purpose-built module for T&C: `drupal/commerce_agree_terms`.

See also: [`../usage.md`](../usage.md) (capability list) and the human setup guide under
[`../human-docs/`](../human-docs/index.md).
