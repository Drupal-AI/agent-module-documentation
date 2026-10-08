Datalayer Webform adds a Webform handler that pushes a configurable `dataLayer` event (for Google Tag Manager and similar) into the browser when a webform is submitted, with Webform token support.

---

The module provides a single Webform handler plugin, **Datalayer Webform** (`datalayer_webform`,
`src/Plugin/WebformHandler/DatalayerWebform.php`), that you attach to any webform under
*Settings → Emails / Handlers*. Its only configuration is an **event** field: a YAML snippet
(edited via a `webform_codemirror` element) describing the object to push to `dataLayer`. On
submit (`submitForm`) the handler decodes the YAML and runs it through the Webform token system
(`replaceTokens($data, $webform_submission)`), so you can inject submitted values or webform/site
tokens into the event; the result is then exposed to the page via `alterForm` as
`drupalSettings.datalayer_webform.event` with the `datalayer_webform/event` library attached. The
JS behavior (`js/event.js`) runs once per `.webform-submission-form` and calls
`dataLayer.push(settings.datalayer_webform.event)`. It depends on the
[Datalayer](https://www.drupal.org/project/datalayer) module (which sets up the `dataLayer` array)
and Webform. The handler has unlimited cardinality, so a single form can push multiple/different
events. The maintainers note it is tested primarily with the modal confirmation behavior. There is
no global config, no permissions, and no Drush.

---

- Fire a GTM `dataLayer` event when a contact form is submitted.
- Track webform conversions in Google Analytics 4 via Google Tag Manager.
- Push a custom event name (e.g. `generate_lead`) on newsletter signup.
- Include submitted field values in the dataLayer event using Webform tokens.
- Add form metadata (webform id, title) to the event via tokens.
- Attach different events to different webforms for granular tracking.
- Add multiple event handlers to one form (unlimited cardinality).
- Measure lead-generation form completions for marketing attribution.
- Send an ecommerce-style event object on an order/request form.
- Trigger tag-manager tags that listen for a specific custom event.
- Track quote-request submissions as conversions.
- Report which form variant was submitted through the event payload.
- Push a `formSubmit` event to drive downstream analytics or pixels.
- Feed CRM/marketing automation via GTM tags fired from the event.
- Integrate webform submissions with a customer data platform through the data layer.
- Track modal (AJAX) webform confirmations where a normal page-view event would not fire.
- Standardize a submission event schema across many forms via copied YAML.
- Include the submission's remote data or computed values through tokens in the event.
- Signal successful RSVP/registration to analytics.
- Instrument A/B-tested forms by pushing the variant in the event.
