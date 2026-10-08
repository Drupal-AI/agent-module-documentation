Eloqua API Redux connects a Drupal site to the Oracle Eloqua marketing-automation REST API and exposes a shared client plus Contact and Forms service wrappers that other modules build on.

---

Eloqua is Oracle's marketing-automation platform, and integrating with it is mostly about moving contacts and form submissions from Drupal into Eloqua and reading marketing assets back. This module is the plumbing rather than a user-facing feature: it holds the OAuth application credentials, runs the authorization-code token exchange through a callback route, stores the resulting access and refresh tokens, resolves the account's Eloqua data-center base URL, and issues authenticated REST calls. On top of that low-level client it ships two convenience services — `Contact` (create/read/update/delete contacts, lookup by email) and `Forms` (list forms, read a form's fields, submit form data). Access and refresh tokens are held in Drupal's State store and refreshed automatically before they expire; the module knows that Eloqua access tokens last eight hours and refresh tokens last a year.

Separating the connection from the features that use it is the right shape for this kind of integration. A site typically wants several Eloqua-touching behaviours — a webform handler, a contact sync, a lookup on a form — and letting each manage its own credentials duplicates work; here they all share one `eloqua_api_redux.client` service. The best-known consumer is the Webform Eloqua module, which uses these services to push webform submissions into Eloqua forms and contacts.

A submodule, `eloqua_api_auth_fallback`, adds an alternative authentication path: instead of the interactive browser-based authorization-code flow, it uses the OAuth resource-owner password credentials grant (site name, username, password) so tokens can be generated non-interactively, including from a Drush command — useful for headless environments or automatic re-authentication when the refresh token has lapsed.

---

- Connect a Drupal site to the Oracle Eloqua REST API.
- Register an Eloqua OAuth application and complete the authorization-code flow from Drupal.
- Store and automatically refresh Eloqua access and refresh tokens.
- Resolve the correct Eloqua data-center base URL for API calls automatically.
- Share one authenticated Eloqua client across several modules.
- Create a contact in Eloqua from Drupal.
- Look up an Eloqua contact by email address.
- Retrieve, update, or delete an Eloqua contact by ID.
- Search contacts with count, depth, page, and search query parameters.
- List Eloqua forms or fetch a single form definition.
- Read the field definitions of an Eloqua form.
- Submit form data (including multi-value fields) to an Eloqua form endpoint.
- Back the Webform Eloqua module's submission handler.
- Push newsletter or campaign sign-ups from a Drupal form into Eloqua.
- Sync Drupal user or contact records into Eloqua marketing lists.
- Build a custom module against the `eloqua_api_redux.client` service for other REST endpoints.
- Generate Eloqua tokens non-interactively via the resource-owner password grant (auth fallback submodule).
- Regenerate tokens from a Drush command for headless or cron-driven syncs.
- Restrict who may configure the Eloqua connection to trusted administrators.
- Inspect access- and refresh-token expiry from the settings page.
