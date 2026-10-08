# Contact Info Field — manual setup guide

**Contact Info Field** (`contact_info_field`) adds a new field type — **Contact
Info** — that you can attach to content types and other fieldable entities to
collect structured contact details: a person's name, phone, email, role, and so
on. Because it's a multi-value field, a single field can hold several people's
contact information at once.

The problem it solves is modeling "who to contact" as real, structured data rather
than free text. What elements each entry collects and displays is entirely
configurable, and the collected entries can then be shown as a **list or table**,
or exported individually. It's a content-modeling / field-type module in the Custom
package, with no other module dependencies.

The module adds no permissions or access-control behavior of its own — access to
the field follows the access of the entity it lives on. Editing a Contact Info
field, like any field, is governed by who can edit that entity.

There's no central settings page. You set it up like any other field: add a
Contact Info field to an entity and configure how it collects and displays data,
as described below.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no central configuration page** — you configure it per field, on the
entity where you add it, as described below.

## Where it lives in the admin menu

Contact Info Field adds no settings page of its own. You use it through the
standard Field UI — for example **Structure → Content types → *(your type)* →
Manage fields**, then **Manage display** to control how it renders.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Go to the entity you want to add contact details to — for example a content
   type at **Structure → Content types → *(your type)* → Manage fields** — and
   click **Add field**.
3. Choose the **Contact Info** field type and give it a label. Set it to allow a
   single value or unlimited values depending on how many contacts an item should
   hold.
4. Configure which elements the field collects (name, phone, email, role, etc.).
5. On **Manage display**, choose how the collected entries are shown — for example
   as a list or a table.

From then on, editors filling in that entity get a structured contact-info field,
and visitors see the entries rendered the way you configured on Manage display.
