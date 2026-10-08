<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Generating & rendering invoices (services)

## `InvoiceGenerator` — build an invoice from orders

Service `commerce_invoice.invoice_generator`, interface
`Drupal\commerce_invoice\InvoiceGeneratorInterface`:

```php
public function generate(
  array $orders,                    // OrderInterface[] to invoice
  StoreInterface $store,
  ?ProfileInterface $profile = NULL, // billing profile (optional)
  array $values = [],               // extra invoice property values (e.g. 'type', 'invoice_number')
  bool $save = TRUE                 // save the invoice + items, or return unsaved
): ?InvoiceInterface;
```

Example:

```php
$generator = \Drupal::service('commerce_invoice.invoice_generator');
$invoice = $generator->generate(
  [$order],
  $order->getStore(),
  $order->getBillingProfile(),
  ['type' => 'default'],
);
```

Pass `['type' => 'credit_memo']` (or your custom type id) in `$values` to choose the invoice
type; omit `$save` to get an unsaved invoice you can adjust first. The generator copies order
items into invoice items and applies adjustments via the `PriceSplitter`.

## Automatic generation

You rarely call the generator directly for the common cases — the event subscribers do it:

- `commerce_invoice.order_placed_subscriber` (`OrderPlacedSubscriber`) — generates when an order
  is placed, if the order type has `order_placed_generation` on (see
  [../configure/invoice-types.md](../configure/invoice-types.md)).
- `commerce_invoice.order_paid_subscriber` (`OrderPaidSubscriber`) — generates on order paid.

## Rendering to PDF / files

- `commerce_invoice.print_builder` (`InvoicePrintBuilder`) — builds the printable render via
  Entity Print (`entity_print.print_builder`) and the filename generator.
- `commerce_invoice.invoice_file_manager` (`InvoiceFileManagerInterface`) — gets/creates the
  stored PDF file for an invoice using the Entity Print engine.
- `commerce_invoice.invoice_total_summary` (`InvoiceTotalSummaryInterface`) — builds the
  subtotal/adjustments/total summary used by the `commerce_invoice_total_summary` field
  formatter and the template.

## Confirmation email

- `commerce_invoice.invoice_confirmation_mail` (`InvoiceConfirmationMailInterface`) sends the
  customer email (via `commerce.mail_handler`), attaching the PDF from the file manager.
- `commerce_invoice.invoice_confirmation_subscriber` triggers it when an invoice's type has
  `sendConfirmation = TRUE`. Resend from the UI via `InvoiceConfirmationResendForm`.

## The Invoice entity

`commerce_invoice` — content entity, base table `commerce_invoice`, bundle
`commerce_invoice_type`, `admin_permission = administer commerce_invoice`,
`permission_granularity = bundle`. Load/create via the entity type manager
(`\Drupal::entityTypeManager()->getStorage('commerce_invoice')`). Storage class
`InvoiceStorage`, access handler `InvoiceAccessControlHandler`.
