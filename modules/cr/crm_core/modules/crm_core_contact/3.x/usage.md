CRM Core Contact adds Individual (person) and Organization (company) contact entities, each with configurable bundle types and designated primary fields.

---

This is the core submodule of the CRM Core suite. It defines two revisionable, publishable,
ownable content entities — `crm_core_individual` and `crm_core_organization` — plus their config
bundle entities `crm_core_individual_type` and `crm_core_organization_type`. Individuals carry a
`name` field (from the Name module); Organizations carry a plain string name. Both support Field
UI, so administrators add address, email, phone and any other fields per type, then flag which
field is the "primary" address / email / phone for programmatic access via `getPrimaryAddress()`,
`getPrimaryEmail()` and `getPrimaryPhone()`. Permissions are generated per entity and per bundle
through CRM Core's permission builder. Three action plugins (`type = crm_core_contact`) ship for
merging contacts, joining contacts into a household and emailing contacts, though the merge/join
actions depend on the contributed `relation` module and reference legacy classes. Listings live at
`/crm-core/individual` and `/crm-core/organization`; type admin lives under
`/admin/structure/crm-core`.

---

- Store people as **Individual** contacts and companies as **Organization** contacts.
- Create multiple **individual types** (Customer, Lead, Volunteer, …) as bundles.
- Create multiple **organization types** (Supplier, Household, Partner, …) as bundles.
- Add address, email, telephone and custom fields to any contact type via **Field UI**.
- Nominate **primary** address / email / phone fields per type for quick access in code.
- Automatically derive an Individual's **label** from its formatted Name field.
- Track a full **revision history** on both contact entities (`show_revision_ui`).
- Mark contacts **active/inactive** with the published (`status`) base field.
- Assign an **owner** (Drupal user) to each contact; support "own" vs "any" permissions.
- Apply per-bundle **create / edit / view** permissions to individuals and organizations.
- List and manage individuals at `/crm-core/individual`, organizations at `/crm-core/organization`.
- Theme contact pages with template suggestions (`crm_core_individual__{bundle}`, etc.).
- **Merge** duplicate contacts into a chosen primary record (with the `relation` module).
- **Join** several contacts into a new **household** organization contact.
- **Email** a selected set of contacts using tokens against their primary email.
- Expose contacts to **Views** for custom listings and reports.
- Lock a contact type (`locked`) so it cannot be edited or deleted.
- React to merges via `hook_crm_core_contact_merge_contacts()`.
- Provide a base for CRM Core Activity, Match and User Sync, which all reference these entities.
