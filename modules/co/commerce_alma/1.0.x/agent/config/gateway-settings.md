<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Gateway config, fee plans & eligibility

## Install / enable

`drush en commerce_alma` (pulls `commerce_payment`; requires `alma/alma-php-client ~1.11.2` via
Composer). Then add a payment gateway at
`/admin/commerce/config/payment-gateways` → **Add payment gateway** → choose the **Alma** plugin.

## The gateway plugin

`Plugin/Commerce/PaymentGateway/OffsitePaymentGateway`, id **`alma`**
(`@CommercePaymentGateway`, `display_label` "Alma"), extends
`OffsitePaymentGatewayBase`, implements the module's `OffsitePaymentGatewayInterface`
(which extends Commerce's `OffsitePaymentGatewayInterface` + `SupportsRefundsInterface`) and
`ContainerFactoryPluginInterface`. Its offsite form is `PluginForm/RedirectCheckoutForm`
(`offsite-payment`).

`create()` builds an `\Alma\API\Client($api_key, ['mode' => $mode])` and stores it on `$this->api`
only when both `mode` and `api_key` are already configured. `getApi()` returns it or throws
`\Exception('No Alma API client available')`.

## Configuration keys

`defaultConfiguration()` + schema `config/schema/commerce_alma.schema.yml`
(`commerce_payment.commerce_payment_gateway.plugin.alma`), on top of the base plugin config
(which provides `mode`, `display_label`, `collect_billing_information`, etc.):

| key | type | notes |
|-----|------|-------|
| `mode` | string | `test` / `live` (from base) — selects the Alma API environment via the SDK |
| `api_key` | string | Alma merchant API key for the current mode. Plain `#type: textfield`, `#required`. `trim()`ed on submit |
| `fee_plan` | string | selected Alma fee-plan key `{kind}_{installments}_{deferred_days}_{deferred_months}` (e.g. `general_3_0_0`) |
| `update_payments` | bool | default TRUE — enables the cron/queue reconciliation for this gateway |

## Fee plans (AJAX)

`buildConfigurationForm()` fetches available plans with `$this->api->merchants->feePlans()` (or, if
the client isn't built yet, from the submitted `mode`+`api_key`). Only plans with `$fee_plan->allowed`
are offered; each option is labelled via `getFeePlanLabel()` ("Payment in N times", plus a deferred
"month(s) and day(s)" suffix when the plan defers). A **Refresh fee plans** submit
(`ajaxSubmitConfigurationForm` → `setRebuild()`, callback `ajaxRefreshFeePlanOptions`) rebuilds the
`fee-plan-wrapper` container with `#limit_validation_errors` scoped to `api_key`+`mode`, so an
operator can enter a key and pull the plan list without full-form validation. If no plans are
available the form shows a "refresh / check your API key" message.

`validateConfigurationForm()` errors if no `fee_plan` was selected, and constructs a throwaway
`\Alma\API\Client(api_key, mode)` to catch a `ParamsError` ("Invalid secret key.").
`submitConfigurationForm()` persists `api_key` (trimmed), `fee_plan`, `update_payments`.

## Eligibility filter (which orders can use Alma)

`EventSubscriber/FilterPaymentGatewaysSubscriber::onFilter()` subscribes to
`PaymentEvents::FILTER_PAYMENT_GATEWAYS`. For each `alma` gateway it:
- removes the gateway when the order total is missing, zero, or **not EUR** (Alma is EUR-only);
- otherwise calls `OffsitePaymentGateway::checkOrderEligibility($order)`, which builds a
  `payments->eligibility()` query from the order total (×100), optional billing/shipping country,
  and the configured plan's installments/deferred values, and removes the gateway if no returned
  eligibility `isEligible()` (or a `RequestError` is thrown).

So Alma appears at checkout only for EUR, non-zero, Alma-eligible orders under the configured plan.
