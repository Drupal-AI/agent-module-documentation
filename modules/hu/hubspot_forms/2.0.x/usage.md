Hubspot Forms integrates a HubSpot account with Drupal so editors can pick a HubSpot marketing form from a select list and embed it — via a block, a field, a text-format shortcode, or a CKEditor 5 button — which renders using HubSpot's `hbspt.forms.create` JavaScript embed.

---

Configuration lives at `/admin/config/services/hubspot-forms` (route `hubspot_forms.admin_config`, permission `administer site configuration`). You choose an access type — legacy **API Key** (`?hapikey=`, being sunset by HubSpot) or a Private App **Access Token** (Bearer, plus a **Portal ID**) — and a cache lifetime (default 3 hours). The `hubspot_forms` service (`Drupal\hubspot_forms\HubspotForms`) calls the HubSpot API (`https://api.hubapi.com/` — `marketing/v3/forms/` for tokens, `forms/v2/forms` for keys) to fetch the account's forms, caches them under the `hubspot_forms` cache id, and exposes them as a `PORTAL_ID::FORM_ID => label` option list used by every embed mechanism. A `CollectFormsEvent` lets other modules add forms from additional HubSpot accounts. Four ways to place a form: a **Block** ("Hubspot Forms") whose config is the chosen form; a **field type** `field_hubspot_form` with a select widget (`field_hubspot_select`) and two formatters (`field_hubspot_form_formatter` renders the form, `..._formatter_label` shows the label); a **text filter** ("Hubspot Forms") that converts `[hubspot-form:FORMID]` shortcodes or `<hubspotform data-form-id="…" data-portal-id="…">` tags into the embed; and a **CKEditor 5 plugin** with an "Insert Hubspot Form" button and a modal that picks a form and shows a server-rendered preview. All mechanisms render the `hubspot_form` theme hook (`templates/hubspot-form.html.twig`), which loads HubSpot's `v2.js` and calls `hbspt.forms.create({ portalId, formId, target })`. The module defines no permissions of its own and no Drush commands; the API credentials are stored in `hubspot_forms.settings` config.

---

- Embed a HubSpot lead-capture form on a page using the "Hubspot Forms" block.
- Add a per-node HubSpot form by attaching a `field_hubspot_form` field to a content type.
- Let editors choose which HubSpot form to show from a dropdown populated from the account.
- Insert a HubSpot form inline in rich-text body content with the CKEditor 5 "Insert Hubspot Form" button.
- Embed a form in any filtered text via the `[hubspot-form:FORMID]` shortcode.
- Embed a form via a `<hubspotform data-form-id="…" data-portal-id="…">` tag in HTML source.
- Connect to HubSpot with a modern Private App Access Token + Portal ID.
- Connect via the legacy HubSpot API key (for accounts still supporting it).
- Cache the fetched form list (default 3h) to avoid hitting the HubSpot API on every render.
- Disable caching during setup to see newly created HubSpot forms immediately.
- Show a newsletter signup form in a sidebar block region.
- Place different HubSpot forms in different regions/pages via multiple block instances.
- Preview the selected form's name in the editor before saving (CKEditor modal preview).
- Display only the form label (not the embed) with the label formatter, e.g. for admin listings.
- Aggregate forms from multiple HubSpot accounts by subscribing to `CollectFormsEvent`.
- Programmatically list available forms with `\Drupal::service('hubspot_forms')->getFormIds()`.
- Reuse the same form field across many bundles for consistent contact forms.
- Localise embeds — the block passes the current language to the embed template.
- Drive a contact / demo-request form from marketing-managed HubSpot content without redeploys.
- Clear the `hubspot_forms` cache after changing credentials so the new account's forms load.
