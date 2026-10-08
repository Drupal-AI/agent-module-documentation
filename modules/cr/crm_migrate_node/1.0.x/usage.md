Node Migration to CRM provides an admin UI that builds Migrate Plus migration config entities to move Drupal node content into Drupal CRM contacts and contact methods.

---

The module adds a "Node to CRM Migration" configuration page under Configuration → CRM. Site builders pick a source node content type and a destination CRM contact type on an Add form; the module creates a `migrate_plus` migration config entity tagged `crm_migrate_node` (in the `crm_migrate_node` migration group) with a `content_entity:node` source and an `entity:crm_contact` destination. An Edit form then presents a mapping table of every CRM contact field (name components, addresses, telephones, emails, status, and simple fields) against the node's fields; contact-method reference fields (emails/telephones/addresses) are split into per-bundle child migrations wired to the parent through `migration_lookup`, and multi-component Name and Address fields can be mapped whole or component-by-component. Saved migrations show up in the standard Migrate UI/Drush and are run with the usual `drush migrate:import` tooling. An optional Drush command and a `crm_migrate_node_simpsons` recipe generate Simpsons sample content for testing. Both routes require the restricted `administer crm_migrate_node` permission.

---

- Build a node-to-CRM contact migration through a UI instead of hand-writing Migrate Plus YAML.
- Migrate a "Person" node content type into CRM `person` contacts.
- Migrate an "Organization" content type into CRM `organization` contacts.
- Map a node's plain title into the CRM contact's full name.
- Map a Name-field on a node whole (all components at once) to the CRM contact name.
- Map individual name components (title, given, middle, family, generational, credentials) from separate node fields.
- Migrate node email values into CRM `email` contact-method entities.
- Migrate node telephone values into CRM `telephone` contact-method entities.
- Migrate node Address-field data into CRM `address` contact-method entities, whole or per component.
- Set a fixed default value (Active/Inactive) for the CRM contact `status` field during migration.
- Assign a default CRM `crm_method_detail` (e.g. "Home", "Work") to migrated contact methods.
- Give each migration a human-readable label editable after creation.
- Keep node and contact types locked after creation to avoid accidental remapping.
- Run generated migrations from Structure → Migrations or via `drush migrate:status` / `drush migrate:import`.
- Roll back or re-import CRM contact data using standard Migrate tooling.
- Manage several node-to-CRM migrations at once, each shown as its own tab.
- Cascade-delete auto-generated child (contact-method) migrations when the parent migration is deleted.
- Seed a test/demo CRM dataset with the `crm_migrate_node_simpsons` recipe.
- Regenerate Simpsons sample node YAML from a CSV with `drush crm-migrate-node:generate-simpsons-recipe` (alias `cmnsr`).
- Point the sample-data generator at a custom CSV path or output directory.
- Prototype a CRM data model by mapping existing editorial content into contacts.
- Consolidate contact info scattered across node fields into structured CRM contact methods.
