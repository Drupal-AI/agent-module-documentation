<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Arch Payment Transfer: bank details & complete-page output

## Configuration

Edit via the payment-methods admin: `/admin/store/settings/payment-methods/transfer`
(`PaymentMethodConfigureController::settings` → the plugin's `buildConfigurationForm()`), perm
`administer payment settings`. Values are stored in config object **`arch_payment_transfer.settings`**
(schema `arch_payment_transfer.config`).

`Transfer::buildConfigurationForm()` renders one vertical-tab group **per currency** (`default` plus
every `currency` entity except `XXX`), each with these text fields; `submitConfigurationForm()` saves
them under `currencies_variables[<currency>]`:

| Key | Required (default tab) | Meaning |
|---|---|---|
| `business_name` | yes | Account holder / business name |
| `account_number` | yes | Bank account number |
| `bank_provider` | yes | Bank name |
| `announcement` | no | Transfer reference (overridden at runtime by the order number) |
| `customer_bic` | no | BIC |
| `customer_iban` | no | IBAN |

Plus a top-level `complete_message` (textarea) shown as the confirmation message. Install defaults
(`config/install/arch_payment_transfer.settings.yml`) are empty strings.

## Complete-page rendering — `checkoutCompleteInfo()`

Implements `CheckoutCompleteInterface`, so `arch_checkout`'s complete page calls it. It:

1. Reads the typed-config definition for `arch_payment_transfer.config` and iterates its `mapping`,
   skipping `_core`, `langcode`, `complete_message`, `currencies_variables`.
2. For each key, `getTransferPaymentSettingValue()` returns the per-currency value
   (`currencies_variables[<order currency>][key]`) or the top-level default; for `announcement` it
   returns the order's `order_number`.
3. Renders each as a label/value row, then appends the **Grand Total** built from
   `order.grandtotal_gross` via `price_factory` + `price_formatter`.
4. If `complete_message` is set, overrides the status message.

## Notes

- Amounts shown come from the saved order (`grandtotal_gross`), not from any request input.
- `getElementsInfo()` field values are rendered with `$this->t($map['label'], …)` and
  `#type => html_tag` `span`/`label`; the values are admin-entered bank details (trusted operator
  input).
