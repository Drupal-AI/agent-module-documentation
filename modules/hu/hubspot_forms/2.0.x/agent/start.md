# Hubspot Forms — agent index

Fetches a HubSpot account's marketing forms via the HubSpot API and lets editors embed one through
a **block**, a **field**, a **text-format shortcode**, or a **CKEditor 5 button**. All embeds
render the `hubspot_form` theme hook → HubSpot's `hbspt.forms.create` JS. Depends on core `block` +
`field`. No own permissions, no Drush. Credentials + cache live in `hubspot_forms.settings`.

- **Admin settings: access type (API key vs Access Token), Portal ID, caching, config keys** →
  [configure/settings.md](configure/settings.md)
- **The four embed mechanisms (block, field, filter shortcode, CKEditor) and the form-id format** →
  [configure/embedding.md](configure/embedding.md)
- **The `hubspot_forms` service — `getFormIds()`, `fetchHubspotForms()`, API endpoints, caching** →
  [api/service.md](api/service.md)
- **`CollectFormsEvent` — add forms from extra HubSpot accounts** → [hooks/events.md](hooks/events.md)

Key facts:
- Config route `hubspot_forms.admin_config` (`/admin/config/services/hubspot-forms`), permission
  `administer site configuration`.
- Form option keys are `PORTAL_ID::FORM_ID` → label. API base `https://api.hubapi.com/`
  (`marketing/v3/forms/` Bearer token, or legacy `forms/v2/forms?hapikey=`). Results cached under
  cache id `hubspot_forms` for `caching` seconds (default 10800).
- Routes: block/field use core UIs; filter = plugin `hubspot_forms`; CKEditor dialog + preview
  routes are gated by `use text format <format>` access.
