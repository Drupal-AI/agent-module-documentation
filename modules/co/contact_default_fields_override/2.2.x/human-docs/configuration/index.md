# Configuration

This module has no global settings form. Instead, it adds the four default contact
fields to each contact form's **Manage fields** page, and you configure the
overrides there — per form, so different contact forms can present their default
fields differently.

## Open a contact form's fields

1. Log in as a user who can administer contact forms (an administrator by
   default).
2. Go to **Structure → Contact forms** (`/admin/structure/contact`).
3. Click **Manage fields** on the form you want to adjust (or edit the form and
   open its **Manage fields** tab). The direct path is
   `/admin/structure/contact/manage/<form>/fields`.

## Override the default fields

With the module enabled, the built-in **name**, **email**, **subject** and
**message** fields appear on this page alongside any custom fields. For each of
them you can change:

- **Label** — the text shown to visitors above the field. Use this to rename, for
  example, "Message" to "How can we help?".
- **Description** — help text shown with the field, which core normally doesn't let
  you set on these defaults.
- **Required** — whether the field must be filled in before the form can be
  submitted.

Edit the fields you want to change and save. Because the settings are stored per
contact form, the same default field can carry a different label or requirement on
each of your forms.

## What this does not change

These overrides are purely about how the default fields are labelled and whether
they're required. They do **not** change who can view or submit the contact form —
that remains governed by core's contact permissions — and the module adds no
permissions of its own.
