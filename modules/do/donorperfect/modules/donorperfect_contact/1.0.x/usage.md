<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Adds the `donorperfect_contact` Drupal content entity for DonorPerfect contact (activity/interaction) records.

---

This submodule of the DonorPerfect project defines a `donorperfect_contact` content entity mapping the DonorPerfect **contact** record — the log of activities/interactions with a donor (activity code, contact/due/completed dates, by-whom, comment, etc.). Data lives in DonorPerfect (base table `dpcontact`, user-defined-field table `dpcontactudf`) and is read/written on demand through the base module's `DPQuery` XML API client and custom entity storage; nothing is duplicated into Drupal. Base fields are generated from the DonorPerfect contact fields selected on the base settings form. When the DonorPerfect Donor submodule is enabled, a `donor_id` entity reference to the owning `donorperfect_donor` is added. Its entity controller (`donorperfect_contact.entity_controller`, priority 980) registers the contact type and its settings form with the base module. Requires the DonorPerfect base module.

---

- Expose DonorPerfect contact/activity records as `donorperfect_contact` Drupal content entities.
- List and view contacts through Views without copying data into Drupal.
- Read a contact's fields (activity code, dates, comment, UDFs) in custom code via the entity API.
- Reference the owning donor through the `donor_id` entity reference (when the Donor submodule is enabled).
- Create or update DonorPerfect contact records from Drupal contact add/edit forms.
- Choose which DonorPerfect contact fields appear as entity base fields on the base settings form.
- Build reports/views of donor interactions and follow-up activities.
- Restrict contact access with the entity permissions generated for the `donorperfect_contact` type.
- Prevent contact deletion (the base access handler forbids delete for all DonorPerfect entities).
- Cross-link contacts and donors in a donor-management dashboard.
- Surface upcoming/overdue contact due-dates in a Drupal View.
- Filter contacts by activity code using the metadata-cache option lists.
- Feed contact activity data into other integrations that consume Drupal entities.
- Add a contacts tab to a donor's admin page under `/admin/donorperfect`.
- Keep contact records authoritative in DonorPerfect while surfacing them in Drupal.
