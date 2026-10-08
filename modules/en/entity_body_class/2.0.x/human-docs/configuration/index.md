# Configuration

Entity body class works as soon as it is enabled — the "Body CSS class(es)" field is
added automatically. What remains is deciding who can use it, whether to set default
values, and where the field shows up on your forms.

## Permissions

The module defines two permissions, set at **People → Permissions**
(`/admin/people/permissions`):

- **Manage body class fields** — controls who can *see and edit* the "Body CSS
  class(es)" field on entity forms. Grant this to the roles that should be able to
  set body classes on content.
- **Manage body class settings** — controls who can add **default values** on the
  settings page below. Keep this to trusted administrators.

## Set default values

1. Log in as a user with the **Manage body class settings** permission.
2. Go to **Configuration → Content authoring → Body class settings**, or navigate
   directly to `/admin/config/content/body-class-settings`.
3. Configure the default class value(s) you want applied. Because the field supports
   **tokens**, you can use tokens here to generate classes dynamically rather than
   hard-coding a single string.
4. Save the form.

Values are filtered against XSS by a validation callback before they are rendered
into the `<body>` markup, so unsafe input is stripped.

## Control where the field appears

The "Body CSS class(es)" field is a **base field**, so it shows on the forms of all
supported entity types by default. To hide it for a particular bundle, go to
**Structure → (entity type) → (bundle) → Manage form display** and move the field
into the **Disabled** region. That removes it from the edit form for that bundle
without affecting others.
