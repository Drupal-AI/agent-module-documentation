<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The donorperfect_other entity

## The entity (`src/Entity/Other.php`)

`@ContentEntityType` id `donorperfect_other`, `base_table = dpotherinfo`, `udf_table =
dpotherinfoudf`, `entity_keys { id = other_id, label = other_id }`,
`admin_permission = donorperfect admin`. Handlers are the base module's `Storage`, `StorageSchema`,
`AccessControlHandler`, `ViewsData`, plus `entity`'s `EntityPermissionProvider`, this module's
`OtherViewBuilder`, and the `OtherForm` add/edit form. Links live under `/admin/donorperfect/other`
(canonical `/{id}`, `/add`, `/{id}/edit`, `/list`).

`Other` extends the base `EntityBase`, so its base fields are generated from the DonorPerfect
`dpotherinfo`/`dpotherinfoudf` fields selected on the base settings form (the DonorPerfect Other
Info record covers `other_date`, `comments` and UDFs). `baseFieldDefinitions()` additionally defines
a **`donor_id` entity_reference** to `donorperfect_donor` — but only when the `donorperfect_donor`
module is enabled.

Records are stored in DonorPerfect, not Drupal: the base `Storage`/`Query` classes route entity
loads and queries to `DPQuery`. Creating a record goes through DonorPerfect's `saveotherinfo`
procedure (then follow-up updates for extra fields) in the base client; `OtherViewBuilder::build()`
clears the default `content` array. **Delete is forbidden** for all DonorPerfect entities by the base
`AccessControlHandler`.

## Controller & settings (`src/Entity/OtherController.php`, `src/Form/SettingsForm.php`)

`OtherController` extends the base `ControllerBase`; it only declares
`ENTITY_TYPE_ID = donorperfect_other` and `getSettingsFormClass()` → the Other `SettingsForm`. It is
registered as `donorperfect_other.entity_controller`, tagged `donorperfect.entity_controller`
priority 970, so the base `ControllerService` includes it.

`SettingsForm` extends the base `EntitySettingsFormBase` with `ENTITY_TYPE_ID = donorperfect_other`,
contributing a "DonorPerfect Other Info Entities → Entity Fields" checkbox set (from `dpotherinfo` +
`dpotherinfoudf`) to the base settings form; selections save under
`donorperfect.settings:entity.donorperfect_other.fields` and rebuild the entity's base-field storage
on submit.
