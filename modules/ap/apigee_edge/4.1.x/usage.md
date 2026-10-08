Apigee Edge connects a Drupal site to a Google Apigee organization (Apigee Edge public/private cloud
or Apigee X/hybrid) and turns it into an API developer portal. Drupal users become Apigee developers,
and developer apps, API products, and app credentials/API keys are managed from Drupal as
SDK-backed entities.

---

The module authenticates to the Apigee Management API through a Key entity (of type `apigee_auth`)
whose value holds the org, endpoint, auth type (basic/OAuth for Edge, service-account JWT for X), and
credentials — stored via environment variables, a private file, or any Key provider. The
`apigee_edge.sdk_connector` service builds the Apigee SDK client (over Drupal's core HTTP
client, with configurable timeouts/proxy), and entity controllers expose developers, apps, and API
products with in-memory caching. Registration/verification, developer↔user synchronization (form and
Drush), API-product visibility rules, per-entity display/caching, and an error page are all
configurable under Configuration → Apigee. Four submodules extend it: Teams (companies), Actions
(Rules events), Debug (API call logging), and API Product RBAC. It requires the contrib `key` and
`entity` modules and the `apigee/apigee-client-php` library, PHP 8.3+.

---

- Build an API developer portal on Drupal backed by Apigee Edge or Apigee X.
- Let site users self-register and automatically become Apigee developers.
- Store Apigee org credentials in a Key using environment variables (no secrets in the DB).
- Store Apigee credentials in a private-filesystem file instead of environment variables.
- Connect to Apigee X / hybrid using a GCP service-account JSON key.
- Connect to Apigee Edge using basic auth or OAuth.
- Let developers create and manage their own apps and API keys from `/user/apps`.
- Associate API products with developer apps and enforce which products a role may consume.
- Restrict API-product visibility to specific roles (public/private/internal mapping).
- Rotate, revoke, or delete an app's API keys while protecting its only active key.
- Synchronize existing Drupal users into Apigee developers after first install (`drush apigee-edge:sync`).
- Create a least-privilege Apigee role for the Drupal connection (`drush create-edge-role`).
- Show per-app analytics and export analytics data as CSV.
- Relabel the "API Product" / "Developer App" entities to match your product wording.
- Tune Apigee API connection timeouts and route calls through an HTTP proxy.
- Map custom Drupal user/app fields to Apigee developer attributes.
- Show a friendly error page when the Apigee connection is unavailable.
- Schedule developer synchronization as a background job via cron.
- Extend the API client User-Agent from another module.
- Add a custom field-storage format plugin to control how a field serializes to an Apigee attribute.
- Replace the API-product access model entirely from a custom module via `hook_api_product_access`.
- Organize developers into teams/companies with shared apps (Teams submodule).
- Log and inspect every Apigee API request/response for debugging (Debug submodule).
- Trigger Rules reactions when apps, teams, or products change (Actions submodule).
- Enforce role-based access to API products instead of visibility (RBAC submodule).
