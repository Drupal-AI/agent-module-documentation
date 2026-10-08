# Embedding a HubSpot form — the four mechanisms

Every mechanism ends up rendering the `hubspot_form` theme hook
(`templates/hubspot-form.html.twig`), which outputs a `<div id="target">` plus HubSpot's `v2.js`
and a `hbspt.forms.create({ portalId, formId, target })` call. Form identifiers use the
`PORTAL_ID::FORM_ID` key from the settings-driven option list (see
[../api/service.md](../api/service.md)).

## 1. Block

Block plugin id `hubspot_forms` (admin label "Hubspot Forms"). Place it via Block Layout or Layout
Builder. Its config form (`blockForm`) is a single **required** select of available forms
(`getFormIds()`); `build()` splits the stored `PORTAL_ID::FORM_ID` and renders the theme hook,
passing the current interface language as `#locale`.

## 2. Field

Field type `field_hubspot_form` (label "Hubspot Form", category "Hubspot"), single `form_id`
varchar column.

- Default widget `field_hubspot_select` — a select of account forms.
- Formatters: `field_hubspot_form_formatter` renders the embedded form;
  `field_hubspot_form_formatter_label` renders only the form's label.

Add the field to any fieldable bundle (Manage fields), pick the widget/formatter in Manage form /
display. Field storage schema key `field.storage_settings.field_hubspot_form` (also carries a
`form_id`).

## 3. Text-format filter (shortcode / tag)

Filter plugin `hubspot_forms` ("Hubspot Forms", `TYPE_TRANSFORM_REVERSIBLE`, weight 100). Enable it
on a text format at `/admin/config/content/formats/manage/<format>`. It rewrites two syntaxes in
filtered text into the embed:

```
[hubspot-form:FORMID]
[hubspot-form:FORMID portal_id: 1234567]      # optional space-separated attrs (name: value)
<hubspotform data-form-id="FORMID" data-portal-id="1234567"></hubspotform>
```

Shortcode attribute values are restricted by the filter regex to `[0-9a-zA-Z/]+`. A unique DOM
`target` id is generated per instance. Note: only users who can edit content in a format that has
this filter enabled can author these embeds — enabling the filter on a format available to
low-trust roles lets them inject the HubSpot embed script for a portal/form of their choosing, so
keep it on trusted (e.g. Full HTML) formats.

## 4. CKEditor 5 button

Plugin id `hubspot_forms` (CKEditor5 plugin) adds an **Insert Hubspot Form** toolbar button. Add it
to a format's CKEditor 5 toolbar. The button opens a modal (route
`hubspot_forms.ckeditor5_dialog`, permission `use text format advanced`) to pick a form; a live
preview comes from `hubspot_forms.ckeditor5_preview` (access = `use text format <format>`). The
inserted markup is the `<hubspotform …>` tag consumed by the filter (mechanism 3), so the
**Hubspot Forms filter must also be enabled** on that format for the embed to render.

## Routes summary

| Route | Path | Access |
|---|---|---|
| `hubspot_forms.admin_config` | `/admin/config/services/hubspot-forms` | `administer site configuration` |
| `hubspot_forms.dialog` | `/hubspot-forms/dialog/{filter_format}` | entity access `filter_format.use` |
| `hubspot_forms.ckeditor5_dialog` | `/hubspot-forms/ckeditor5-dialog/{uuid}` | `use text format advanced` |
| `hubspot_forms.ckeditor5_preview` | `/hubspot-forms/preview/{editor}` | `use text format <format>` |
