LocalGov Forms extends the Drupal Webform module with local-government-oriented form components, sensible Webform defaults, and a plugin type for redacting personal data from submissions.

---

Part of the LocalGov Drupal distribution, LocalGov Forms bundles the pieces councils repeatedly need on top of Webform. On install it rewrites `webform.settings` to opinionated defaults (Ajax on, submit-once, disable back button, warn on unsaved changes, submission logging, plain-English confirmation, trimmed element palette). It ships custom Webform elements — a configurable UK address-lookup composite backed by Geocoder provider plugins (e.g. Ordnance Survey Places), a plain UK address composite, and a hidden lookup sub-element — plus small enhancements to core's number element (two-decimal constraint) and text elements (character-counter ARIA support). It adds a `purge_date` Webform-submission token and a `pii_redactor` plugin type (with a best-effort sample plugin) that strips names, emails, phone numbers, dates of birth and other PII from stored submissions. The companion **LocalGov Forms Date** and **Decision Tree** submodules are documented separately.

---

- Standardise Webform behaviour across a whole council site by letting install-time defaults set Ajax, submit-once, unsaved-changes warnings and submission logging for every new form.
- Give editors a cleaner Webform element palette by excluding rarely-used element types via the install-time `webform.settings` additions.
- Add a UK address-lookup field to a form so residents type a postcode/street, click *Find address*, and pick from a matched list (populates address line 1/2, town, postcode, plus hidden lat/lng/UPRN/ward).
- Use the free-to-councils Ordnance Survey Places geocoder as the address-lookup backend by installing `localgov_os_places_geocoder_provider` and selecting it on the element.
- Restrict address lookup to a single local authority using the shipped *Local custodian codes (GB)* Webform options list.
- Offer a manual address-entry fallback on the address element, shown always or only after a search, for addresses the geocoder cannot find.
- Add a simple UK address block (address 1/2, town/city, postcode) to a form without any lookup backend using the `webform_uk_address` element.
- Constrain a Webform `number` element to exactly two decimal places (currency/amount fields) with client-side normalisation and server-side re-formatting.
- Add an accessible live character counter to a textarea/textfield via the `counter_type` property.
- Show validation errors in a consistent, accessible way using the bundled `form_errors` library attached to every webform.
- Compute a submission's automatic purge date in email/confirmation text with the `[webform_submission:purge_date]` token (and `:long`, `:custom:d/m/Y`, etc.).
- Automatically redact personal data (emails, phones, numbers, DOB, name/address/gender/ethnicity fields, postcodes/emails/numbers inside textareas) from stored submissions using the best-effort PII redactor.
- Build a custom PII redaction strategy by implementing a `pii_redactor` plugin against `PIIRedactorPluginInterface`.
- Keep webforms editable in production without config-sync deleting them by pairing the module with Config Ignore (as documented in the README).
- Preserve an existing hand-tuned `webform.settings` during install by setting `$settings['localgov_forms_skip_webform_config'] = TRUE;` before enabling.
- Expose address sub-values (UPRN, ward, lat/lng) to computed Twig or downstream handlers via the address composite's hidden sub-elements.
- Provide plain-English, non-duplicated required/invalid validation wording on address elements (e.g. "You must enter an address").
- Feed captured coordinates and UPRN into case-management or GIS integrations from webform submission data.
- Present government-service intake forms (reports, applications, requests) with consistent LocalGov styling and multi-step behaviour.
- Reduce accidental double submissions on slow connections through the default submit-once behaviour.
- Localise/override address and validation messages per element from the Webform UI.
