Exports Webform submissions to Bitrix24 leads via a Webform handler with a field-mapping UI.

---

`b24_webform` extends the base `b24` module by providing a Webform handler
(`b24_webform_handler`) that pushes Webform submissions into Bitrix24 as leads. You add the handler
to any webform and, in its configuration form, map webform elements (or Drupal tokens / custom static
values) to Bitrix24 lead fields. When a submission reaches the completed state, the handler's
`postSave()` builds the mapped field set and creates the lead through the base module's
`RestManager`. A settings page at `/admin/config/b24/webform` lists all webforms and links to add or
edit the Bitrix24 handler on each. Requires the base `b24` OAuth connection and the contrib
`webform` module.

---

- Create a Bitrix24 lead automatically when a webform is submitted (completed state).
- Add the Bitrix24 handler to any individual webform.
- Map webform elements to Bitrix24 lead fields per handler.
- Use Drupal tokens (`webform`, `webform_submission`) or custom static values in the mapping.
- Support Bitrix24 multi-value (`crm_multifield`) fields.
- Handle webforms with results storage disabled (still exports on completion).
- List all webforms and their Bitrix24 handler status from one settings page.
- Warn admins who lack permission to edit specific webforms.
- Combine with b24_utm to attach UTM attribution marks to webform leads.
- Capture marketing/enquiry webform data straight into the CRM without custom code.
