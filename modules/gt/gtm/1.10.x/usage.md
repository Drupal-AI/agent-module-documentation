GTM is a lightweight module that injects the Google Tag Manager container snippet (both the `gtm.js` head script and the `<noscript>` iframe fallback) into every page of a Drupal site from a single settings form.

---

The module does one thing well: it wires a Google Tag Manager container into Drupal's page output. You enter your container ID (`GTM-XXXX`) on a simple settings form at `/admin/config/system/gtm`, flip the master "Enable" switch, and the module adds the standard two-part GTM snippet on subsequent page loads. The head portion is attached via `hook_page_attachments()` as an inline `<script>` that boots the `dataLayer` and loads `gtm.js`; the body portion is added via `hook_page_top()` as a hidden `<iframe>` pointing at `googletagmanager.com/ns.html`. All state lives in one simple config object, `gtm.settings`, with four keys: `enable`, `google-tag` (the container ID), `admin-pages`, and `admin-disable`. Two insertion conditions narrow where the snippet appears: `admin-pages` controls whether GTM also loads on `/admin/*` routes (off by default, so it is front-end only), and `admin-disable` suppresses GTM for the superuser (uid 1) so their own visits are not tracked. The container ID is sanitized to alphanumerics and hyphens before it is written into the inline script. There is no config schema, no Drush command, and no plugin system — it is deliberately minimal. All tag firing, triggers, and variables are configured inside the Google Tag Manager web UI rather than in Drupal.

---

- Add a Google Tag Manager container to a Drupal site without editing theme templates.
- Centralize all analytics and marketing tags (GA4, Ads, pixels) behind one GTM container.
- Enter and change the GTM container ID (`GTM-XXXX`) from the Drupal admin UI.
- Turn all tag injection on or off site-wide with a single "Enable" switch.
- Keep GTM off admin pages so back-office activity is not tracked (default behavior).
- Optionally extend GTM to admin pages when you need to track editorial workflows.
- Exclude the site superuser (uid 1) from tracking during development and QA.
- Deploy tracking changes through GTM without a Drupal code deployment.
- Load the standard `dataLayer` bootstrap so custom events can be pushed from JS.
- Provide the `<noscript>` iframe fallback for users with JavaScript disabled.
- Stage a container ID in config and enable it only when going live.
- Configure the whole integration via config management (`gtm.settings`) for CI/CD.
- Gate access to the settings form behind the `administer gtm` permission.
- Roll out conversion tracking for advertising campaigns via GTM tags.
- Manage consent-mode / cookie tags centrally in GTM rather than per-module.
- Add heatmap or session-recording snippets through GTM instead of custom code.
- Swap container IDs between staging and production environments via overrides.
- Inject third-party marketing scripts without granting them Drupal code access.
- Quickly disable all third-party tags in an incident by unchecking "Enable".
- Track front-end-only pages while excluding the entire administrative theme.
- Push custom `dataLayer` variables from other modules' JavaScript for GTM triggers.
- Provide a simple, dependency-free GTM integration for small or brochure sites.
