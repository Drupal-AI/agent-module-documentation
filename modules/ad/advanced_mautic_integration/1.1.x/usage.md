Advanced Mautic Integration embeds the Mautic (open-source marketing automation) tracking script into Drupal pages and syncs Drupal users to Mautic contacts over the Mautic REST API, with an optional consent gate that holds the tracker back until the visitor agrees.

---

The module has two independent halves, both driven by a single settings form at `/admin/config/services/adv-mautic`. The **JavaScript tracking** half publishes the Mautic `mtc.js` loader configuration to `drupalSettings` and attaches the `advanced_mautic_integration/tracking_events` library on pages selected via the Condition API (the same visibility UI used by blocks — roles, pages, node types, language); the client script then loads the tracker and reports pageviews and, optionally, clicks on outbound, `mailto:`, `tel:` and file-download links. A JSON "default parameters" field (Token-enabled) lets you send fields such as the current user's email with every event to identify contacts. A **consent gate** (`track.consent_required`) can hold the tracker until a consent manager calls `Drupal.advancedMauticIntegration.consent(true)`; the bundled `advanced_mautic_integration_klaro` submodule wires that up for Klaro. The **API** half wraps `mautic/api-library` (Basic Auth) so your code can call any Mautic API context via the `advanced_mautic_integration.api` service; a built-in synchronizer pushes a Drupal user to a Mautic contact on user insert/update (when `api.synchronize_user` is on) using an admin-defined field mapping (Drupal field `|` Mautic field). It depends on the Token module and ships in the Statistics package with a config schema and an install default.

---

- Load the Mautic `mtc.js` tracking script on a Drupal site by setting only the Mautic base URL.
- Disable Mautic JS entirely by clearing the base-URL field.
- Choose exactly which pages carry the tracking script using block-style visibility conditions.
- Restrict tracking to specific roles, paths, node types, or languages.
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
