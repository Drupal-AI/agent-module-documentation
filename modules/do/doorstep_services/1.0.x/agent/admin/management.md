<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Admin management & PDF billing

All routes here are gated by core **`administer site configuration`**
(`doorstep_services.routing.yml`). There is no dedicated settings form; the `configure` link points
at the request listing.

| Route | Path | Handler |
|---|---|---|
| `doorstep_services.view_requests` | `/admin/service-requests` | `Controller\ServicesController::viewRequests` |
| `doorstep_services.update_status_form` | `/admin/service-requests/update-status/{nid}` | `Form\StatusUpdateForm` |
| `doorstep_services.bulk_delete_form` | `/admin/doorstep-services/bulk-delete` | `Form\BulkDeleteForm` |
| `doorstep_services.price_entry_form` | `/doorstep-services/price-entry/{nid}` | `Form\PriceEntryForm` |

## The request listing (`ServicesController::viewRequests`)

Renders (a) a status filter form and (b) a `#type => 'table'` of all `service_request` nodes
(entity query, sorted `created` DESC). Extra columns (contact number, email, notes) are pulled in
bulk with `Database::getConnection()->select('node__field_contact_number' | '…_customer_email' |
'…_notes', …)->fetchAllKeyed()`. Table cells use the core table theme (auto-escaped). Per-row
**Edit** action links to `update_status_form`; rows with status `completed` show "No further
actions allowed" and `cancelled` show "Request cancelled". A **Delete requests** link
(`doorstep_services.bulk_delete_form`) is rendered below via `renderer->renderInIsolation()`.
`#cache max-age 0`.

## Status filter (`DoorstepServicesFilterForm`)

`getFormId()` = `service_request_filter_form`. A `status` select (all / in_progress / completed /
cancelled) + Filter submit; `submitForm()` just `setRebuild(TRUE)`. The controller reads the chosen
status from `request->get('status', 'all')` and adds a `field_status` condition to the query unless
it is `all`.

## Status update (`StatusUpdateForm`)

`getFormId()` = `status_update_form`. `buildForm($form, $form_state, $nid)` loads the node (redirects
to the listing if not found), shows a `status` select (pending / in_progress / completed / cancel)
defaulted to the current `field_status`, plus a hidden `nid`. `submitForm()`:

1. `Database` `update('node__field_status')` set `field_status_value` where `entity_id = nid`, then
   also loads the node and `$node->set('field_status', $status)->save()`.
2. Emails the customer with `sendStatusUpdateEmail()` (`hook_mail` key `status_update`).
3. If the new status is `completed`, redirects to `doorstep_services.price_entry_form` (to bill);
   otherwise shows a confirmation and redirects to the listing.

Constructor DI: `@plugin.manager.mail`, `@config.factory`, `@current_user`, `@entity_type.manager`,
`@database`, `@doorstep_services.pdf_generator`.

## Bulk delete (`BulkDeleteForm`)

`getFormId()` = `doorstep_services_bulk_delete_form`. Lists all `service_request` nodes as a
`checkboxes` element (plus a "Select All" JS checkbox), Delete Selected (`#button_type danger`).
`submitForm()` loads each selected node and `->delete()`s it, then redirects to the listing.

## Price entry (`PriceEntryForm`)

`getFormId()` = `price_entry_form`. `buildForm($form, $form_state, $nid)` loads the node (redirect
if missing), attaches library `doorstep_services/doorstep_services` (the `price_prefix.js` behavior
wraps `.price-input`), shows a required `price` textfield + hidden `nid`. `submitForm()` calls
`pdfGenerator->generatePdfBill($node, $price, 'INR')` then `pdfGenerator->sendBillEmail($node,
$pdf_path)`, shows a confirmation and returns to the listing.

## PDF billing service (`Service\PdfGeneratorService`)

Service id `doorstep_services.pdf_generator`; DI: `@plugin.manager.mail`, `@config.factory`,
`@current_user`, `@messenger`, `@string_translation`, `@extension.list.module`.

- **`generatePdfBill(Node $node, $price, $currency = 'INR')`** — throws
  `\InvalidArgumentException` on empty price. Builds a `new \TCPDF()` document (header from
  `system.site` name/slogan/mail), inlines `css/pdf_styles.css`, writes an HTML bill (request id,
  service type, status, contact number, email, address & notes, `<currency> <price>`), and
  `Output()`s it to **`public://bill_<nid>.pdf`** (mode `F`), returning that path. **Requires the
  `tecnickcom/tcpdf` library** — it references the global `\TCPDF` class directly, so if the library
  is absent this call fatals.
- **`sendBillEmail(Node $node, $pdf_path)`** — sends `hook_mail` key `bill_generated` to the
  customer (`field_customer_email`) and a separate copy to the site admin (`system.site.mail`), each
  with the PDF attached (`filecontent` = `file_get_contents($pdf_path)`, `filemime`
  `application/pdf`). Attachment delivery needs a mail backend that honors `params['attachments']`
  (e.g. the SMTP module). Errors are surfaced via the messenger.

`StatusUpdateForm` also contains its own `sendBillEmail()`/`sendStatusUpdateEmail()` helpers, but
the completion → bill path goes through `PriceEntryForm` → `PdfGeneratorService`.

## Operating notes

- Enable and configure **SMTP** so notification and bill emails (and the PDF attachment) are
  actually delivered; without a working mail backend the messages are silently unsent.
- Install **`tecnickcom/tcpdf`** before using the completed-request billing flow.
- Generated bills accumulate in the public files directory as `bill_<nid>.pdf`.
