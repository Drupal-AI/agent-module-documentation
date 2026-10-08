Tarte au citron is a Drupal integration for the [tarteaucitron.js](https://github.com/AmauriC/tarteaucitron.js) cookie-consent library: it renders the GDPR/RGPD consent banner and manager, and gates third-party services (ads, analytics, social, video, APIs, etc.) behind explicit user opt-in.

---

The module ships **no bundled JS library** — you must download tarteaucitron.js into `web/libraries/tarteaucitron/` (a `hook_requirements()` warns if `tarteaucitron.js` is missing, and swaps to `tarteaucitron.min.js` when present). At runtime `LibraryJsDiscover` reads the library's own JS files with regular expressions to discover: the available *services* (from `tarteaucitron.services.js`), the available config *defaults* and `parameters` (from `tarteaucitron.js`), the translatable *texts* (from `lang/tarteaucitron.<lang>.js`), the library *version*, and the available *languages* — all cached in the `services_js` cache bin. Those discovered lists drive everything: `hook_config_schema_info_alter()` builds the config schema dynamically, and the two admin forms are generated from them. A `tarte_au_citron` plugin type (managed by `ServicesManager`, a `DefaultPluginManager`) has one base plugin `TarteAuCitron` whose deriver turns every library service into a selectable service plugin. `hook_page_attachments_alter()` attaches the library on every page (unless the current user has `bypass tarte au citron`), builds `drupalSettings.tarte_au_citron` from the stored `tacConfig` (URL values passed through `UrlHelper::filterBadProtocol()`), the enabled services, and the chosen text strategy (`custom` overrides via `tarteaucitronCustomText`, `forced` pins a language via `tarteaucitronForceLanguage`), then `js/init.js` calls `tarteaucitron.init()`. Three permissions gate it: `administer tarte au citron` (settings form, `restrict access: true`), `translate tarte au citron` (texts form), and `bypass tarte au citron` (suppress the banner for a role). Config lives in `tarte_au_citron.settings` (the `tacConfig` map + enabled `services` + `services_settings`) and `tarte_au_citron.texts.settings` (`strategy`, `forced_lang`, `texts`); texts are sanitized with `Xss::filterAdmin()`. Three alter hooks (`hook_tarte_au_citron_SERVICE_ID_alter`, `hook_tarte_au_citron_config_alter`, `hook_tarte_au_citron_texts_config_alter`) let other modules add libraries/settings or edit the discovered config/texts.

---

- Display a GDPR/RGPD cookie-consent banner and preference manager on a Drupal site.
- Block Google Analytics / GA4 until the visitor explicitly consents.
- Gate embedded YouTube/Vimeo/Dailymotion videos behind a per-service consent placeholder.
- Require opt-in before loading social widgets (Facebook, X/Twitter, LinkedIn, etc.).
- Require opt-in before ad-network / advertising scripts run.
- Enable only the specific third-party services your site uses from the library's catalog.
- Configure tarteaucitron.js options (position, orientation, privacy URL, cookie name, …) from the UI.
- Override any consent-banner text string per language without editing the JS library.
- Force the consent UI into a specific language regardless of the interface language.
- Self-host the tarteaucitron.js library instead of relying on a CDN (it must live in `/libraries`).
- Automatically use the minified `tarteaucitron.min.js` when it is present.
- Let a role (e.g. authenticated editors) bypass the banner via `bypass tarte au citron`.
- Delegate text translation to a non-admin role via `translate tarte au citron`.
- Integrate a custom third-party service by implementing `hook_tarte_au_citron_SERVICE_ID_alter()`.
- Add extra config keys or texts programmatically via the `config`/`texts_config` alter hooks.
- Show a per-service "engage" fallback message when a service is disabled by the visitor.
- Keep consent configuration in exportable Drupal config for deployment.
- Pass service-specific parameters (e.g. an analytics ID) through the service settings form.
- Provide the "Deny all / Allow all" consent controls required by several DPAs.
- Localize the banner automatically to the current interface language when the library supports it.
- Surface the installed tarteaucitron.js version on the status report.
- Avoid loading any tracking scripts for visitors who have not consented (opt-in by default).
- Reuse the library's built-in service definitions rather than hand-coding each embed.
- Centralize consent for videos, maps, comments, support widgets, and APIs in one panel.
