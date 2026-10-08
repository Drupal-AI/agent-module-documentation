<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The donorperfect_gift entity

## The entity (`src/Entity/Gift.php`)

`@ContentEntityType` id `donorperfect_gift`, `base_table = dpgift`, `udf_table = dpgiftudf`,
`entity_keys { id = gift_id, label = gift_id }`, `admin_permission = donorperfect admin`. Handlers
are the base module's `Storage`, `StorageSchema`, `AccessControlHandler`, `ViewsData`, plus
`entity`'s `EntityPermissionProvider`, this module's `GiftViewBuilder`, and the `GiftForm` add/edit
form. Links live under `/admin/donorperfect/gift` (canonical `/{id}`, `/add`, `/{id}/edit`,
`/list`).

`Gift` extends the base `EntityBase`, so its base fields are generated from the DonorPerfect
`dpgift`/`dpgiftudf` fields selected on the base settings form (the DonorPerfect gift record covers
amount, gift/pledge dates, gift type, GL/solicit/campaign codes, receipt and membership fields, and
UDFs). `baseFieldDefinitions()` additionally defines a **`donor_id` entity_reference** to
`donorperfect_donor` — but only when the `donorperfect_donor` module is enabled.

Records are stored in DonorPerfect, not Drupal: the base `Storage`/`Query` classes route entity
loads and queries to `DPQuery`. Creating a gift goes through DonorPerfect's `savegift` procedure
(then follow-up updates for extra fields) in the base client; `GiftViewBuilder::build()` clears the
default `content` array. **Delete is forbidden** for all DonorPerfect entities by the base
`AccessControlHandler`.

## Controller & settings (`src/Entity/GiftController.php`, `src/Form/SettingsForm.php`)

`GiftController` extends the base `ControllerBase`; it only declares
`ENTITY_TYPE_ID = donorperfect_gift` and `getSettingsFormClass()` → the gift `SettingsForm`. It is
registered as `donorperfect_gift.entity_controller`, tagged `donorperfect.entity_controller`
priority 990, so the base `ControllerService` includes it.

`SettingsForm` extends the base `EntitySettingsFormBase` with `ENTITY_TYPE_ID = donorperfect_gift`,
contributing a "DonorPerfect Gift Entities → Entity Fields" checkbox set (from `dpgift` +
`dpgiftudf`) to the base settings form; selections save under
`donorperfect.settings:entity.donorperfect_gift.fields` and rebuild the entity's base-field storage
on submit.
