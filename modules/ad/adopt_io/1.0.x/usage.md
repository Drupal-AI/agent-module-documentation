Adds the GoAdOpt (Adopt.io) cookie-consent / CMP banner to a Drupal site by injecting GoAdOpt's `injector.js` script on every page.

---

Adopt.io Integration is a very small "snippet loader" module. After you obtain a **website code** from GoAdOpt (goadopt.io) and enter it on the settings form, the module attaches GoAdOpt's third-party `//tag.goadopt.io/injector.js?website_code=<code>` script to the `<head>` of every page via `hook_page_attachments_alter()`. GoAdOpt's script then renders and manages the cookie-consent banner (a Consent Management Platform / CMP) client-side. The module itself provides no entities, no services, no blocks, no permissions of its own, and does no server-side calls to GoAdOpt — it only stores one config value (`adopt_io.settings:adopt_io_website_code`) and emits one `<script>` tag when that value is non-empty. Consent decisions are handled entirely by the GoAdOpt platform in the browser; the module does not gate your other analytics/marketing tags — you must wire those to respect the CMP's consent signal yourself.

---

- Add a GoAdOpt cookie-consent banner to a Drupal 8/9/10/11 site.
- Load GoAdOpt's `injector.js` CMP script on every page.
- Present a GDPR/ePrivacy cookie-consent notice managed by GoAdOpt.
- Collect and store visitor consent through the GoAdOpt platform.
- Configure the integration with a single Adopt.io "website code".
- Turn the banner on for the whole site by saving a non-empty website code.
- Turn the banner off site-wide by clearing the website code (empty code emits no script).
- Centralize consent management in a hosted SaaS instead of a self-hosted banner.
- Give marketing/legal a GoAdOpt-managed consent UI without custom theming.
- Serve the CMP script from GoAdOpt's CDN (`tag.goadopt.io`) with no local assets.
- Swap GoAdOpt property/site by changing the website code in one place.
- Manage cookie categories and consent text in the GoAdOpt dashboard, not Drupal.
- Provide a starting point for cookie-compliance on a Drupal site.
- Enable the banner across all themes (it attaches in `html_head`, theme-agnostic).
- Roll out the consent script to multiple sites by installing the module and setting each site's code.
- Reference the GoAdOpt-managed consent signal from your own analytics/tag-manager gating logic.
- Add a lightweight, dependency-free consent integration (no other Drupal modules required).
- Use GoAdOpt as the CMP layer in front of Google Consent Mode or similar.
- Quickly prototype consent on a staging site by pasting a test website code.
- Keep the consent configuration out of code (stored as Drupal config, editable in the UI).
