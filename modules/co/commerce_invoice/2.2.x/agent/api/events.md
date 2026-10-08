<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Invoice events (`InvoiceEvents`)

`Drupal\commerce_invoice\Event\InvoiceEvents` defines the event names fired around the invoice
and invoice-item lifecycle, plus a filename event. Subscribe to them in a normal
`event_subscriber` service.

## Invoice events (payload: `Drupal\commerce_invoice\Event\InvoiceEvent`)

| Constant | Event name | Fired |
|---|---|---|
| `INVOICE_LOAD` | `commerce_invoice.commerce_invoice.load` | after load |
| `INVOICE_CREATE` | `commerce_invoice.commerce_invoice.create` | after create, before save |
| `INVOICE_PRESAVE` | `commerce_invoice.commerce_invoice.presave` | before save |
| `INVOICE_INSERT` | `commerce_invoice.commerce_invoice.insert` | after saving a new invoice |
| `INVOICE_UPDATE` | `commerce_invoice.commerce_invoice.update` | after saving an existing invoice |
| `INVOICE_PREDELETE` | `commerce_invoice.commerce_invoice.predelete` | before delete |
| `INVOICE_DELETE` | `commerce_invoice.commerce_invoice.delete` | after delete |

## Invoice item events (payload: `InvoiceItemEvent`)

Same seven suffixes on `commerce_invoice.commerce_invoice_item.*`: `INVOICE_ITEM_LOAD`,
`INVOICE_ITEM_CREATE`, `INVOICE_ITEM_PRESAVE`, `INVOICE_ITEM_INSERT`, `INVOICE_ITEM_UPDATE`,
`INVOICE_ITEM_PREDELETE`, `INVOICE_ITEM_DELETE`.

## Filename event

| Constant | Event name | Payload | Use |
|---|---|---|---|
| `INVOICE_FILENAME` | `commerce_invoice.filename` | `InvoiceFilenameEvent` | customize the generated PDF filename |

## Example subscriber

```php
namespace Drupal\mymodule\EventSubscriber;

use Drupal\commerce_invoice\Event\InvoiceEvent;
use Drupal\commerce_invoice\Event\InvoiceEvents;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;

class SyncInvoiceSubscriber implements EventSubscriberInterface {
  public static function getSubscribedEvents(): array {
    return [InvoiceEvents::INVOICE_INSERT => 'onInsert'];
  }
  public function onInsert(InvoiceEvent $event) {
    $invoice = $event->getInvoice();
    // e.g. push $invoice->getInvoiceNumber() to an accounting system.
  }
}
```

Register the class as a service tagged `event_subscriber`. `InvoiceEvent::getInvoice()` returns
the `InvoiceInterface`; `InvoiceFilenameEvent` exposes/sets the filename.
