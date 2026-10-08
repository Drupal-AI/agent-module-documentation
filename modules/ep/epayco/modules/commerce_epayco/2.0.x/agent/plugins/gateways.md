<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ePayco Commerce payment gateways

Two off-site gateway plugins under `src/Plugin/Commerce/PaymentGateway/`, both extending `OffsiteCheckoutBase`.

## Plugins

- **`epayco_standard_checkout`** — `StandardCheckout`. `label`/`display_label` "ePayco (Standard checkout)".
  `payment_method_types = {credit_card}`, `requires_billing_information = FALSE`, offsite form
  `StandardCheckoutForm`. Redirects the buyer to ePayco's checkout.
- **`epayco_onepage_checkout`** — `OnePageCheckout`. "ePayco (One page checkout)". Adds an `auto_open` checkbox
  (open the payment modal on arrival). Offsite form `OnePageCheckoutForm`; renders ePayco's on-page/iframe checkout
  via the base module's `PaymentOptionsHandler`.

## Configuration (`OffsiteCheckoutBase`)

`buildConfigurationForm()` adds a required `factory` (entity_autocomplete to `epayco_factory`) and a docs link.
`submitConfigurationForm()` forces the gateway machine id to start with `epayco_` (so ePayco payments are
identifiable) and stores `configuration['factory']` (and `auto_open` for one-page). Config schema:
`commerce_payment.commerce_payment_gateway.plugin.epayco_*` → `factory`; `…epayco_onepage_checkout` → `auto_open`.

## Outbound checkout (`PluginForm/OffsiteRedirect/OffsiteCheckoutFormBase::getPaymentParameters()`)

Builds the parameter set sent to ePayco from the **order/payment** (server-side):

- Amount, currency and tax come from `$payment->getAmount()` and the order's tax adjustments; description/invoice
  from the order id; billing from the order's billing profile.
- Credentials come from the referenced factory, unless the store overrides them (base fields `epayco_client_id`,
  `epayco_key`, `epayco_api_public_key`, `epayco_language`, `epayco_mode`).
- Standard checkout also computes `p_signature` via `GatewayHandler::getPaymentSignature()` and posts to
  `EPAYCO_STANDARD_CHECKOUT_API_URL` (or `EPAYCO_SPLIT_PAYMENTS_API_URL` when split-payment params are present, via
  `StandardCheckoutForm`). One-page passes the values to `PaymentOptionsHandler` (`OnePageCheckoutForm`).
- `p_url_response` / `response` is set to Commerce's return URL.
- `hook_commerce_epayco_payment_data_alter($payment, &$parameters)` runs last so other modules can adjust the data.

## Return handling (`onReturn()` in both gateways)

When the customer comes back to the Commerce return URL, `onReturn(OrderInterface $order, Request $request)`:

1. `getNeededPaymentValuesFromRequest($request)` (in `OffsiteCheckoutBase`) reads the ePayco response — either by
   looking the payment up on ePayco by the `ref_payco` GET parameter (`getReferenceRemoteData()`), or from the
   ePayco `x_*` fields.
2. On an accepted status it creates a `commerce_payment` in state `completed` (or `authorization` when pending)
   with `amount = $order->getTotalPrice()` and `remote_id = x_ref_payco`; on a rejected/failed status it shows an
   error message. `onCancel()` shows a resumable-checkout message.
3. `executeTransactionResponseEvent()` dispatches `GatewayTransactionEvents::EPAYCO_TRANSACTION_RESPONSE` with the
   raw values and a context that includes the created payment.

Reconciliation of payments left in `authorization` happens separately on cron / Drush — see
[../api/handler.md](../api/handler.md).
