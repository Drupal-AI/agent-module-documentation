# Organization Field — manual setup guide

**Organization Field** (`organization_field`) gives you a field type for storing
information about a research organization the way it appears in the
[ROR (Research Organization Registry)](https://ror.org). ROR is a community‑led
registry of open identifiers for research institutions worldwide, and this module
lets your content authors attach that data to nodes (or any fieldable entity):
the organization's name, one or more web addresses, and its ROR identifier URL.

The heart of the field is an **autocomplete widget**. As an author types an
organization name, the widget calls the module's own lookup endpoint, which in
turn queries the ROR REST API and offers matching organizations. If a name isn't
in ROR, the author can simply enter the details by hand. On display, you choose
between a simple **default formatter** and a **configurable formatter** that lets
you customize labels and how the links are shown.

Because the field is deeply tied to your content model, the module also ships a
careful uninstall path: a dedicated field‑deletion form removes every
organization field from the site before the module can be uninstalled, so you're
never left with orphaned field data.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — point the module at the ROR API and
   cap the number of autocomplete results.

## Where it lives in the admin menu

The module's settings form sits at **Configuration → Content authoring →
Organization Field** (`/admin/config/content/organization_field`), reachable by
users with the **Administer organization_field configuration** permission.

## How to use it

1. Add an **Organization** field to a content type (or other entity) under
   **Structure → Content types → *(type)* → Manage fields**, choosing the
   Organization field type.
2. On **Manage form display**, the field uses the autocomplete widget — authors
   type a name and pick a match from ROR, or fill in the details manually.
3. On **Manage display**, pick either the **default** or the **configurable**
   formatter. The configurable formatter lets you customize the name/link/
   identifier labels, how many URLs are shown, and how links open.
