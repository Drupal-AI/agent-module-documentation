<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `pei` payment gateway plugin

Class `OnsitePeiPaymentGateway`
(`src/Plugin/Commerce/PaymentGateway/OnsitePeiPaymentGateway.php`). On-site Commerce gateway
(`@CommercePaymentGateway(id="pei")`), `payment_method_types = {"pei"}`, forms
`add-payment-method` = `PeiPaymentMethodAddForm`, `edit-payment-method` = `PaymentMethodEditForm`.

## Install & enable

```bash
composer require drupal/commerce_pei   # pulls drupal/commerce ^2.25 || ^3.0
drush en commerce_pei -y               # enables commerce_payment + telephone deps
```

No settings page of its own (`configure` route = none). Configure it as a payment gateway at
`/admin/commerce/config/payment-gateways` → **Add payment gateway** → choose **Pei**.

> Operational gotcha: give the gateway the machine id **`pei`**. `PeiApi::__construct()` reads
> `commerce_payment.commerce_payment_gateway.pei` config directly; any other id means the client
> gets empty config and its `mode` `match` throws `InvalidRequestException`.

## Config keys (`defaultConfiguration()` / `buildConfigurationForm()`)

| Key | Form element | Meaning |
| --- | --- | --- |
| `merchant_id` | textfield, required | Pei merchant id for this store (sent as `merchantId`). |
| `user_id` | textfield, required | OAuth2 **client id** for the token request. |
| `password` | password, required | OAuth2 **client secret**. |
| `copy_profile_fields` | checkbox | Pre-fill the checkout form from the billing profile. |
| `mapping_issn` | select | Which `profile.customer` field supplies the SSN default. |
| `mapping_telephone` | select | Which `profile.customer` field supplies the phone default. |
| `mode` | (base) | `test` or `live` — selects staging vs. live Pei hosts. |

`validateConfigurationForm()` calls `$this->pei->authorizer->validate($mode, $user_id, $password)`
and blocks saving unless valid Pei credentials yield an OAuth token — so bad credentials are caught
at config time. `submitConfigurationForm()` persists the keys to the gateway config entity.

The `password` uses `#type => password`; Drupal's password element does not render a stored value
back into the HTML, so the saved secret is not echoed into the config form markup.

## Checkout flow (buyer-present, synchronous)

Payment-method type `pei` (`PeiPaymentMethodType`) adds three required string fields to the
payment-method entity: `telephone`, `issn` (the buyer's SSN / kennitala), `pincode`.

`PeiPaymentMethodAddForm::buildPeiForm()` drives a two-step AJAX flow (form-state `storage` gates
each step's `#access`):

1. Buyer enters **phone + SSN** → **Request confirmation**. `doRequestAccessToBuyer()` calls
   `purchaseAccess->hasAccess($issn)`; if the merchant already has standing access it auto-sets
   `pincode = '00000'` and skips the PIN, otherwise `purchaseAccess->requestAccess($issn, $phone)`
   asks Pei to SMS a PIN to the buyer.
2. Buyer enters the **PIN** → **Confirm**. `doConfirmAccessToBuyer()` calls
   `purchaseAccess->confirmAccess($issn, $pin)`. API errors surface inline via
   `$form_state->setError($element['errors'], …)`; the "errors" region is re-rendered with
   `status_messages` in `ajaxRefresh()`.

`validatePeiForm()` requires `telephone`, `issn`, `pincode` to be numeric before any API call.

## Payment creation / capture

`createPayment(PaymentInterface $payment, $capture = TRUE)`:

- Returns early when `$capture` is false (authorization-only is not supported; the buyer
  authorization already happened in the add-method flow).
- Asserts state `new`, then `$remote_id = $this->pei->orders->submit($payment)` — a synchronous
  POST to Pei `api/orders/pay`. On success sets the payment `remote_id` = Pei `orderId`, state
  `completed`, authorized time, and saves.

`createPaymentMethod()` requires `telephone`, `issn`, `pincode` in the details (throws
`InvalidArgumentException` if missing), calls `purchaseAccess->hasAccess($issn)`, and stores the
three fields on the payment method. `updatePaymentMethod()` / `deletePaymentMethod()` just
save / delete the local entity (Pei has no remote payment-method record to update or revoke).

The real charge is authorized entirely **server-side by Pei** using the merchant OAuth credentials
plus Pei's own record of the buyer's confirmed purchase access — the buyer never holds anything
that could authorize a charge on its own.

## Secret handling

`user_id` / `password` are the OAuth client id/secret, stored on the gateway config entity like
every Commerce gateway. Keep them out of exported/committed config — prefer environment-backed
values via a Key entity (see the project AGENTS.md). Always run checkout over HTTPS: this is an
on-site gateway, so the buyer submits their SSN and phone on your own pages.
