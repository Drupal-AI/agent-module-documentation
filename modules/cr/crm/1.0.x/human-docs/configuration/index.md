# Configuration

CRM works as a framework you shape to fit your data. Configuration mainly means
tailoring the contact types and their fields, then setting up the access model so
that only the right people can see and edit contacts. This page shows where those
controls live.

## Configure contact types

1. Log in as an administrator.
2. Go to **Structure → CRM → Contact types**
   (`entity.crm_contact_type.collection`).

Out of the box you get three contact bundles — **Person**, **Household**, and
**Organization**. As with any Drupal entity bundle, you can add fields to each type,
adjust the form and display, and create additional contact types if your data needs
them. This is where you decide what information a contact record holds beyond the
built-in name, address, phone, and email.

You will also find related structure and settings at:

- **`/admin/structure/crm`** — the structural home for CRM entity types and bundles.
- **`/admin/config/crm`** — CRM configuration settings.
- **`/crm/contact`** — the contact portal, where you browse and manage actual
  contact records once your types are set up.

## Contact Methods and Relationships

Alongside contacts, CRM provides two supporting concepts you can configure:

- **Contact Method** — structured, fieldable contact information (address, email,
  telephone) attached to a contact.
- **Relationship** — links one contact to another through a configurable, fieldable
  **Relationship Type** (for example head of household, spouse, employee, member).
  Define the relationship types your organization uses so staff can record how
  contacts relate to one another.

## Review the access model (important)

CRM stores **personal data (PII)** — names, contact details, and relationships
between real people. Before you start entering real contacts:

- **Permission-gate access tightly.** CRM provides its own permissions; grant view
  and edit access only to the staff who genuinely need it.
- **Meet your privacy obligations.** Retention, consent, and privacy rules such as
  GDPR apply to the data you store here.
- **Verify the model matches your requirements.** Confirm that the configured access
  model reflects your organization's data-protection policy before going live.

## Drush

CRM ships its own Drush commands to help with setup and administration; run
`drush list` (or `ddev drush list`) after enabling the module to see the commands it
registers.
