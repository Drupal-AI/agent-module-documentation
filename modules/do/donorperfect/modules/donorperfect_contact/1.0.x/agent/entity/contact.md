<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The donorperfect_contact entity

## The entity (`src/Entity/Contact.php`)

`@ContentEntityType` id `donorperfect_contact`, `base_table = dpcontact`, `udf_table =
dpcontactudf`, `entity_keys { id = contact_id, label = contact_id }`,
`admin_permission = donorperfect admin`. Handlers are the base module's `Storage`, `StorageSchema`,
`AccessControlHandler`, `ViewsData`, plus `entity`'s `EntityPermissionProvider`, this module's
`ContactViewBuilder`, and the `ContactForm` add/edit form. Links live under
`/admin/donorperfect/contact` (canonical `/{id}`, `/add`, `/{id}/edit`, `/list`).

`Contact` extends the base `EntityBase`, so its base fields are generated from the DonorPerfect
`dpcontact`/`dpcontactudf` fields selected on the base settings form (the DonorPerfect contact
"save" procedure params include `activity_code`, `mailing_code`, `by_whom`, `contact_date`,
`due_date`, `due_time`, `completed_date`, `comment`, `document_path`). `baseFieldDefinitions()`
additionally defines a **`donor_id` entity_reference** to `donorperfect_donor` — but only when the
`donorperfect_donor` module is enabled.

Records are stored in DonorPerfect, not Drupal: the base `Storage`/`Query` classes route entity
loads and queries to `DPQuery`. `ContactViewBuilder::build()` clears the default `content` array
(render contacts via Views/fields). **Delete is forbidden** for all DonorPerfect entities by the
base `AccessControlHandler`.

## Controller & settings (`src/Entity/ContactController.php`, `src/Form/SettingsForm.php`)

`ContactController` extends the base `ControllerBase`; it only declares
`ENTITY_TYPE_ID = donorperfect_contact` and `getSettingsFormClass()` → the contact `SettingsForm`.
It is registered as `donorperfect_contact.entity_controller`, tagged
`donorperfect.entity_controller` priority 980, so the base `ControllerService` includes it.

`SettingsForm` extends the base `EntitySettingsFormBase` with
`ENTITY_TYPE_ID = donorperfect_contact`, contributing a "DonorPerfect Contact Entities → Entity
Fields" checkbox set (from `dpcontact` + `dpcontactudf`) to the base settings form; selections save
under `donorperfect.settings:entity.donorperfect_contact.fields` and rebuild the entity's base-field
storage on submit.
