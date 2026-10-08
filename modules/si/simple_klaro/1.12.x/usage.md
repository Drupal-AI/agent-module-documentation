<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Simple Klaro integrates the Klaro consent manager into Drupal, giving visitors a cookie/consent dialog that gates third-party scripts until they opt in.

---

Klaro's model is to hold back a tracking script until consent is given: the script tag is marked with a service name and a neutral type, and is only activated once the visitor accepts that service. This module supplies the Drupal side. There is no per-service admin UI; instead the entire Klaro configuration is a single JSON document you paste into a textarea on the settings form at `/admin/config/system/simple-klaro`. That config is stored in the `simple_klaro.settings` config object (keys `config`, `preferences`, `library`, `enabled`, `exclude_paths`) with matching `config/schema`, and is pushed to the browser as `drupalSettings.klaroConfig` by `simple_klaro_page_attachments()`, which also attaches the chosen Klaro library. Saving the form runs `drupal_flush_all_caches()` so the change applies on every page immediately. You pick from eight library variants — local or CDN, with or without bundled CSS, with or without bundled translations — letting you either use Klaro's default look or style the dialog to match the theme. A block plugin (`simple_klaro_preferences_dialog`) renders a "Cookie preferences" link that re-opens the dialog, and any element with the id or class `klaro-preferences` does the same via `js/klaro.drupal.js`. Two permissions exist, both marked restrict-access: `administer simple klaro` for the settings form, and `bypass simple klaro`, which lets a role use the site without the consent manager (handy for editors, and to be granted deliberately since such a session is not representative of a visitor's). Services can group by purpose, carry per-language translations, delete cookies by regex when consent is revoked, and run a callback when their consent state changes.

---

- Show a GDPR/cookie consent dialog before loading trackers.
- Hold back Google Analytics until consent is given.
- Let visitors choose which services they accept.
- Group services by purpose in the dialog.
- Give editors a bypass while working on the site.
- Serve the Klaro library locally rather than from a CDN.
- Or load the Klaro library from the kiprotect CDN with no local install.
- Style the dialog yourself using a no-CSS library variant.
- Document each service's purpose for visitors in multiple languages.
- Re-open the consent dialog from a footer link or block.
- Meet an EU cookie-consent obligation.
- Block embedded YouTube video until consent.
- Delete a service's cookies by regex when consent is revoked.
- Configure consent text and translations per service.
- Run a callback when consent for a service changes.
- Place consent controls as a block anywhere in the theme.
- Include a privacy-policy link in the dialog.
- Gate a marketing pixel behind opt-in.
- Provide granular rather than all-or-nothing consent.
- Keep consent configuration in exportable Drupal config.
- Exclude the consent manager from admin or specific paths.
- Change consent configuration without redeploying the site.
- Align a site with a data-protection review.
