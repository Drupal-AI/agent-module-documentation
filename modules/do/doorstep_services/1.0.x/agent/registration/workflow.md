<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Content model & customer-facing flow

## Install & enable

```bash
composer require drupal/doorstep_services
drush en doorstep_services -y
```

Depends on core `node`, `user`, `views`. For working email install/configure the contributed
**SMTP** module; for PDF bills the **`tecnickcom/tcpdf`** PHP library must be available (see
[../admin/management.md](../admin/management.md)). No config form of its own — the `configure`
link points at the admin request list `/admin/service-requests`.

## What install creates (`doorstep_services.install`)

`hook_install()` creates two content types and the `service_request` fields (idempotent — each
guarded by a `load`/`loadByName` check):

- **`service_provider`** — "Service Provider", no custom fields added by the module.
- **`service_request`** — "Service Request", with:

| Field | Type | Notes |
|---|---|---|
| `field_service_type` | list_string, **required** | doctor, carpenter, painter, fabricator, plumber, ac_technician, bike_mechanic, fitter, electrician |
| `field_status` | list_string, **required** | pending, in_progress, completed, cancelled |
| `field_contact_number` | string (max 15), **required** | |
| `field_customer_email` | email, **required** | |
| `field_notes` | text_long | address & notes (optional) |
| `field_preferred_time` | datetime (`datetime_type: datetime`), **required** | |

`hook_uninstall()` deletes those six field storages and both content types.
`hook_field_storage_config_install()` sets `node.field_status` storage_type to `default`.

Note: the register/edit **forms** also set/expose a `field_customer_name` value and a `mechanic`
service-type option that are **not** created by `hook_install` (no `field_customer_name` storage,
and install uses `bike_mechanic`, `fitter` instead of `mechanic`); the request title
(`Service Request from <name>`) is the reliable carrier of the customer name.

## Storage

Registrations are ordinary **`service_request` nodes**. There is no dedicated entity or custom
table; field values live in the standard `node__field_*` tables. Listings read them either through
the entity query + `loadMultiple()` or via direct `Database::getConnection()->select()` on
`node__field_contact_number` / `node__field_customer_email` / `node__field_notes`.

## Routes & permissions (customer-facing)

From `doorstep_services.routing.yml` — all four use core **`access content`**:

| Route | Path | Handler |
|---|---|---|
| `doorstep_services.customer_register` | `/doorstep-services/register` | `Form\RequestForm` |
| `doorstep_services.user_requests` | `/user-requests` | `Controller\DoorstepServicesUserRequestsController::viewUserRequests` |
| `doorstep_services.edit_service_request` | `/service-request/{node}/edit` | `Form\DoorstepServiceRequestEditForm` |
| `doorstep_services.cancel_request_form` | `/doorstep-services/cancel/{nid}` | `Form\DoorstepServicesCancelForm` |
| `doorstep_services.cancel_form` | `/service-request/cancel` | `Form\DoorstepServicesCancelForm` |

(The module also declares `manage_service_requests` and `access_content` permissions in
`doorstep_services.permissions.yml`, but no route uses them.)

## Register (`RequestForm`)

`getFormId()` = `service_request_form`. `buildForm()` renders: `name` (textfield), `email`
(email), `contact_number` (tel, default `+91`, pattern `\+91[0-9]{10}`), `service_type` (select,
sorted with `asort`), `preferred_time` (date, `#min` today), `notes` (textarea). Attaches library
`doorstep_services/service_request_form`.

`submitForm()` does `Node::create(['type' => 'service_request', 'title' => 'Service Request from
@name', 'field_customer_email' => …, 'field_contact_number' => …, 'field_service_type' => …,
'field_preferred_time' => …, 'field_notes' => …])->save()`, uses the new node id as the request id,
then `sendEmail()` (to the customer, `hook_mail` key `customer_notification`) and `notifyAdmin()`
(to `system.site.mail`, key `admin_notification`) via `@plugin.manager.mail`, and redirects to
`doorstep_services.user_requests`. New nodes are published with no `field_status` set yet
(listings treat an empty status as "new").

## My requests (`DoorstepServicesUserRequestsController::viewUserRequests`)

Entity query for `type = service_request` **and `uid = currentUser()->id()`**, sorted by `created`
DESC. Builds a `#theme => 'doorstep_services_user_requests'` render array (template
`templates/doorstep-services-user-requests.html.twig`; cells are printed with `{{ column }}` and so
are auto-escaped) with columns ID, Title, Service Type, Status, Contact Number, Email,
Address & Notes, Actions. Per-row actions: an **Edit** link (only when the row's `getOwnerId()`
matches the current user and status is not completed/cancelled) and a **Cancel Request** link;
completed → "No further actions allowed", cancelled → "Request cancelled". Attaches library
`doorstep_services/doorstep_services_user_requests`; `#cache max-age 0`.

## Edit (`DoorstepServiceRequestEditForm`)

`getFormId()` = `service_request_edit_form`. The `{node}` route parameter is an `entity:node`
upcast (falls back to loading via `current_route_match`). Fields: title, service_type, contact_number,
email, preferred_time (`#min` today), notes. `submitForm()` writes the values back with
`$node->set(...)` + `save()`, shows "The service request has been updated.", emails the admin
(key `admin_notification`), and redirects to `doorstep_services.user_requests`. `validateForm()`
is empty.

## Cancel (`DoorstepServicesCancelForm`)

`getFormId()` = `service_request_cancel_form`. `buildForm()` shows a `request_id` textfield
(defaulted from the `nid` route attribute) + submit. `submitForm()` loads the node for that id, and
if found sets `status = 0` (unpublished) and `field_status = 'cancelled'`, saves, then emails the
customer (`customer_cancellation_notification`) and admin (`admin_cancellation_notification`), and
redirects to `doorstep_services.user_requests`. If not found it shows an error.

## hook_mail

`doorstep_services_mail()` handles keys `customer_notification`, `admin_notification`,
`bill_generated`, `status_update`, `customer_cancellation_notification`,
`admin_cancellation_notification` — each just copies `$params['subject']` and `$params['message']`
into the message. Real delivery depends on your mail system (SMTP module recommended).
