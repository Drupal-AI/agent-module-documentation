Webform Eloqua adds a Webform handler that maps form elements to Eloqua form fields and posts completed submissions to Oracle Eloqua.

---

The module is deliberately thin: it ships one class, `WebformEloquaHandler` (a `@WebformHandler` plugin), and leans on two dependencies to do the real work. Webform provides the submission lifecycle and the per-form handler UI; `eloqua_api_redux` owns the Eloqua connection, credentials and REST transport through its `eloqua_api_redux.forms` service. You attach the "Eloqua" handler to a webform, pick a target Eloqua form (the list is pulled live from Eloqua), and map Webform elements to that form's fields. The mapping UI splits into "Default Webform Field Mapping" (submission metadata such as sid, created, remote_addr) and "User Field Mapping" (the elements you built into the form), and it AJAX-reloads the destination field list whenever you change the selected Eloqua form.

Posting is one-directional and event-driven. On `postSave`, the handler computes the submission state and calls `remotePost`, which returns immediately unless the state is `STATE_COMPLETED` — so drafts and partial saves are never sent, only finished submissions. It then builds an Eloqua `fieldValues` payload from the stored mapping and hands it to `Forms::createFormData()`. There is no queue: the post happens inline during submission save, so Eloqua's availability is on the critical path of the form. Validation is enforced at configuration time — the handler refuses to save a mapping that omits a field Eloqua marks required, or that references an Eloqua field id that no longer exists. Failure at post time is handled minimally: an empty API response is logged via the handler logger and the submission still saves locally; the end user is not shown an error. Because submissions leave the site for a marketing platform, treat the transfer as personal-data egress and cover it in the form's consent and privacy notices.

---

- Post completed Webform submissions to an Oracle Eloqua form.
- Attach the "Eloqua" handler to any webform from the Webform UI (Handlers tab).
- Select the destination Eloqua form from a live, name-ordered list pulled from Eloqua.
- Map user-created Webform elements to Eloqua form fields.
- Map default submission properties (sid, uuid, created, remote_addr, etc.) to Eloqua fields.
- Run more than one Eloqua handler on the same webform (cardinality is unlimited).
- Let Webform's handler conditions/ordering decide when the Eloqua post runs.
- Enable or disable the Eloqua integration per form without a code deployment.
- Reuse a single Eloqua API credential configured once in Eloqua API Redux across many forms.
- Enforce that all Eloqua-required fields are mapped before the handler can be saved.
- Catch stale mappings — configuration save fails if a mapped Eloqua field id no longer exists.
- Send only finished submissions (STATE_COMPLETED); skip drafts and partial saves.
- Apply Webform token replacement to submission values before they are posted.
- Keep the submission stored locally in Drupal even when the Eloqua post fails.
- Log Eloqua post failures to the webform handler log for later review.
- Feed Eloqua campaigns, landing-page follow-ups, and contact lists from Drupal forms.
- Sync newsletter/marketing sign-up forms into Eloqua contact records.
- Push event-registration or gated-content forms into Eloqua for nurture flows.
- Audit which webforms forward data to an external CRM/marketing platform.
- Document the site's form-to-Eloqua data flow for a privacy or compliance review.
- Decide and document what should happen when Eloqua is unreachable at submit time.
