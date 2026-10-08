DiBa Tag Manager Cookie Warn adds a Google Tag Manager container and a multilingual cookie-consent banner (with Google Consent Mode v2) to a DiBa Drupal site.

---

The submodule (`diba_integration_cogo`) provides one settings form at `/admin/config/system/diba_integration_cogo` (`administer site configuration`). `DibaIntegrationCogoHooks` (`#[Hook]`) injects the front-end code: `hook_page_attachments` adds the `google-site-verification` meta tag and the `tmcw_head` head markup (the DiBa consent script from `maqueta.diba.cat`, per-language banner texts, and the Consent Mode v2 `gtag('consent', 'default'|'update', …)` calls plus the GTM loader), and `hook_page_top` adds the GTM `<noscript>` iframe. The GTM snippet only renders when a real container ID is set (i.e. not the `GTM-XXXXXX` placeholder). The settings form (`SettingsForm`) exposes per-language banner text/links (built from the site's installed languages), an extra CSS `style`, cookie `expire` days, the site-verification code, the GTM code, and the `granted`/`denied` choices for ad and analytics storage in the default, accept and reject states. All values are stored in the `diba_integration_cogo.settings` config object.

---

- Add a Google Tag Manager container to every page of a DiBa site through configuration.
- Show a cookie-consent banner styled with the DiBa corporate front-end assets.
- Configure Google Consent Mode v2 default, accept and reject states for ad_storage and analytics_storage.
- Only load GTM once a real container ID replaces the `GTM-XXXXXX` placeholder.
- Provide multilingual consent text (Catalan, Spanish, English, or any installed language) with per-language accept/reject labels.
- Set a per-language "more info" link to the privacy-policy / legal-notice page.
- Configure how many days the consent choice is remembered (cookie expiry).
- Add the `google-site-verification` meta tag for Google Search Console.
- Apply extra inline CSS to tweak the banner appearance.
- Update analytics/ad storage consent dynamically when a visitor accepts, via the banner's accept callback.
