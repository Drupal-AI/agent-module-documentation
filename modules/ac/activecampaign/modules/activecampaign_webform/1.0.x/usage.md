Adds a Webform handler that maps submitted fields to an ActiveCampaign contact and syncs it on submission.

---

`activecampaign_webform` is a submodule of the ActiveCampaign project. It depends on the base `activecampaign` module and on `webform`, and it contributes one Webform handler plugin, `activecampaign_contact` (label "Active Campaign", category "Automated marketing"). Add the handler to any Webform via Settings → Emails/Handlers; its configuration form lets you map the Webform's required email field plus optional first-name and last-name fields to ActiveCampaign, and an optional YAML block maps any additional Webform fields to ActiveCampaign custom field ids or personalization tags (e.g. `field[345,0]: '[machine_name]'` or `field[%PERS_1%,0]: '[machine_name]'`). When a submission is processed, the handler assembles a contact-properties array from the submission data and calls the parent service's `syncContact()`, which posts to ActiveCampaign's `contact/sync` endpoint (create-or-update). A development "debug" toggle logs the submitted and mapped values. The maintainer flags the custom YAML mapping as not yet fully reliable.

---

- Create or update an ActiveCampaign contact automatically whenever a Webform is submitted.
- Turn a Drupal contact-us or demo-request form into an ActiveCampaign lead-capture pipeline.
- Sync a newsletter signup Webform's email address into ActiveCampaign for automations.
- Map the Webform email field (required) to the ActiveCampaign contact email.
- Optionally map first-name and last-name Webform fields to the ActiveCampaign contact.
- Forward extra answers to ActiveCampaign custom fields via YAML, e.g. `field[345,0]: '[phone]'`.
- Populate an ActiveCampaign personalization tag from a Webform field, e.g. `field[%PERS_1%,0]: '[company]'`.
- Attach several ActiveCampaign handlers to one Webform to push to different field sets.
- Reuse a single Webform for both on-site storage and ActiveCampaign contact sync.
- Feed event-registration form data into ActiveCampaign for follow-up email sequences.
- Add subscribers to ActiveCampaign automations by wiring a form submit to contact sync.
- Keep ActiveCampaign contacts current as users resubmit forms (sync is create-or-update).
- Log ActiveCampaign sync failures to Drupal's logger for troubleshooting (handler catches API errors).
- Enable the handler's debug mode temporarily to inspect exactly what is mapped and sent.
- Build a marketing-qualified-lead capture step inside a multi-step Webform.
- Route different Webforms (sales vs support) to distinct ActiveCampaign field mappings.
