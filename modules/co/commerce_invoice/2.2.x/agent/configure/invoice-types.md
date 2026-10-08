<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Invoice types & automatic generation

An **invoice type** is the config entity `commerce_invoice_type` (bundle of the
`commerce_invoice` content entity). It ties invoices to a number pattern, a workflow, and
presentation/email settings. Admin UI: `/admin/commerce/config/invoice-types` (add-form
`/admin/commerce/config/invoice-types/add`). Admin permission: `administer commerce_invoice_type`.

## Shipped invoice types

| id | label | numberPattern | workflow |
|---|---|---|---|
| `default` | Invoice | `invoice_default` | `invoice_default` |
| `credit_memo` | Credit memo | `invoice_credit_memo` | `invoice_default` |

Config object name: `commerce_invoice.commerce_invoice_type.<id>`.

## Invoice-type fields (config_export)

| Key | Meaning |
|---|---|
| `id` / `label` | machine name / human label |
| `numberPattern` | id of a `commerce_number_pattern` entity that formats the sequential invoice number (defaults `invoice_default`) |
| `workflow` | state-machine workflow id (default `invoice_default`) |
| `footerText` | text printed at the bottom of the invoice |
| `paymentTerms` | payment-terms text |
| `dueDays` | integer number of days until due |
| `logo` | UUID of a managed file used as the invoice logo |
| `sendConfirmation` | bool — email the customer when an invoice is generated |
| `confirmationBcc` | BCC address for the confirmation email |
| `privateSubdirectory` | subdirectory under the private filesystem for stored invoice PDFs |
| `traits` | Commerce entity traits attached to the bundle |

## The `invoice_default` workflow

States: `draft`, `pending`, `paid`, `refund_pending`, `refunded`, `canceled`.
Transitions: `confirm` (draft→pending), `pay` (draft|pending→paid), `refund`
(refund_pending→refunded), `cancel` (pending→canceled). Defined in
`commerce_invoice.workflows.yml` (group `commerce_invoice`).

## Create an invoice type in code / config

```php
use Drupal\commerce_invoice\Entity\InvoiceType;
InvoiceType::create([
  'id' => 'proforma',
  'label' => 'Pro forma',
  'numberPattern' => 'invoice_default',   // must reference an existing number pattern
  'workflow' => 'invoice_default',
  'footerText' => 'Not a tax invoice.',
  'sendConfirmation' => FALSE,
])->save();
```

Read it back: `drush cget commerce_invoice.commerce_invoice_type.proforma`, or
`drush config:status`. Creating a bundle also triggers the field/display and number-pattern
wiring Commerce expects.

## Automatic generation per order type

Generation isn't global — it's configured **per order type** through third-party settings that
this module adds to the order-type form (`commerce_invoice_form_commerce_order_type_form_alter`).
Stored under `commerce_order.commerce_order_type.<type>.third_party.commerce_invoice`:

| Setting | Meaning |
|---|---|
| `invoice_type` | which invoice type to generate for this order type |
| `order_placed_generation` | bool — generate an invoice automatically when an order of this type is **placed** |

`OrderPlacedSubscriber` (on order place) and `OrderPaidSubscriber` (on order paid) then call the
invoice generator. To enable auto-generation, edit the order type at
`/admin/commerce/config/order-types/<type>/edit` and set the invoice type + toggle, or set the
third-party settings directly:

```php
$ot = \Drupal::entityTypeManager()->getStorage('commerce_order_type')->load('default');
$ot->setThirdPartySetting('commerce_invoice', 'invoice_type', 'default');
$ot->setThirdPartySetting('commerce_invoice', 'order_placed_generation', TRUE);
$ot->save();
```

## Invoice item types

Managed separately at `/admin/commerce/config/invoices/invoice-item-types` (controller
`InvoiceItemTypesAdminController`), also gated by `administer commerce_invoice`.
