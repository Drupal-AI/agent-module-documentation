HubSpot Webform integration connects Drupal to HubSpot over OAuth 2: it sends Webform submissions to a mapped HubSpot form via the HubSpot Forms API, and can inject the HubSpot JavaScript tracking code site-wide.

---

Built on the official `hubspot/hubspot-php` client, the module authenticates to HubSpot through
OAuth 2 (client ID/secret + portal ID entered on the admin settings form at
`/admin/config/services/hubspot`). Clicking "Connect HubSpot Account" redirects to HubSpot's
authorize screen and back to the `hubspot.oauth_connect` route, which exchanges the returned code
for access/refresh tokens stored in Drupal state; the `Hubspot` service transparently refreshes
the access token when it expires. The core feature is a **Webform handler** (`hubspot_webform_handler`):
add it to any webform, pick a target HubSpot form from a live-loaded dropdown, and map each webform
element to a HubSpot field, with optional legal-consent (GDPR) and email-subscription mapping. On
submission the handler builds the field payload (file elements are uploaded to HubSpot's file API
and replaced by their URL; entity references become labels; multi-values become semicolon lists)
and posts it to the HubSpot Forms API together with context (client IP, referer page URI, and the
`hubspotutk` tracking cookie when present). A separate toggle attaches the HubSpot tracking script
(`https://js.hs-scripts.com/<portal_id>.js`) to every page via `hook_library_info_build` /
`hook_page_attachments`. Optional debug mode emails HubSpot API errors to a configured address;
otherwise errors are logged. A `HubspotBlock` can display recent leads (gated by the restricted
`view recent hubspot leads` permission). All admin routes require `administer site configuration`.

---

- Send Drupal Webform submissions straight into HubSpot as form submissions / leads.
- Map individual webform elements to specific HubSpot form fields.
- Authenticate a Drupal site to HubSpot using OAuth 2 (connect/disconnect from the settings page).
- Automatically refresh the HubSpot OAuth access token when it expires.
- Upload file/managed-file webform submissions to HubSpot and store the resulting file URL.
- Capture GDPR legal-consent with a HubSpot form ("always", "never", or driven by a consent checkbox).
- Map webform checkboxes to HubSpot email-subscription opt-ins.
- Pass the visitor's HubSpot tracking cookie (`hubspotutk`) so submissions attach to the known contact.
- Include page context (referer URL and client IP) with each HubSpot form submission.
- Inject the HubSpot JavaScript tracking/analytics code on every page of the site.
- Track visits and returning leads via HubSpot's analytics without editing templates.
- Attach multiple HubSpot handlers to one webform (handler cardinality is unlimited).
- Convert multi-value webform fields to HubSpot's semicolon-separated list format automatically.
- Turn entity-reference webform values into their entity labels before sending to HubSpot.
- Email HubSpot API errors to an operator address by enabling debug mode.
- Log HubSpot submission successes/failures to the `hubspot` logger channel.
- Show a "recent HubSpot leads" block to trusted users (restricted permission).
- Choose exactly which HubSpot OAuth scopes to request (e.g. `crm.objects.contacts.write forms oauth`).
- Load the list of available HubSpot forms live from the API when configuring the handler.
- Integrate marketing lead capture into an existing Webform-based contact or signup form.
- Keep HubSpot credentials in Drupal config while tokens live in state, refreshed automatically.
