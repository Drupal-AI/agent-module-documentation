# Configuration

Business Identity is configured by filling in one form with your organisation's
details. Those details are then stored as site configuration and can be reused
across the site.

## Open the settings form

1. Log in as a user who holds the Business Identity permission (grant it under
   **People → Permissions** at `/admin/people/permissions` first).
2. Open the Business Identity form from the admin **Configuration** area.

## What you enter

The form collects your organisation's identity in one place:

- **Name** — the organisation's name.
- **Logo** — the organisation's logo.
- **Contact details** — how to reach the organisation.
- **Legal details** — registration and other legal information.

Fill in the fields that apply and save. Because the values are stored as
configuration, they export with the rest of your site config and stay consistent
everywhere they are used (footers, metadata, structured data, and so on).

## Permissions

The module provides its own permission controlling who may edit the identity.
Grant it under **People → Permissions** to trusted administrators only — the data
here represents your organisation, so it should not be editable by every role.
Beyond this permission the module has no access-control role.
