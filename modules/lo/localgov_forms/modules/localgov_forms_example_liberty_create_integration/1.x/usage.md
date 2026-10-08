A worked example showing how to POST Drupal Webform submissions to a REST API built on the Netcall Liberty Create low-code platform (specifically the Caselink 360 CRM "create/update case" method), using Webform's core "Remote post" handler plus a few token helpers.

---

`localgov_forms_example_liberty_create_integration` is a LocalGov Drupal submodule that ships a ready-made example Webform (`caselink_api_integration_example`) and the glue tokens needed to integrate Drupal Webforms with a Liberty Create REST API. Liberty Create APIs are custom per organisation, so there is no one-size-fits-all integration; this module is a reference implementation you copy and adapt. It provides three things: a `[…:extracted_firstname]` / `[…:extracted_lastname]` token filter that splits a full-name value into first/last parts; a `[…:file_details_for_liberty_create_api]` pseudo-token (expanded by `PrepareFileTokens`) that turns a variable number of uploaded files into the base64 file structure Liberty Create expects; and an install hook that whitelists the `DRUPAL_LIBERTY_CREATE_API_AUTH_KEY` environment variable in the `token_environment` module so the API auth key can be supplied as `[env:…]` in the handler's custom request options rather than hard-coded. The actual HTTP POST is performed by Webform core's `RemotePostWebformHandler` (or the contributed "Async remote post" queue handler); this module only prepares tokens and rewrites the handler's "completed custom data" before the request is built. It depends on `localgov_forms` and `token_environment`, defines no routes, permissions, services or Drush commands, and is explicitly a starting point rather than a finished product.

---

- Provide a copy-and-adapt example for POSTing Webform submissions to a Netcall Liberty Create REST API.
- Integrate a Drupal Webform with the Caselink 360 CRM app's `caselink_360_create_update_case` method to create CRM case records.
- Learn the general pattern for mapping Webform fields to any Liberty Create API method's JSON payload.
- Map form fields to a REST payload declaratively via a Webform handler's "Completed custom data" YAML using submission tokens.
- Send an API authentication key as a header without committing it, by referencing `[env:DRUPAL_LIBERTY_CREATE_API_AUTH_KEY]` from `token_environment`.
- Auto-whitelist the `DRUPAL_LIBERTY_CREATE_API_AUTH_KEY` environment variable in `token_environment.settings` on install.
- Split a `webform_name` full-name value into first name and last name for APIs that require them separately (`extracted_firstname` / `extracted_lastname` tokens).
- Attach a variable number of uploaded files to an API request using the `file_details_for_liberty_create_api` pseudo-token (expands to per-file base64 blocks).
- Send file uploads to a CRM as base64-encoded document arrays alongside the case data.
- Capture the CRM API response (result / error code / error description / case reference) back into Webform "Value" elements for inspection under the form's Results tab.
- Use the example Webform's UK-address and telephone-validation fields (`localgov_webform_uk_address`, GB telephone format) as a template for local-government intake forms.
- Switch from synchronous posting to queue-backed posting by swapping the "Remote post" handler for "Async remote post" (from `webform_queued_post_handler`) for more reliable delivery via cron.
- Understand which token expansions run on `post_save` (normal submission) and on `post_load` (queued reprocessing) via the module's handler-invoke alter hooks.
- Prototype a council CRM intake form (name, DOB, email, phone, residential/case address, enquiry details, file attachments) that pushes cases into Caselink 360.
- Adapt the example's UPRN address tokens (`residential_address:uprn`, `case_address:uprn`) to send property references to a CRM.
- Serve as documentation of the Liberty Create request/response shape (see the module README's sample request and response).
- Demonstrate escaping of file-element labels and per-file YAML block generation for the Remote post handler.
- Base new integrations for other Liberty Create apps (not just Caselink 360) on the same handler-configuration approach.
- Teach site builders how the Remote post handler's "Custom options", "Completed URL" and "Completed custom data" settings combine to form an authenticated JSON POST.
- Provide a reference for storing API responses as submission values so integration failures can be triaged from the Webform Results UI.
