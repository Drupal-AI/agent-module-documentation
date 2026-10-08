ECA: Google is the base layer that lets ECA models authenticate to and call Google APIs, with service-specific behaviour provided by submodules such as ECA: Google Sheets.

---

ECA: Google provides the shared plumbing for a suite of modules that connect Drupal's ECA (Event-Condition-Action) visual workflow builder to Google services. The base module itself adds no ECA actions; it exposes one service, `eca_google.google_api` (class `GoogleApiService`), that resolves a configured Google API client into a ready-to-use Google service object, plus a reusable action-config trait (`GoogleAuthActionConfigTrait`) that renders the "Google API Client" select on every Google action form. Authentication credentials are not stored by this module: it delegates entirely to the Google API Client (`google_api_client`) module, supporting both OAuth2 "API client" entities and "service account" entities. Each Google action stores an `auth_client_id` in the form `auth_type:client_id` (e.g. `api_client:my_oauth` or `service_account:my_sa`), which the service parses and dispatches to the correct google_api_client backend. To do useful work you enable a service submodule (currently ECA: Google Sheets) matching the Google API you enabled in Google Cloud Console. It requires `eca` and `google_api_client`, and runs on Drupal 10 and 11.

---

- Bridge Drupal ECA no-code workflows to Google APIs without custom PHP.
- Provide a single shared authentication layer for all Google service submodules.
- Let a site builder pick an OAuth2 API client or a Service Account per ECA action.
- Reuse one "Google API Client" selection widget across every Google action form.
- Resolve a `sheets` (or other) Google service object from a stored client entity.
- Support two Google auth models: `api_client` (OAuth2) and `service_account`.
- Enable ECA: Google Sheets to read, append, update, query, clear, create and delete sheet data.
- Sync a Drupal webform or node submission into a Google Sheet on a content event.
- Log site events (registrations, orders, errors) as rows appended to a spreadsheet.
- Pull reference/config data from a Google Sheet into ECA tokens for use in a workflow.
- Filter spreadsheet data server-side with Google's QUERY syntax and act on the results.
- Update a specific spreadsheet row identified by an earlier query result.
- Create a dated or per-category tab in a spreadsheet as part of an automation.
- Clear a working range or delete a temporary sheet at the end of a batch workflow.
- Operate Google Sheets under a specific user account via an authenticated OAuth2 client.
- Operate under a Service Account for server-to-server automation of shared spreadsheets.
- Build event-driven integrations (e.g. on node save, on user login) that touch Google data.
- Centralise Google Cloud project credential management in google_api_client, reused by ECA.
- Extend the suite: additional Google service submodules can reuse `GoogleApiService`.
- Validate at model-build time that the chosen client actually has the required Google API access.
- Drive spreadsheet IDs, ranges and payloads dynamically from ECA tokens.
