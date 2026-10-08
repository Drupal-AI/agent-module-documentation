Exports Drupal core contact-form submissions to Bitrix24 leads with per-form field mapping.

---

`b24_contact` extends the base `b24` module to turn Drupal core contact-form submissions into
Bitrix24 leads. On the settings page an administrator picks which contact forms are exported and, per
form, maps each `contact_message` field (or a Drupal token / custom static value) to a Bitrix24 lead
field. When a contact message is submitted, `hook_mail_alter()` intercepts the outgoing contact mail,
builds the mapped field set, and creates the lead through the base module's `RestManager`. Requires
the base `b24` OAuth connection and the core `contact` module; configuration is at
`/admin/config/b24/contact` under `administer b24 configuration`.

---

- Create a Bitrix24 lead automatically when a core contact form is submitted.
- Enable or disable export per individual contact form.
- Map contact_message fields to Bitrix24 lead fields.
- Use Drupal tokens or custom static values for lead field values.
- Support Bitrix24 multi-value (`crm_multifield`) fields such as phone/email.
- Require configured mandatory Bitrix24 fields before saving the mapping (validation).
- Route contact-form leads through the shared assignee/CRM-mode settings of the base module.
- Capture website enquiries into the CRM without custom code.
- Combine with b24_utm to attach UTM attribution marks to contact-form leads.
- Keep contact-form export configuration in a single `b24_contact.settings` config object.
