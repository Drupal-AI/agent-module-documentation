Hubspot API is a developer-oriented library module that wraps the official `hubspot/api-client` PHP SDK and hands other Drupal code an authenticated HubSpot API client.

---

The module does not add any content-facing feature of its own; it exists so that other modules and custom code can talk to the HubSpot CRM without re-implementing authentication. It exposes one settings form (`/admin/config/services/hubspot-api`) where an administrator stores either a Private App access token or an OAuth app's Client ID / Client secret, runs the OAuth authorize/redirect handshake, and stores the resulting access + refresh tokens. At runtime the `hubspot_api.manager` service returns a ready-to-use `HubSpot\Discovery\Discovery` handler — preferring OAuth (auto-refreshing an expired access token) and falling back to the Private App token — so calling code can immediately reach the SDK's CRM, contacts, companies, deals and other API endpoints.

---

- Add HubSpot CRM connectivity to a Drupal site without hand-writing OAuth or HTTP plumbing.
- Store a HubSpot Private App access token in Drupal config for server-to-server API calls.
- Connect the site to a HubSpot app via the OAuth 2.0 authorization-code flow from the admin UI.
- Automatically refresh an expired OAuth access token before making an API call.
- Obtain a fully-authenticated `HubSpot\Discovery\Discovery` client from `\Drupal::service('hubspot_api.manager')->getHandler()`.
- Fetch a list of HubSpot contacts (e.g. firstname/lastname) from custom code or a Drush one-liner.
- Create or update HubSpot contacts, companies, or deals from Drupal form submissions or hooks.
- Read CRM records into Drupal to display or sync alongside site content.
- Push newsletter sign-ups or lead data captured on the site into a HubSpot pipeline.
- Build a custom Webform or contact-form handler that forwards submissions to HubSpot.
- Query HubSpot marketing/CRM objects to personalize Drupal content for known contacts.
- Provide a single, shared, credential-managed HubSpot client for several site features.
- Test a HubSpot connection quickly with the README's `drush ev` contacts snippet.
- Switch between a Private App token (simple) and OAuth (multi-scope, refreshable) without code changes.
- Let site builders manage HubSpot credentials in the UI while developers consume the service.
- Disconnect the site from HubSpot (clear tokens and credentials) from the settings form.
- Show the current OAuth connection status (Connected / Disconnected) to administrators.
- Serve as the foundation layer for higher-level HubSpot feature or sync modules.
- Access any endpoint the underlying `hubspot/api-client` SDK supports (CRM, associations, files, etc.).
- Centralize HubSpot API-key handling so credentials live in one config object instead of scattered code.
- Render the module README as on-site help when the optional Markdown module is enabled.
