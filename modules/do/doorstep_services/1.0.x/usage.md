<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Doorstep Services is a small request-and-track platform that lets a service business take customer registrations for at-home services, notify customers and staff by email, track each request's status, and email a TCPDF-generated PDF bill when a job is completed.

---

The module ships no custom entity: on install it creates two node types — **Service Provider** (`service_provider`) and **Service Request** (`service_request`) — and attaches six fields to `service_request` (`field_service_type`, `field_status`, `field_contact_number`, `field_customer_email`, `field_notes`, `field_preferred_time`). Customers submit a request through the public form at **`/doorstep-services/register`** (`RequestForm`), which saves a `service_request` node and sends a confirmation email to the customer plus a notification to the site admin (`hook_mail` keys in `doorstep_services.module`; delivery expects the contributed **SMTP** module). Customers see their own requests at **`/user-requests`** (`DoorstepServicesUserRequestsController`, themed by the `doorstep_services_user_requests` hook and `templates/doorstep-services-user-requests.html.twig`) and can **edit** (`DoorstepServiceRequestEditForm`) or **cancel** (`DoorstepServicesCancelForm`, which unpublishes the node and sets `field_status` = `cancelled`) them. Administrators — every admin route is gated by core **`administer site configuration`** — manage all requests at **`/admin/service-requests`** (`ServicesController::viewRequests`), filter by status (`DoorstepServicesFilterForm`), change a request's status (`StatusUpdateForm`), bulk-delete requests (`BulkDeleteForm`), and, when a request is set to `completed`, enter a service price (`PriceEntryForm`) that calls `PdfGeneratorService::generatePdfBill()` + `sendBillEmail()` to build a PDF bill (via the `tecnickcom/tcpdf` library, `new \TCPDF()`) written to `public://bill_<nid>.pdf` and emailed to the customer with a copy to the site admin. Two custom permissions are declared (`manage_service_requests`, `access_content`) but the routes use core permissions. It declares no config objects, no config schema, no plugin types and no Drush commands.

---

- Offer a public sign-up page where customers request an at-home service (doctor, plumber, electrician, carpenter, painter, AC technician, etc.).
- Capture a service request's name, email, contact number, service type, preferred date and free-text address/notes.
- Store each registration as a `service_request` node so it participates in normal node storage, Views and permissions.
- Auto-create the `service_provider` and `service_request` content types and their fields on install without manual field setup.
- Send an automatic confirmation email to the customer on submission.
- Notify the site admin by email whenever a new request is submitted.
- Let a logged-in customer review their own submitted requests at `/user-requests`.
- Let a customer edit the details of one of their pending requests.
- Let a customer cancel a request, which unpublishes it, marks it `cancelled`, and emails the customer and admin.
- Give staff a single admin listing of all service requests at `/admin/service-requests`.
- Filter the admin request list by status (all / in progress / completed / cancelled).
- Update a request's status through a simple form (pending, in progress, completed, cancelled).
- Trigger a status-update email to the customer whenever staff change the status.
- Bulk-select and delete multiple service requests from the admin listing.
- Collect a service price after a job is completed and generate a printable bill.
- Produce a branded PDF bill (site name, slogan and email in the header) with TCPDF.
- Email the PDF bill to the customer and send a copy to the site admin.
- Save generated bills to the public files directory as `bill_<nid>.pdf` for later reference.
- Present service types as a normalized, alphabetically sorted select list on the request form.
- Run a straightforward service workflow on Drupal 10 or 11 without a full e-commerce stack.
- Use the contributed SMTP module to make the notification and bill emails deliverable.
