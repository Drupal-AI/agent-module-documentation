# Configure the Datalayer Webform handler

No global settings. Configuration is per webform:

1. Edit a webform → *Settings → Emails / Handlers* → *Add handler* → **Datalayer Webform**.
2. Fill the **Datalayer event (YAML)** field (a `webform_codemirror` YAML editor). This is the
   object pushed to `dataLayer`.
3. Save. The handler has **unlimited cardinality**, so you can add several with different events.

## The `event` config

Stored as the handler's `event` setting (a YAML string). Example:

```yaml
event: generate_lead
form_id: '[webform_submission:webform:id]'
value: '[webform_submission:values:amount]'
lead_email: '[webform_submission:values:email]'
```

Webform/site **tokens** are supported (`tokens = TRUE` on the plugin). On submit
(`DatalayerWebform::submitForm`) the YAML is `Yaml::decode()`-ed and passed through
`$this->replaceTokens($data, $webform_submission)`, so tokens resolve against the current
submission. Use the token browser link shown on the handler form to find token names.

## What happens at runtime

- `submitForm()` computes the token-replaced `$this->eventData`.
- `alterForm()` attaches `drupalSettings.datalayer_webform.event = eventData` and the
  `datalayer_webform/event` library.
- `js/event.js` (`Drupal.behaviors.datalayerWebformEvent`) runs once per
  `.webform-submission-form` and calls `dataLayer.push(settings.datalayer_webform.event)`.

## Notes

- The global `dataLayer` array is initialized by the **Datalayer** module — ensure it is enabled
  and configured (e.g. with your GTM container) for the push to be consumed.
- Tested primarily with the **modal confirmation** behavior (per the plugin description); with a
  full-page redirect confirmation the event is pushed on the submission form render, so verify the
  event fires for your confirmation type.
- `event` is admin-authored YAML; only users who can configure webform handlers
  (Webform administrators) can set it. The event value is emitted into `drupalSettings` as
  JSON-encoded data (safe), then pushed to `dataLayer`.
