Cookie Consent Notice by CookieYes injects the third-party CookieYes consent-management script into every front-end page from a Drupal admin form, so you can add a GDPR/CCPA cookie banner without editing theme or html.html.twig files. Registration with CookieYes (external SaaS) is required to obtain the script.

---

The module is a thin script-injector. An admin pastes their CookieYes `<script>` snippet into a textarea on the settings form (`/admin/config/development/cookie_consent_notice_by_cookieyes`, permission `cookieyes_scripts_settings`, which is marked `restrict access: TRUE`) and toggles an "Enable" checkbox; both are saved to `cookie_consent_notice_by_cookieyes.settings` (`scripts`, `enable`). `hook_page_attachments_alter()` then, on non-admin routes only and only when enabled and non-empty, uses two regexes to pull the `src="…"` (and optional `id="…"`, defaulting to `cookieyes`) out of the pasted snippet and attaches a single `<script src=… type=text/javascript id=…>` tag to the `<head>`. The CookieYes-hosted script is what actually renders the banner, scans/blocks cookies, and stores consent — this module only loads it. Note two shipped defects in this 3.0.0 release: (1) the settings route's `_form` points at a non-existent class `\Drupal\cookieyes_scripts\Form\BodyForm` (the real class is `\Drupal\cookie_consent_notice_by_cookieyes\Form\BodyForm`), so the admin form page errors until patched; and (2) the default-config file `config/install/cookie_consent_notice_by_cookieyes.settings` is missing its `.yml` extension, so no default config is written on install (config starts empty). Values can still be set with `drush config:set`. There is no config schema and no submodules.

---

- Add a CookieYes cookie-consent banner to a Drupal site without touching template files.
- Load the CookieYes script site-wide from the admin UI.
- Toggle the consent banner on/off with a single "Enable" checkbox.
- Comply with GDPR/CCPA cookie-consent requirements using a hosted CMP.
- Keep the CookieYes script out of admin pages (it only attaches on non-admin routes).
- Swap in a new CookieYes site/script ID by editing one textarea.
- Delegate cookie scanning/blocking and consent logging to CookieYes' hosted service.
- Give a specific role permission to manage the consent script (`cookieyes_scripts_settings`).
- Centralize the consent-script snippet in Drupal config rather than in the theme.
- Set the script via `drush config:set` in CI/deployment pipelines.
- Provide a consent banner across a multisite where each site has its own CookieYes account.
- Add consent management to an existing site with minimal code footprint.
- Load a specific CookieYes script by its `id` attribute (parsed from the snippet).
- Temporarily disable the banner (e.g. during maintenance) without deleting the snippet.
- Roll the consent script into config exports for environment promotion.
- Use CookieYes' auto-blocking to defer other tracking scripts until consent.
