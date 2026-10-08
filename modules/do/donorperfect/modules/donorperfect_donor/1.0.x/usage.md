<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Adds the `donorperfect_donor` Drupal content entity for DonorPerfect donor records and the donor search that powers the base module's Name form element.

---

This submodule of the DonorPerfect project defines a `donorperfect_donor` content entity whose data is stored in DonorPerfect (base table `dp`, user-defined-field table `dpudf`) rather than in Drupal — it is read and written on demand through the base module's `DPQuery` XML API client and the base module's custom entity storage. Its base fields are built dynamically from the selected DonorPerfect donor fields (in the local metadata cache), plus two read-only computed fields: `name_full` ("First Last") and `name_alpha` ("Last, First" for alphabetical lists). It also ships `DonorController` (service `donorperfect_donor.entity_controller`, the highest-priority DonorPerfect entity controller), which builds validated DonorPerfect searches by donor id, name (with first-name variations), email, phone and address, and eager-loads a donor's additional address/email/phone records. The base module's Name element AJAX search calls this controller. Requires the DonorPerfect base module.

---

- Expose DonorPerfect donors as `donorperfect_donor` Drupal content entities.
- Display donor lists and single donors through Views without copying data into Drupal.
- Read a donor's fields in custom code via the entity API (`getFieldValue()`), including UDF fields.
- Show a donor's full name ("First Last") with the computed `name_full` field.
- Sort donors alphabetically with the computed `name_alpha` field ("Last, First").
- Search DonorPerfect donors by last/first name from the base module's Name form element.
- Search donors programmatically by id, name, email, phone or address via `DonorController::search()`.
- Match on first-name variations (e.g. "Bill" also finds "William") using the configured variation groups.
- Eager-load a donor's additional addresses, emails and phones with `DonorController::loadAddresses()`.
- Create or update DonorPerfect donor records from Drupal donor add/edit forms.
- Choose which DonorPerfect donor fields appear as entity base fields on the base module's settings form.
- Reference a donor from Contact, Gift and Other Info entities (they add a `donor_id` entity reference when this module is enabled).
- Build a donor lookup widget on a custom form (Name element → matches → auto-fill address/email/phone).
- Restrict donor access with the entity permissions generated for the `donorperfect_donor` type.
- Prevent donor deletion (the base access handler forbids delete for all DonorPerfect entities).
- Feed donor data into other integrations that consume Drupal entities.
