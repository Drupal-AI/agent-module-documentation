<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Contact Info Field provides a multi-value field type to collect contact info.

---

Contact Info Field provides a **custom Field API field type** ("Contact Info") that lets any fieldable
entity store one or more contact entries in a single structured field. Each entry can hold a name,
position/role, email, phone, URL, notes, and an optional reference to a Drupal user account. Which
sub-elements are collected and which are displayed is configured per field. It is in the Custom package
and depends only on core's Field module.

Use it to attach structured contact details to content instead of free text. Add a Contact Info field to
an entity via the Field UI, enable the sub-elements you want in Manage form display, and choose a
formatter in Manage display: **one contact per line** (configurable separator), a **table of contacts**,
or a **single selected value** per entry.

---

- Provide a "Contact Info" field type.
- Store multiple contact entries per field.
- Collect name, position, email, phone, URL, notes.
- Optionally reference a user account per entry.
- Choose which sub-elements the widget collects.
- Render as one contact per line.
- Render as a table of contacts.
- Render a single selected value per entry.
- Depend only on core Field.
- Add no permissions or routes of its own.
- Configure everything through the Field UI.
- Wrap single-value fields in an inline fieldset.
- Treat an entry with no name as empty.
- Model structured contact data.
