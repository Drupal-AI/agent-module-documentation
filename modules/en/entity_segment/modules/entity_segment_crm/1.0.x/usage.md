<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
CRM Contact Segment ships a predefined `crm_contact` segment type and a first-class Segments area under CRM, making CRM Contacts a targetable audience.

---

A thin target submodule of the Entity Segment engine for the contributed CRM module. Enabling it enables `entity_segment` and `crm` and installs the `crm_contact` segment type — a `segment_type` config entity whose `target_entity_type_id` is `crm_contact`. It adds a Segments secondary local task under CRM's own `crm.admin` tab row at `/crm/segments`, pinned to the `crm_contact` type. `drupal/crm` (`^1.0@beta`) is a dependency of this submodule only. All segment machinery — the condition builder, the `field_value` plugin, resolution to contact IDs, and per-type permissions — is provided unchanged by the base module. Created for the Member Platform Initiative to help send targeted emails to CRM Contacts.

---

- Define named, reusable segments of CRM Contacts.
- Build contact audiences for targeted email campaigns.
- Segment contacts by any contact field (name, status, dates).
- Traverse contact reference fields to segment on related-entity fields.
- Manage contact segments from a Segments tab under CRM.
- Add a new contact segment with the pinned "Add segment" action.
- Restrict a View of contacts to a contact segment's audience.
- Resolve a contact segment to member IDs for an email-sending workflow.
- Test whether a contact is in a segment inside ECA automations.
- Show a contact segment's member count with tokens.
- Grant per-type contact-segment permissions (own/global CRUD).
- Ship a contact segment as install config for deploy-time availability.
- Add custom fields to the contact segment type via Field UI.
- Expose viewable contact members safely via the access-filtered audience.
- Reserve the full contact audience for trusted server-side work behind the membership permission.
