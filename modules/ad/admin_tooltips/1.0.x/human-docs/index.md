# Admin Tooltips — manual setup guide

**Admin Tooltips** (`admin_tooltips`) adds an extra setting to a field's
configuration where a site builder can type a tooltip / guidance text. That text
is then shown to editors as a tooltip on the field, helping them understand what
to enter — a lightweight way to add contextual help right where content is
created.

It is a content-editing / editorial-UX helper. It does not change what content is
stored or who can access anything, and it has no access-control role. All it does
is surface helpful guidance text on fields during content entry. The module is in
the Fields package and supports a very wide core range (`^8 || ^9 || ^10 || ^11`);
note the current release is a beta (`1.0.0-beta3`).

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

There is no central settings page. The tooltip setting appears **per field**, in
each field's configuration form under **Structure → Content types →** *(your
type)* **→ Manage fields**, when you edit an individual field.

## How to use it

1. Go to the field you want to annotate — for example
   **Structure → Content types → Article → Manage fields**, then edit a field.
2. In that field's settings you will find the new tooltip text setting added by
   this module. Enter the guidance you want editors to see.
3. Save the field. From then on, editors filling in that field on the content form
   see your tooltip text as help.

Repeat for each field you want to document. Because the guidance is attached to
individual fields, there is nothing to configure globally.
