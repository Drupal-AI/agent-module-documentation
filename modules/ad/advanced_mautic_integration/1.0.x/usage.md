Advanced Mautic Integration embeds the Mautic (open-source marketing automation) tracking script into Drupal pages and syncs Drupal users to Mautic contacts over the Mautic REST API.

---

The module has two independent halves, both driven by a single settings form at `/admin/config/services/adv-mautic`. The **JavaScript tracking** half attaches the Mautic `mtc.js` loader snippet and a helper library to pages selected via the Condition API (the same visibility UI used by blocks — roles, pages, node types, language), then tracks pageviews and, optionally, clicks on outbound, `mailto:`, `tel:` and file-download links. A JSON "default parameters" field (Token-enabled) lets you send fields such as the current user's email with every event to identify contacts. The **API** half wraps `mautic/api-library` (Basic Auth) so your code can call any Mautic API context via the `advanced_mautic_integration.api` service; a built-in synchronizer pushes a Drupal user to a Mautic contact on every user insert/update using an admin-defined field mapping (Drupal field `|` Mautic field). It depends on the Token module and ships in the Statistics package.

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
