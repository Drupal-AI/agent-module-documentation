<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Adds the `donorperfect_other` Drupal content entity for DonorPerfect "Other Info" records.

---

This submodule of the DonorPerfect project defines a `donorperfect_other` content entity mapping the DonorPerfect **Other Info** record — the free-form/miscellaneous notes tied to a donor (other date, comments and user-defined fields). Data lives in DonorPerfect (base table `dpotherinfo`, user-defined-field table `dpotherinfoudf`) and is read/written on demand through the base module's `DPQuery` XML API client and custom entity storage; nothing is duplicated into Drupal. Base fields are generated from the DonorPerfect Other Info fields selected on the base settings form. When the DonorPerfect Donor submodule is enabled, a `donor_id` entity reference to the owning `donorperfect_donor` is added. Its entity controller (`donorperfect_other.entity_controller`, priority 970) registers the type and its settings form with the base module. Requires the DonorPerfect base module.

---

- Expose DonorPerfect "Other Info" records as `donorperfect_other` Drupal content entities.
- List and view Other Info records through Views without copying data into Drupal.
- Read an Other Info record's fields (other date, comments, UDFs) in custom code via the entity API.
- Reference the owning donor through the `donor_id` entity reference (when the Donor submodule is enabled).
- Create or update DonorPerfect Other Info records from Drupal add/edit forms.
- Capture miscellaneous donor notes/attributes not covered by the donor, gift or contact records.
- Choose which DonorPerfect Other Info fields appear as entity base fields on the base settings form.
- Store custom program/eligibility data on a donor via DonorPerfect user-defined fields.
- Build reports/views over Other Info records in Drupal.
- Restrict Other Info access with the entity permissions generated for the `donorperfect_other` type.
- Prevent Other Info deletion (the base access handler forbids delete for all DonorPerfect entities).
- Show a donor's Other Info alongside their donor record.
- Keep Other Info records authoritative in DonorPerfect while surfacing them in Drupal.
- Feed Other Info data into other integrations that consume Drupal entities.
