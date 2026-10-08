<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure a PayPal payment gateway

A PayPal gateway is a `commerce_payment.commerce_payment_gateway.<id>` **config entity**.
`plugin` = one of the plugin ids (see [../plugins/payment-gateways.md](../plugins/payment-gateways.md));
`configuration.mode` = `test` (Sandbox) or `live`; the rest of `configuration` holds the
credentials for that plugin.

## Via the admin UI

`/admin/commerce/config/payment-gateways/add` (permission
`administer commerce payment gateway`). Choose the plugin, set **Mode = Test**, paste the
Sandbox credentials, save. There is no module-specific configure route — the gateways use
Commerce's payment-gateway forms. (The one module route is the PayPal Credit messaging form
at `/admin/commerce/config/payment/paypal-credit`.)

## Via Drush / PHP (create a sandbox Checkout gateway)

```bash
drush php:eval '
  \Drupal\commerce_payment\Entity\PaymentGateway::create([
    "id" => "paypal_sandbox",
    "label" => "PayPal (Sandbox)",
    "plugin" => "paypal_checkout",
    "configuration" => [
      "mode" => "test",
      "payment_solution" => "smart_payment_buttons",
      "client_id" => "SANDBOX_CLIENT_ID",
      "secret" => "SANDBOX_SECRET",
      "intent" => "capture",
    ],
  ])->save();
'
```

The `plugin` and `mode` live in different places: `plugin` is a top-level property of the
config entity, `mode` is inside the `configuration` array. Credentials also go inside
`configuration`.

## Inspect an existing gateway

```bash
# List all gateways and their plugin + mode:
drush php:eval '
  foreach (\Drupal::entityTypeManager()->getStorage("commerce_payment_gateway")->loadMultiple() as $g) {
    printf("%s\tplugin=%s\tmode=%s\n", $g->id(), $g->getPluginId(), $g->getPlugin()->getMode());
  }
'

# Read one gateway'"'"'s stored config (plugin id + configuration array incl. mode/credentials):
drush config:get commerce_payment.commerce_payment_gateway.paypal_sandbox
```

`$gateway->getPluginId()` returns the plugin id (e.g. `paypal_checkout`);
`$gateway->getPlugin()->getMode()` returns `test`/`live`;
`$gateway->getPluginConfiguration()` returns the full configuration array (mode + credentials).

## Switch a gateway to live

Set `configuration.mode` to `live` and replace the credentials with live ones:

```bash
drush php:eval '
  $g = \Drupal::entityTypeManager()->getStorage("commerce_payment_gateway")->load("paypal_sandbox");
  $c = $g->getPluginConfiguration();
  $c["mode"] = "live";
  $g->setPluginConfiguration($c);
  $g->save();
'
```

**Note:** creating/inspecting the config entity works without network access. Actually
*processing* a payment (create/capture/refund) calls PayPal's REST API and needs valid
credentials + outbound connectivity.
