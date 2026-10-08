CRM (Contact Relationship Management) adds native Drupal 11 contact, contact-method and relationship entities so you can manage people, households and organizations without an external CRM system.

---

CRM is a core-first contact management framework built entirely on Drupal's entity, configuration and access APIs. It provides three fieldable, revisionable content entity types — Contact (bundles: person, household, organization), Contact Method (bundles: email, telephone, address, each pointing at a parent contact), and Relationship (links two contacts via a configurable Relationship Type with symmetric or asymmetric labels, cardinality limits and valid-contact rules). Contact data (names via the Name module, addresses via Address, phones via Telephone, images via Image) is edited inline through Inline Entity Form and Primary Entity Reference widgets, so a person's emails, phones and addresses are managed on the contact form itself with one marked primary. Relationship Types can restrict which contact bundles may appear on each side and cap how many relationships of a type a contact may hold. On top of the standard per-bundle "any" permissions, CRM ships a node_access-style per-contact grant system (crm_contact_access table, hook_crm_contact_access_records() / hook_crm_contact_grants()) and a User Contact Mapping subsystem that links Drupal user accounts to person contacts, can override the user display name, mirror mapped CRM fields onto the user entity/registration form with pluggable field-access control, and grant "mapped contact" view/edit access. A /crm portal, admin listings with filtering, per-contact Relationships and Comments tabs, a contact Search plugin, Views integration, Group relation plugin, REST resource, icons, a "Simpsons" demo recipe and Drush commands round it out.

---

- Store people, households and organizations as first-class Drupal contact entities instead of nodes or external systems.
- Capture multiple emails, phone numbers and postal addresses per contact, each with a "detail" label (home, work, mobile, billing, etc.) and one flagged as primary.
- Model family and organizational structures with relationships such as head of household, spouse, sibling, parent, employee, member, supervisor or volunteer.
- Restrict a relationship type to specific contact bundles on each side (e.g. employee relationships only between a person and an organization).
- Cap the number of relationships of a given type a contact can have (e.g. one spouse, one head of household) via the relationship limit constraint.
- Use asymmetric relationship types with distinct labels for each side (e.g. "parent" / "child", "supervisor" / "supervised").
- Track when a contact or relationship is active with start/end dates and a published/status flag.
- Compute and display a contact's age from a date field with the crm_age formatter.
- Show relationship statistics (counts by type) on a contact with the crm_relationship_statistics field and formatter.
- Browse and filter contacts at /crm/contact by bundle, active status and name search.
- Give staff a dedicated /crm portal that surfaces only the CRM sections they can access.
- Grant fine-grained access per contact bundle: create/view/edit/delete "any" and per-bundle permissions, plus revision permissions.
- Extend contact access per individual record with the crm_contact_access grant API (mirrors core node access grants).
- Link Drupal user accounts to person contacts so a logged-in user can view or edit their own contact record ("mapped contact" permissions).
- Mirror selected CRM contact fields (e.g. full name, address) onto the user entity and the registration/profile form, with per-field access-control plugins.
- Optionally override a user's displayed name with the name stored on their mapped CRM contact.
- Auto-create or look up a contact when a new user registers, driven by the User Contact Mapping settings and event.
- Attach comments to contacts via the Comment integration and a per-contact Comments tab.
- Expose contacts over REST and Views for headless or reporting use cases.
- Integrate contacts with the Group module through the group_crm_contact relation plugin.
- Provide site-wide contact search through the crm_contact_search search plugin / crm_search search page.
- Bootstrap a demo dataset with the bundled crm_simpsons recipe (households, members and relationships).
- Recalculate all contact relationship statistics in bulk with the `drush crm:recalculate-statistics` command.
- Regenerate the Simpsons demo content from CSV with the `drush crm:generate-simpsons-recipe` command.
- Configure which admin theme the CRM UI uses via the CRM settings.
