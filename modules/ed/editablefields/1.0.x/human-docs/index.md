# Editable Fields — manual setup guide

**Editable Fields** (`editablefields`) provides an **"Editable field"** display
formatter that renders a field's edit widget right on the entity's display — so a
user can change and save that one field without opening the full entity edit form.
The widget can show inline on the page, or behind an "Edit" link that opens it in a
modal popup.

It works by adding a single field formatter that is made available for **every**
field type. On a bundle's *Manage display* page you switch a field to the
"Editable field" formatter, choose which **form mode** supplies the widget, and
pick a behaviour. At render time the module embeds that field's widget as a small
AJAX form and saves changes back to the entity. An optional **autosave** mode
submits automatically when the field changes (on `change` for selects, `blur` for
text), hiding the update button entirely — handy for quick single-field edits on
dashboards, listings and profile pages.

Who can edit inline is controlled by the `use editablefields` permission combined
with the user's normal update access to the entity. A **Bypass access check**
option and per-case **fallback view modes** let you fine-tune what non-editors see.
The module has no third-party dependencies and no global settings page — all
configuration is per field, in the display formatter's settings.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and grant the permission.
2. [Configuration](configuration/index.md) — the formatter settings (form mode,
   inline vs popup, access, autosave), field by field.

## Where it lives in the admin menu

There is no dedicated settings page. You enable inline editing **per field** on a
bundle's *Manage display* page (for example **Structure → Content types → Article →
Manage display**). The one site-wide setting is a permission, granted at **People →
Permissions** (`/admin/people/permissions`).

## How to use it

1. Grant the **Use editablefields** permission to the roles that should be able to
   edit fields inline (see [Installation](installation/index.md)).
2. On a bundle's **Manage display**, set a field's formatter to **Editable field**,
   click the cog, choose a **form mode** and a **behaviour** (inline or popup), and
   save.
3. View an entity of that type as a user who has the permission and update access —
   the field now shows its widget (inline) or an Edit link (popup), and changes
   save without leaving the page.

See [Configuration](configuration/index.md) for every setting, including autosave
and the fallback options for users without edit access.
