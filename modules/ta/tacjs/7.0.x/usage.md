TacJS integrates the [tarteaucitron.js](https://github.com/AmauriC/tarteaucitron.js) consent library into Drupal, showing a cookie-consent banner that blocks third-party services (analytics, video, social, ads) until the visitor opts in, so the site can comply with the EU cookie law / GDPR.

---

TacJS wires the external tarteaucitron.js JavaScript library into every non-admin page. On `hook_page_attachments()` it reads the `tacjs.settings` config object, pushes the dialog options, active services, translated texts and consent expiry into `drupalSettings.tacjs`, and attaches the `tacjs/tacjs` library plus the correct-language tarteaucitron translation file. The library itself is **not** bundled — you must install `tarteaucitronjs` into `web/libraries/tarteaucitronjs` (a `hook_requirements()` check verifies this). Configuration is split across three admin forms under `/admin/config/system/tacjs`: **Manage dialog** (`tacjs.manage_dialog`, the default configure route — banner position, icon, privacy URL, high-privacy/DNT behaviour, etc.), **Add services** (`tacjs.add_services` — pick which tarteaucitron services like Google Analytics, YouTube or Matomo are enabled, parsed from the library's `tarteaucitron.services.js`), and **Edit texts** (`tacjs.edit_texts` — override every banner string; strings run through the token service). All three require the `administer tacjs` permission, which is `restrict access: TRUE` because service definitions accept unfiltered text/JS. TacJS can optionally generate a trimmed `tarteaucitron.active.services.<suffix>.js` file containing only the enabled services. Two submodules extend it: **tacjs_log** records proof of consent to a database table, and **tacjs_media** provides a consent-aware oEmbed field formatter for remote video. Developers can inject custom services or service content with `hook_tacjs_services_alter()` / `hook_tacjs_content_alter()`.

---

- Show an EU-cookie-law consent banner on a Drupal site using tarteaucitron.js.
- Block Google Analytics until the visitor explicitly accepts analytics cookies.
- Gate YouTube / Vimeo / Dailymotion embeds behind consent (with tacjs_media).
- Provide "Deny all" and "Accept all" call-to-action buttons in the consent dialog.
- Enable high-privacy mode so no service loads before consent is given.
- Honour the browser "Do Not Track" (DNT) header automatically.
- Position the consent banner (middle / top / bottom) and orientation to match the theme.
- Show a small persistent cookie icon so visitors can re-open their choices later.
- Point the banner's privacy-policy link at a specific node or URL.
- Customise the cookie name, hashtag and consent expiry period.
- Translate or reword every banner string per language via the Edit texts form.
- Enable only the specific third-party services your site actually uses (Add services form).
- Group services by category (ads, analytics, video, social, …) in the dialog.
- Generate a slimmed-down active-services JS file for performance.
- Serve per-domain active-service files using a filename suffix (with the Domain module).
- Record proof of consent (timestamp, IP, services accepted) for audit (tacjs_log submodule).
- Review a paged report of stored consents at /admin/config/system/tacjs/overview (tacjs_log).
- Inject a custom tarteaucitron service from your own module with hook_tacjs_services_alter().
- Add service content (e.g. a custom analytic snippet) via hook_tacjs_content_alter().
- Temporarily disable the whole consent banner site-wide with a single "enabled" toggle.
- Restrict consent configuration to trusted editors via the restricted `administer tacjs` permission.
- Use an external CSS/JS build of tarteaucitron rather than inlined assets.
- Set a default state (wait / true / false) for services before the visitor chooses.
- Comply with GDPR/RGPD consent requirements without writing custom JavaScript.
