<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Doorstep Services (doorstep_services) — agent index

A request-and-track platform for at-home ("doorstep") service businesses. It stores registrations
as **core nodes** (no custom entity): on install it creates the `service_provider` and
`service_request` content types and attaches six fields to `service_request`. Customers register
through a public form, get email notifications, and can view/edit/cancel their requests; admins
manage all requests, update status, bulk-delete, and email a TCPDF PDF bill on completion.

- Dependencies: core **`node`**, **`user`**, **`views`**. Core requirement `^10 || ^11`.
  License GPL-2.0-or-later. Version 1.0.2 (dir `1.0.x`). Package: none.
- External library: **`tecnickcom/tcpdf`** (used as `new \TCPDF()`; install separately).
  Email delivery expects the contributed **SMTP** module.
- No config objects, no config schema, no plugin types, no Drush commands.
- `configure` route: `doorstep_services.view_requests` (`/admin/service-requests`).

## Solution docs

- **Content model + customer-facing flow** (content types & fields, register / my-requests /
  edit / cancel routes, forms, controller, storage) →
  [registration/workflow.md](registration/workflow.md)
- **Admin management + PDF billing** (admin listing, status filter, status update, bulk delete,
  price entry, `PdfGeneratorService`, emails) → [admin/management.md](admin/management.md)

## What it provides (from source)

- **Content types** (`doorstep_services.install`, `hook_install`): `service_provider` (empty),
  `service_request` with fields `field_service_type` (list_string, 9 options), `field_status`
  (list_string: pending/in_progress/completed/cancelled), `field_contact_number` (string, max 15),
  `field_customer_email` (email), `field_notes` (text_long), `field_preferred_time` (datetime).
  `hook_uninstall` deletes those fields and both content types.
- **Routes** (`doorstep_services.routing.yml`), by permission:
  - `access content`: `customer_register` (`/doorstep-services/register`, `RequestForm`),
    `user_requests` (`/user-requests`, `DoorstepServicesUserRequestsController::viewUserRequests`),
    `edit_service_request` (`/service-request/{node}/edit`, `DoorstepServiceRequestEditForm`),
    `cancel_form` (`/service-request/cancel`) + `cancel_request_form`
    (`/doorstep-services/cancel/{nid}`), both `DoorstepServicesCancelForm`.
  - `administer site configuration`: `view_requests` (`/admin/service-requests`,
    `ServicesController::viewRequests`), `update_status_form`
    (`/admin/service-requests/update-status/{nid}`, `StatusUpdateForm`), `bulk_delete_form`
    (`/admin/doorstep-services/bulk-delete`, `BulkDeleteForm`), `price_entry_form`
    (`/doorstep-services/price-entry/{nid}`, `PriceEntryForm`).
- **Service** (`doorstep_services.services.yml`): `doorstep_services.pdf_generator` →
  `Drupal\doorstep_services\Service\PdfGeneratorService` (`generatePdfBill()`, `sendBillEmail()`).
- **Hooks** (`doorstep_services.module`): `hook_mail` (keys `customer_notification`,
  `admin_notification`, `bill_generated`, `status_update`, `customer_cancellation_notification`,
  `admin_cancellation_notification`); `hook_theme` (`doorstep_services_user_requests`).
- **Permissions** (`doorstep_services.permissions.yml`): `manage_service_requests`,
  `access_content` — both declared but **not referenced by any route** (routes use core perms).
- **Libraries** (`doorstep_services.libraries.yml`): `doorstep_services` (jQuery/once +
  `js/price_prefix.js`), `service_request_form`, `doorstep_services_user_requests`, `pdf_styles`.
