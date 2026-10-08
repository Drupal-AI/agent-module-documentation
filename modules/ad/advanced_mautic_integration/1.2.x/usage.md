Advanced Mautic Integration connects a Drupal site to a Mautic (open-source marketing automation) instance in both directions: it delivers the Mautic `mtc.js` tracking script with the events and contact data you choose, and makes the Mautic REST API available to your own code with an optional synchronization of Drupal users to Mautic contacts.

---

The module has two independent halves, both driven by a single settings form at `/admin/config/services/adv-mautic`. The **JavaScript tracking** half decides with the page (`hook_page_top`) whether the tracker belongs on it, using the Condition API — the same block-style visibility UI for pages, roles, node types and languages — and then delivers the tracker itself through a lazy-builder placeholder (`TrackerPlaceholder`) that is rendered on every request, so a visitor-specific default parameter does not take the page out of the Dynamic Page Cache. The client library (`advanced_mautic_integration/tracking_events`) loads `mtc.js` and reports pageviews and, optionally, clicks on outbound, `mailto:`, `tel:` and file-download links; a Token-enabled JSON "default parameters" field (e.g. `{"email":"[current-user:mail]"}`) is merged into every event to identify contacts, with empty values dropped. A **consent gate** (`track.consent_required`) holds the tracker until a consent manager calls `Drupal.advancedMauticIntegration.consent(true)`, and the `hook_advanced_mautic_integration_tracker_alter()` hook lets other code ship JS that arrives together with the tracker. The bundled `advanced_mautic_integration_klaro` submodule wires the gate up for Klaro. The **API** half wraps `mautic/api-library` (Basic Auth) so your code can call any Mautic API context via the `advanced_mautic_integration.api` service; a built-in synchronizer pushes a Drupal user to a Mautic contact on user insert/update (when `api.synchronize_user` is on) using an admin-defined field mapping (Drupal field `|` Mautic field). It depends on the Token module and ships in the Statistics package with a config schema and an install default.

---

- Load the Mautic `mtc.js` tracking script on a Drupal site by setting only the Mautic base URL.
- Disable Mautic JS entirely by clearing the base-URL field.
- Choose exactly which pages carry the tracking script using block-style visibility conditions.
- Restrict tracking to specific roles, paths, node types, or languages.
- Keep tracked pages in the Dynamic Page Cache even when a default parameter names the visitor, because the tracker is delivered through a per-request placeholder.
- Track ordinary pageviews across the site.
- Track clicks on outbound (external) links as pageview events.
- Track clicks on `mailto:` email links.
- Track clicks on `tel:` telephone links.
- Track file downloads for a configurable, pipe-separated extension list (e.g. `pdf|doc|zip`, regex supported).
- Send default parameters (a JSON object) with every tracking event.
- Use Drupal tokens such as `[current-user:mail]` inside those default parameters to identify contacts.
- Hold the tracker back until the visitor consents, so no Mautic request or cookie happens before opt-in.
- Wire the tracker into the Klaro consent manager with the bundled Klaro submodule (no code).
- Integrate any other consent manager through the `Drupal.advancedMauticIntegration.consent()` / `hasConsent()` contract.
- Gate your own Mautic snippets (Focus, forms) on the same decision via the `advancedMauticIntegration:consent` document event.
- Attach JS that must arrive together with the tracker (e.g. a consent adapter) via `hook_advanced_mautic_integration_tracker_alter()`.
- Fire pageview events from your own JS via the exposed `Drupal.mt_send()` helper.
- Connect to a Mautic instance's REST API with Basic Auth credentials.
- Call any Mautic API context (contacts, campaigns, etc.) from custom code via the `advanced_mautic_integration.api` service and `getApi()`.
- Create or update Mautic contacts programmatically from your own module.
- Automatically push Drupal user data to a Mautic contact whenever a user is created or updated.
- Map arbitrary Drupal user fields to Mautic contact fields (e.g. `mail|email`).
- Match an existing Mautic contact by the visitor's `mtc_id` cookie or by email before updating.
- Provide a dedicated permission (`administer advanced mautic integration`) to gate the settings form.
- Run tracking without a paid analytics service, as a simpler alternative to wiring Mautic through Google Tag Manager.
- Keep contact records in Mautic in step with your Drupal user base for marketing automation and campaigns.
