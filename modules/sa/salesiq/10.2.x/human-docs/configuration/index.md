# Configuration

## Open the settings form

Go to **Configuration → Web services → Zoho SalesIQ**
(`/admin/config/services/zohosalesiq`, config route `zohosalesiq.settings`). You
need the **Administer Zoho SalesIQ** (`administer zohosalesiq`) permission.

## Paste your widget code

The central setting is the **widget code** field. In your Zoho SalesIQ account,
copy the embed snippet Zoho gives you, and paste it into this field. The module
validates the snippet against an expected pattern, rewrites the widget URL to add
`plugin_source=drupal` (so your Zoho traffic is tagged as coming from Drupal), and
then outputs it as an inline `<script>` in the page head. Nothing is stored outside
Drupal's own (exportable) configuration.

## Display options

Alongside the widget code, the form lets you control where and how the widget
appears:

- **Enable / disable the widget** — turn the chat on or off from this one setting.
- **Tracking-only mode** — hide the chat float button so the widget only tracks
  visitors and does not offer chat. Useful if you want SalesIQ's analytics without
  the chat bubble.
- **Limit to front-end view pages** — restrict the widget to normal front-end pages,
  excluding administration and node-edit routes (and it is skipped during
  installation). Leave this on if you do not want the chat appearing while editing
  content or in the admin interface.

Save the form to apply your changes.

## What logged-in users see

For authenticated users, the module also emits a small inline script that pre-fills
the chat with the **current user's own** display name and email, so they do not have
to enter them. Because those values belong to the viewing user, there is no
cross-user data exposure here.
