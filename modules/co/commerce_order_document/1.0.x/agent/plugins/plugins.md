<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Plugins — order-document plugin type, base class, email, entity_print, events

## Plugin type

`commerce_order_document.plugin_type.yml` declares the `commerce_order_document.order_document` plugin
type. Discovery:

- Namespace: `Plugin/Commerce/OrderDocument`
- Annotation: `@CommerceOrderDocument` (`src/Annotation/CommerceOrderDocument.php`) — required props
  `id`, `label`, `display_label` (enforced in `OrderDocumentManager::processDefinition`).
- Manager service: `plugin.manager.commerce_order_document` (`OrderDocumentManager`), alter hook
  `commerce_order_deocument_info` (sic — typo is in source), cache id `commerce_order_document_plugins`.
- Interface: `Plugin\Commerce\OrderDocument\OrderDocumentInterface` (extends `ConfigurableInterface`,
  `PluginFormInterface`).

## `OrderDocumentBase` (abstract)

`src/Plugin/Commerce/OrderDocument/OrderDocumentBase.php`. Injects `entity_type.manager`,
`module_handler`, `config.factory`, `current_user`, `plugin.manager.entity_print.print_engine`,
`entity_print.print_builder`, `commerce.mail_handler`, `commerce_order.order_total_summary`, `token`.
The parent config entity is passed in `configuration['_entity']` and stored as `$this->parentEntity`.

Key methods (overridable):

- `getDisplayLabel()` — customer-facing label (from `configuration['display_label']`, also the PDF filename).
- `readyForOrder($order)` — base: TRUE unless the order state is `draft`.
- `buildOrderDocument($order, $entity_print = FALSE)` — returns the render array (theme hook). **abstract-ish**: base has none; subclasses implement.
- `canDownloadDocument($order)` / `canEmailDocument($order)` — base returns FALSE; plugins opt in.
- `downloadDocument($order)` — creates the `pdf` entity_print engine and returns a `StreamedResponse`
  that calls `PrintBuilder::deliverPrintable([$parentEntity, $order], $engine, force_download, default_css)`.
  The document is streamed to the browser, never written to disk.
- `sendDocumentEmail($order, $option_values = NULL)` — base builds `to = $order->getEmail()`, a subject,
  and the rendered body, then `commerce.mail_handler->sendMail()`. Returns FALSE if any is empty.
- `buildOrderConfirmOptions($order)` — extra form elements shown on the send-confirm form.
- `sendOnOrderTransitionId($order)` — return an order transition id to auto-send on; base returns `''`.

## Built-in plugin: `default` (`DefaultOrderDocument`)

`@CommerceOrderDocument(id = "default", label = "Default", display_label = "Order Document")`.

- Config: `display_label`, `can_download` (default TRUE), `can_email` (default TRUE), `email_subject`
  (token-aware, `commerce_order` tokens; blank falls back to a store/order-number default).
- `buildOrderDocument()` themes `commerce_order_document` (or `commerce_order_document__<id>__entity_print`
  for PDF) with: `#document_id`, `#order_entity`, `#totals` (from `order_total_summary`), `#site_path`,
  rendered `#order_profiles` (billing/shipping, via profile view builder), `#shipping_information`
  (if `commerce_shipping` is on), and `#payment_method` (label or gateway display label, if
  `commerce_payment` is on).
- `buildOrderConfirmOptions()` adds a "copy me" checkbox (current user's email) on the send form.
- `sendDocumentEmail()` requires a non-empty `email_subject`; runs it through `Token::replace`; sends
  to the order email plus, if "copy me" was checked, the current user.

## Built-in plugin: `receipt` (`Receipt`)

`@CommerceOrderDocument(id = "receipt", label = "Receipt", display_label = "Receipt")`.

- Config: `send_receipt` (bool), `receipt_bcc` (email), `receipt_subject` (token-aware).
- `buildOrderDocument()` themes `commerce_order_receipt` (core Commerce's receipt theme, not this
  module's own template) with `#order_entity`, `#totals`, and `#billing_information`.
- `canDownloadDocument()`/`canEmailDocument()` return TRUE.
- `sendOnOrderTransitionId()` returns `'place'` when `send_receipt` is on → auto-emails the customer
  at order placement.
- `sendDocumentEmail()` sends to `$order->getEmail()` with `receipt_bcc`, subject via token replace
  (default `Order #<number> confirmed`).

## entity_print renderer

`src/EntityPrint/OrderDocumentRenderer.php` (registered as the entity's `entity_print` handler).
`render($entities)` shifts off the order-document config entity, then builds each order via
`getPlugin()->buildOrderDocument($order, TRUE)`. `getFilename()` produces `Order <ids> <display label>`.

## Event subscribers

- `OrderEventEmailSubscriber` (`commerce_order.post_transition`, weight -100): on any order transition,
  loads eligible documents for the order and, for each whose `sendOnOrderTransitionId()` equals the
  transition id, calls `sendDocumentEmail()`. This is how the Receipt auto-emails on `place`.
- `FilterConditionsEventSubscriber` (`commerce.filter_conditions`): removes the `order_type` condition
  from the document config form (redundant with the `orderType` field).

## Extending — add a custom document plugin

1. Create `src/Plugin/Commerce/OrderDocument/MyDoc.php` extending `OrderDocumentBase`, annotated
   `@CommerceOrderDocument(id="my_doc", label="My doc", display_label="My doc")`.
2. Implement `buildOrderDocument()` (return a render array / theme hook), and override
   `canDownloadDocument()`/`canEmailDocument()`/`sendOnOrderTransitionId()`/`buildConfigurationForm()`
   as needed.
3. Add a config-schema mapping `commerce_order_document.commerce_order_document.plugin.my_doc` if the
   plugin stores extra config.
4. Optionally subscribe to `DocumentEvents::FILTER_ORDER_DOCUMENTS`
   (`commerce_order_document.filter_order_documents`) to add/remove documents per order at runtime.
