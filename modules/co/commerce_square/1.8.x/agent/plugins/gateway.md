<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `square` payment gateway plugin

`src/Plugin/Commerce/PaymentGateway/Square.php`, annotation
`@CommercePaymentGateway(id="square", label="Square")`. It is a **plugin instance** of
Commerce's payment-gateway type — the module does not define a new plugin type.

## Definition highlights

```php
@CommercePaymentGateway(
  id = "square",
  label = "Square",
  display_label = "Square",
  forms = { "add-payment-method" = "…\PluginForm\Square\PaymentMethodAddForm" },
  modes = { "test" = "Sandbox", "live" = "Production" },
  js_library = "commerce_square/form",
  payment_method_types = { "credit_card" },
  credit_card_types = { "amex","dinersclub","discover","jcb","mastercard","visa","unionpay" },
)
```

Class `Square extends OnsitePaymentGatewayBase implements SquareInterface`, where
`SquareInterface` also extends `SupportsAuthorizationsInterface` and `SupportsRefundsInterface`
— so the gateway supports **authorize (+ capture)** and **refunds** in addition to plain sales.

`getApiClient()` (declared on `SquareInterface`) returns a configured `Square\SquareClient`
for the gateway's current mode, obtained through the `commerce_square.connect` service.

## defaultConfiguration()

```php
[
  'test_location_id' => '',
  'live_location_id' => '',
  'enable_credit_card_icons' => TRUE,
] + parent::defaultConfiguration();   // adds 'mode', 'display_label', etc.
```

`buildConfigurationForm()` shows an error linking to `commerce_square.settings` if no sandbox
app id/token are configured, then renders a **Location** select per mode whose options come
from a live `LocationsApi::listLocations()` call.

## OAuth production flow

`src/Controller/OauthToken.php` (route `commerce_square.oauth.obtain`) is Square's redirect
target; `SquareSettings::requestAccessToken()` performs the `ObtainTokenRequest` exchange and
stores the resulting tokens in state. See [../configure/settings.md](../configure/settings.md).

## Payment method form

`src/PluginForm/Square/PaymentMethodAddForm.php` renders the Square Web Payments card form
(attaching `commerce_square/form`, `js/commerce_square.form.js`) so the card is tokenised
client-side and only a nonce reaches Drupal.

## Grounding note

Creating/charging a real payment requires valid Square credentials and network access to
Square's API. For local reasoning, ground on the gateway **config entity** and the settings
config/state rather than on live API responses.
