<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Adds the `donorperfect_gift` Drupal content entity for DonorPerfect gift/pledge (donation) records.

---

This submodule of the DonorPerfect project defines a `donorperfect_gift` content entity mapping the DonorPerfect **gift** record — donations, pledges and pledge payments (amount, gift date, gift type, solicit/campaign codes, receipt info, etc.). Data lives in DonorPerfect (base table `dpgift`, user-defined-field table `dpgiftudf`) and is read/written on demand through the base module's `DPQuery` XML API client and custom entity storage; nothing is duplicated into Drupal. Base fields are generated from the DonorPerfect gift fields selected on the base settings form. When the DonorPerfect Donor submodule is enabled, a `donor_id` entity reference to the owning `donorperfect_donor` is added. Its entity controller (`donorperfect_gift.entity_controller`, priority 990) registers the gift type and its settings form with the base module. Requires the DonorPerfect base module.

---

- Expose DonorPerfect gifts/pledges as `donorperfect_gift` Drupal content entities.
- List and view gifts through Views without copying data into Drupal.
- Read a gift's fields (amount, dates, gift type, campaign/solicit codes, UDFs) via the entity API.
- Reference the owning donor through the `donor_id` entity reference (when the Donor submodule is enabled).
- Create or update DonorPerfect gift records from Drupal gift add/edit forms.
- Record new donations against a donor from a custom Drupal form (via the base `savegift` procedure).
- Choose which DonorPerfect gift fields appear as entity base fields on the base settings form.
- Build donation reports and giving-history views in Drupal.
- Sum or filter gifts by campaign, solicit code or gift type using metadata-cache option lists.
- Show a donor's giving history alongside their donor record.
- Restrict gift access with the entity permissions generated for the `donorperfect_gift` type.
- Prevent gift deletion (the base access handler forbids delete for all DonorPerfect entities).
- Surface recent gifts in a dashboard block backed by a View.
- Keep gift records authoritative in DonorPerfect while surfacing them in Drupal.
- Feed gift/donation data into other integrations that consume Drupal entities.
