# Plugins — HubSpot Webform handler

`src/Plugin/WebformHandler/HubspotWebformHandler.php`, id `hubspot_webform_handler`
(`@WebformHandler`, category "External", cardinality **unlimited**, results processed). This is
the primary way to push webform data to HubSpot. The module defines no plugin *types* of its own;
it implements Webform's handler plugin.

## Adding & configuring
Add the "HubSpot Webform Handler" to a webform (Webform → Settings → Emails/Handlers → Add
handler). Configuration form (`buildConfigurationForm`):
- If `hubspot.hubspot` service `isConfigured()` is false, the form only shows a notice linking to
  the settings page — connect OAuth first.
- **Choose a hubspot form** (`hubspot_form`) — a select populated live from
  `Hubspot::getHubspotForms()` (keyed by form GUID). Stored as `form_guid`.
- **Field mapping** — per HubSpot field, pick the webform element to map. Non-submittable elements
  (`webform_actions`, `markup`, `wizard_page`, sections, etc.) are excluded.
- **Legal consent** (`legal_consent`) — `include`: `never` / `always` / driven by a source element
  + option (e.g. a consent checkbox / terms-of-service element).
- **Subscriptions** (`subscriptions`) — map webform values to HubSpot email subscription type IDs,
  each `always` or driven by an element/option.

Config schema: `webform.handler.hubspot_webform_handler` (`form_guid`, `field_mapping`,
`legal_consent`, `subscriptions`) in `config/schema/hubspot.schema.yml`.

## Submission behaviour
On submit the handler builds `$form_values` from the mapping, then calls
`Hubspot::submitHubspotForm($form_guid, $form_values, $context, $request_body)`:
- **Files**: `managed_file` / `webform_document_file` values are loaded as File entities and
  passed through; the service uploads them to HubSpot's file API and substitutes the returned URL.
- **Entity references**: replaced with `->label()`.
- **Multi-values / arrays**: imploded to a `;`-separated string.
- **Context** added by the service: `ipAddress` (client IP), `pageUri` (referer header), and
  `hutk` (the `hubspotutk` cookie) when present.
- **Legal consent** → `request_body['legalConsentOptions']['consent']` with `consentToProcess` and
  text; **subscriptions** → `...['consent']['communications'][]` entries with `subscriptionTypeId`.
- Response 200/204 → logged as success; other/none → notice logged; on debug mode the raw response
  is emailed. `HubspotException` is caught and logged.

## Notes
- Requires OAuth connection (refresh token in state) and the `forms` (and file/contacts) scopes on
  the HubSpot app.
- The GUID dropdown and field lists come from HubSpot at config time, so the HubSpot form must
  exist before mapping.
