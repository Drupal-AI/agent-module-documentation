<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Shipping Labels — agent index

An **API/framework** for generating, downloading and cancelling carrier shipping labels (and
scheduling carrier pickups) for `commerce_shipment` entities. It does **not** talk to any carrier
itself: a shipping-method plugin from another module (e.g. Commerce EasyPost, Commerce Shipping
Colissimo) implements this module's interfaces to do the real remote work. Depends on
`commerce_shipping`. Version **2.0.3**, core `^9 || ^10 || ^11`. Package: Commerce (shipping).
No config UI, no config schema, no own permissions.

## How it works (label generation flow)
1. Admin opens the shipment list for an order (**Commerce → Orders → *(order)* → Shipments**).
   `ShipmentListBuilder` (this module overrides commerce_shipping's) dispatches list events; the
   subscriber adds a **Labels** column, a **Pickup** column, and operation links **Generate / Cancel
   shipping labels**, **Schedule / Cancel pickup** — but only when the shipment's shipping-method
   plugin implements the relevant interface.
2. **Generate** hits `ShippingLabelController::generateLabels` (route
   `entity.commerce_shipment.generate_shipping_labels`). It calls `ShippingLabelManager::createRemoteShipment()`
   then `importLabelFiles()`, then redirects back to the shipment collection with a status message.
   - `createRemoteShipment()` → plugin `createRemoteShipment($shipment)` returns a `RemoteShipment`
     (remote id + tracking). `RemoteShipmentSubscriber` saves `shipment_label_remote_id`, sets the
     tracking code, and moves the shipment state `draft → ready`, then saves.
   - `importLabelFiles()` → plugin `getRemoteLabelFiles($shipment)` returns `RemoteLabelFile[]`
     (uri + description). `ShippingLabelImportSubscriber` `file_get_contents()`s each URI and writes
     it into **`private://shipment-label`** via `file.repository`, then stores the file ids in the
     `shipment_label` field.
3. **Cancel** (`cancelLabels`) → plugin `cancelRemoteShipment()`, then deletes the label files;
   `RemoteShipmentSubscriber` clears the remote id/tracking and sets state `→ canceled`.
4. **Pickup**: `SchedulePickupForm` is a two-step form — first submit calls plugin `getPickupRates()`
   and rebuilds with a rate radios list; second submit calls `schedulePickup()` and stores
   `shipment_pickup_*` fields. `cancelPickup` route/controller calls plugin `cancelPickup()`.

## Access & files (verified)
- All four routes (`generate-labels`, `cancel-labels`, `schedule-pickup`, `cancel-pickup`) require
  **`_entity_access: 'commerce_shipment.update'`** on the specific `{commerce_shipment}` in the path —
  gated and scoped to that shipment, not a bare permission.
- Label files use the **`private://`** stream (`shipment_label` base field, `uri_scheme: private`,
  `file_directory: shipment-label`). Downloads go through core's `file_file_download()`, which grants
  access only to users who can view the referencing shipment. No custom `hook_file_download()`.

## Base fields added to `commerce_shipment` (`.module` / `.install`)
- `shipment_label_remote_id` (string) — carrier's shipment id.
- `shipment_label` (file, unlimited, `private://shipment-label`, description_field on) — the label files.
- `shipment_pickup_remote_id`, `shipment_pickup_confirmation`, `shipment_pickup_status` (strings).
  (`hook_entity_base_field_info` for all; `update_9001` installs the three pickup fields on existing sites.)

## Key classes
- **`ShippingLabelManager`** (service `commerce_shipping_label.manager`) — orchestration:
  `createRemoteShipment`, `cancelRemoteShipment`, `importLabelFiles`, `deleteLabelFiles`, `cancelPickup`,
  plus `supportsRemoteShipments`/`supportsSchedulingPickups`/`hasRemoteId`/`getRemoteShipmentId`. It
  never writes entities directly — it dispatches events and subscribers persist the data.
- **`ShippingLabelController`** — `generateLabels`, `cancelLabels`, `cancelPickup` (each returns a
  `RedirectResponse`; catches `ShippingLabelGenerationException` into a messenger error).
- **`SchedulePickupForm`** — two-step get-rates-then-schedule form.
- **`ShipmentListBuilder`** — extends `commerce_shipping`'s list builder, wraps `render`/`buildHeader`/
  `buildRow`/`getDefaultOperations` in dispatched `ShippingLabelListEvent`s.
- Value objects: `RemoteShipment` (id, trackingNumber), `RemoteLabelFile` (uri, description),
  `ScheduledPickup` (status: unknown/scheduled/canceled, confirmation, rates, data), `ScheduledPickupRate`
  (remoteId, Price, pickupDate, description). `ShippingLabelGenerationException`.

## Integration interfaces (a carrier shipping-method plugin implements these)
- **`SupportsRemoteShipmentsInterface`** — `createRemoteShipment()`, `getRemoteShipment()`, `cancelRemoteShipment()`.
- **`SupportsImportingShippingLabelsInterface`** — `getRemoteLabelFiles(): RemoteLabelFile[]`.
- **`SupportsSchedulingPickup`** — `buildPickupSchedulingForm`, `validatePickupSchedulingForm`,
  `buildScheduledPickupFromFormSubmit`, `schedulePickup`, `getPickupRates`, `cancelPickup`.
The plugin is the one that does HTTP to the carrier, holds credentials, and controls TLS — none of that
lives in this module.

## Events (`ShippingLabelEvents`)
List: `SHIPMENT_LIST_BUILDER_{RENDER,HEADER,ROW,OPERATIONS}`. Remote shipment:
`REMOTE_SHIPMENT_{PRECREATE,CREATED,PRECANCEL,CANCELLED}`. Labels:
`SHIPMENT_LABEL_{PREIMPORT,IMPORTED,PREDELETE,DELETED}`.
**Bug to know:** `SHIPMENT_LABEL_IMPORTED` and `SHIPMENT_LABEL_PREIMPORT` are assigned the *same* string
(`…label_import.pre_import`) — a subscriber to one also fires on the other. Internal subscribers use the
constants consistently so the module still works.

## Submodule: `commerce_shipping_label_zebra`
Adds a **Print** column to the shipment list. For any `shipment_label` file ending in `.zpl` it renders
`PrintForm` (printer `<select>` + Print button carrying the file's absolute URL in `data-url`).
`js/browser-print.js` uses Zebra's proprietary **BrowserPrint** JS library to send the ZPL file to a
locally-attached Zebra printer. The BrowserPrint library is **not bundled** (proprietary EULA, not
GPL-compatible) — it must be downloaded to `libraries/zebra-browser-print-js/`; `hook_requirements`
enforces this at install.
