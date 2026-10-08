Integrates the commercial Usercentrics Consent Management Platform (CMP) into Drupal and defers tracking scripts, page attachments and asset libraries until the visitor grants the matching consent.

---

The module injects the hosted Usercentrics CMP loader (`app.usercentrics.eu/browser-ui/latest/loader.js`, keyed by an admin-entered Usercentrics settings ID) into every non-excluded page, and optionally the Smart Data Protection (SDP) blocker (`privacy-proxy.usercentrics.eu`). Consent gating is driven by `usercentrics_app` config entities ("Data Processing Services" / DPS): each app names the script sources, page-attachment identifiers and asset-library names it owns. Three alter hooks (`hook_js_alter`, `hook_page_attachments_alter`, `hook_library_info_alter`) plus a swapped-in `UsercentricsJsCollectionRenderer` rewrite the matching `<script>` tags to `type="text/plain"` with a `data-usercentrics="<app label>"` marker, so the browser does not execute them until Usercentrics unblocks them after consent. The project ships disabled-by-default DPS apps for Matomo, Matomo self-hosted, Google Analytics, Google Analytics 4 and Google Tag Manager, and lets site builders create their own. It also renders an optional floating "Manage consents" toggle button, supports the Transparency & Consent Framework (TCF), preview mode, disable-tracking mode, and per-URL enable/disable regex patterns. It requires no non-core modules; only the two admin routes carry a `restrict access` permission.

---

- Add a GDPR/ePrivacy cookie-consent banner to a Drupal site using the hosted Usercentrics CMP.
- Enter your Usercentrics settings ID and switch the CMP on for the whole front end.
- Block Google Analytics (classic) tracking until the visitor consents, via the shipped `google_analytics` DPS.
- Block Google Analytics 4 / Google Tag (`google_tag/gtag`, `gtm`) libraries until consent, via the `google_analytics_4` or `google_tag_manager` DPS.
- Gate Matomo tracking (hosted `matomo.js` or a self-hosted script) behind consent using the `matomo` / `matomo_self_hosted` DPS.
- Create a custom Data Processing Service for any third-party script your site loads and pick how it is matched (by src substring, page-attachment id, or library name).
- Defer a script added by a contrib module's asset library by listing that library name (e.g. `mymodule/tracker`) on a DPS.
- Defer a `<script>` a module adds as an `hook_page_attachments` entry by listing its attachment identifier on a DPS.
- Defer a script referenced by partial `src` match (e.g. `tracking.js`, `https://example.org/script.js`) without knowing the library name.
- Show a persistent floating "Manage consents" button so visitors can reopen the Usercentrics first layer at any time.
- Replace that button's icon with a custom logo URL.
- Turn on the Transparency & Consent Framework (TCF) for IAB-style vendor consent.
- Run the CMP in preview mode (`data-version="preview"`) while building/testing consent flows.
- Enable disable-tracking mode (`data-disable_tracking`) for staging or preview environments.
- Enable Smart Data Protection (SDP) to auto-block external embeds/iframes such as YouTube videos.
- Keep the CMP off admin routes (default) so it never interferes with the Drupal back office.
- Exclude users holding an admin role from ever seeing the banner.
- Disable the CMP entirely on specific URL patterns via `exclude_urls` regexes (resources stay blocked there).
- Disable only the Usercentrics element while letting resources load on specific URL patterns via `disable_urls`.
- Let anonymous visitors operate the consent UI by granting the `use usercentrics` permission to the anonymous role.
- Turn on debug mode to log every checked library/script/attachment (and each rewrite) to the Drupal log for building new DPS definitions.
- Reorder / weight multiple DPS apps and toggle each on or off from a single drag-and-drop table.
- Combine with the Media oEmbed Provider Markup module so oEmbed video embeds are recognised and blocked by the CMP.
- Export the whole consent configuration (settings + DPS entities) as Drupal config for deployment across environments.
