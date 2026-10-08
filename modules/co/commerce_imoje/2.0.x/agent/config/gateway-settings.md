<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Gateway config, credentials, modes & refunds

## Install / enable

`drush en commerce_imoje` (pulls `commerce:commerce_payment`; requires `drupal/commerce ^3`
via Composer — no third-party PHP libraries). Then add a gateway at
`/admin/commerce/config/payment-gateways` → **Add payment gateway** and choose **imoje
(Off-site redirect)** and/or **imoje Blik**.

## The gateway plugins

Both are `@CommercePaymentGateway` plugins extending `ImojeOffsitePaymentGatewayBase`:

| id | class | label | forms.offsite-payment |
|----|-------|-------|-----------------------|
| `imoje_redirect` | `Plugin/Commerce/PaymentGateway/ImojeRedirect` | imoje (Off-site redirect) / display "imoje" | `PluginForm/ImojeRedirect/ImojePaymentForm` |
| `imoje_blik` | `Plugin/Commerce/PaymentGateway/ImojeBlik` | imoje Blik / display "Blik" | `PluginForm/ImojeBlik/ImojeBlikForm` |

Both declare `modes = { test = "Sandbox", live = "Production" }`,
`payment_type = "imoje_checkout"`, and `requires_billing_information = TRUE`, and implement
`SupportsRefundsInterface`.

## Configuration keys

Set in `ImojeOffsitePaymentGatewayBase::buildConfigurationForm()` /
`submitConfigurationForm()`, on top of the Commerce base plugin config (`mode`,
`display_label`, `collect_billing_information`, etc.):

| key | UI field | notes |
|-----|----------|-------|
| `merchant_id` | Merchant Identification (textfield, required) | imoje merchant number, used in API paths |
| `service_id` | Service Identification (textfield, required) | imoje service id, sent as `serviceId` |
| `service_key` | Service Key (textfield, required) | secret used to sign the outbound paywall request and to **verify** the inbound IPN signature |
| `token` | Authorization token (textfield, required) | imoje API key; sent as `Authorization: Bearer <token>` on REST calls |
| `payment_methods` | Payment methods (multiselect, `imoje_redirect` only) | card / pbl / blik / imoje_paylater / lease / wt → imoje `visibleMethod` |

The form also renders help links to the imoje panel (`imoje.ing.pl`,
`sandbox.imoje.ing.pl`) and a warning showing the notification URL to register in the imoje
panel: `<site>/payment/notify/{machine_name}`.

## Credentials handling

Credentials are stored in the `commerce_payment_gateway` config entity, following the
standard Commerce payment-gateway pattern; editing the gateway requires the
`administer commerce_payment_gateway` permission. They are used only server-side (the API
token as a Bearer header, the service key for signing/verification) and are never emitted to
the browser or `drupalSettings`. Keep exported configuration out of public version control,
and prefer supplying secrets via environment/config-override on production rather than
committing them.

## Modes

`getMode()` (`test` vs `live`) selects imoje environments throughout: the paywall
(`sandbox.paywall.imoje.pl` vs `paywall.imoje.pl`) and the REST API
(`sandbox.api.imoje.pl/v1` vs `api.imoje.pl/v1`). Use **test** with the sandbox panel while
integrating, then switch to **live**.

## Workflow & states

Payment type `imoje_checkout` uses workflow `payment_imoje_checkout`
(`commerce_imoje.workflows.yml`, group `commerce_payment`): states
new / pending / completed / partially_refunded / refunded / cancelled / rejected, with
transitions create, receive, partially_refund, refund, cancel, reject. The IPN maps imoje's
`settled` status to `completed`.

## Refunds

Full and partial refunds are issued from the Drupal order/payment admin.
`canRefundPayment()` allows a refund only when the payment is in the `completed` state;
`refundPayment()` calls `ImojeGateway::refundTransaction()` (POST
`/merchant/{merchant_id}/transaction/{remoteId}/refund`), with the refund amount computed
server-side. imoje then posts a `type: refund` IPN which records the refunded amount and sets
`refunded` / `partially_refunded`.

## Notification address (imoje panel)

For payments to be confirmed, register the notification URL
`<site>/payment/notify/{payment_gateway_id}` in the imoje panel (Stores → your shop →
Details → Data for integration → Notification address). Without it, imoje never posts the
IPN that creates the payment record.
