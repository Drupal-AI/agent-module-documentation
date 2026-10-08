<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Placing the `facebook_checkout` pane

`InitiateCheckout` only fires if the pane is part of the checkout flow the customer uses.
Enabling the module does **not** add it.

| Plugin id | `facebook_checkout` |
|---|---|
| Class | `Drupal\facebook_pixel_commerce\Plugin\Commerce\CheckoutPane\FacebookCheckout` |
| Label | *Facebook Pixel Commerce: Trigger 'InitiateCheckout' Event (order_information)* |
| `default_step` | `order_information` |
| Renders | nothing (`buildPaneForm()` returns `[]`) |

## In the UI

*Commerce → Configuration → Checkout flows*
(`/admin/commerce/config/checkout-flows`) → edit the flow → drag **Facebook Pixel Commerce:
Trigger 'InitiateCheckout' Event** into the first step **after** Login (normally *Order
information*) → **Save**.

## In config

Checkout flows are config entities named
`commerce_checkout.commerce_checkout_flow.<id>`; the panes live under
`configuration.panes`:

```yaml
# commerce_checkout.commerce_checkout_flow.default
plugin: multistep_default
configuration:
  panes:
    login:               { step: login,             weight: 0, allow_guest_checkout: true, allow_registration: false }
    facebook_checkout:   { step: order_information, weight: 1 }
    contact_information: { step: order_information, weight: 2, double_entry: true }
    billing_information: { step: order_information, weight: 3 }
    review:              { step: review,            weight: 4 }
    completion_message:  { step: complete,          weight: 5, message: {…}, display_pane_summaries: true }
    order_summary:       { step: _sidebar,          weight: 6, view: commerce_checkout_order_summary }
```

**Important:** a pane that is *absent* from `configuration.panes` is **not** disabled — it
falls back to its plugin `default_step`. `CheckoutFlowWithPanesBase::getPanes()` instantiates
every available pane and `CheckoutPaneBase::defaultConfiguration()` uses
`$this->pluginDefinition['default_step']` (only falling back to `_disabled` when that step
does not exist in the flow). So on a stock `multistep_default` flow, `facebook_checkout`
already runs on `order_information` even with no entry in the config. The real off switch is
an explicit `step: _disabled`:

```yaml
panes:
  facebook_checkout: { step: _disabled, weight: 99 }
```

Check the effective step rather than the stored array:

```bash
drush php:eval '$f = \Drupal::entityTypeManager()->getStorage("commerce_checkout_flow")->load("default");
  print $f->getPlugin()->getPane("facebook_checkout")?->getStepId() . "\n";'
```

## With Drush

```php
drush php:eval '
  $flow = \Drupal::entityTypeManager()->getStorage("commerce_checkout_flow")->load("default");
  $config = $flow->get("configuration");
  $config["panes"]["facebook_checkout"] = ["step" => "order_information", "weight" => 1];
  $flow->set("configuration", $config)->save();
'
```

Read it back:

```bash
drush cget commerce_checkout.commerce_checkout_flow.default configuration.panes
```

Remove it again:

```php
drush php:eval '
  $flow = \Drupal::entityTypeManager()->getStorage("commerce_checkout_flow")->load("default");
  $config = $flow->get("configuration");
  unset($config["panes"]["facebook_checkout"]);
  $flow->set("configuration", $config)->save();
'
```

## Creating a flow that includes it

```php
drush php:eval '
  \Drupal::entityTypeManager()->getStorage("commerce_checkout_flow")->create([
    "id" => "my_flow",
    "label" => "My flow",
    "plugin" => "multistep_default",
    "configuration" => [
      "panes" => [
        "login"             => ["step" => "login", "weight" => 0],
        "facebook_checkout" => ["step" => "order_information", "weight" => 1],
        "review"            => ["step" => "review", "weight" => 2],
      ],
    ],
  ])->save();
'
```

Then point an order type at the flow (`commerce_order.commerce_order_type.<id>` →
`checkout_flow`).

## Nothing else to configure

The submodule has no settings form and no `configure` route. The pixel id, page/role
visibility and privacy switches all come from the parent module's
`facebook_pixel.settings` — see
[../../../../2.0.x/agent/configure/settings.md](../../../../2.0.x/agent/configure/settings.md).
Note that the parent's default page-visibility list excludes `/user/*/*` and `/admin*` but
**not** `/checkout/*`, so checkout pages are tracked out of the box.
