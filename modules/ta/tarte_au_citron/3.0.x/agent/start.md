# Tarte au citron — agent index

Drupal integration for the [tarteaucitron.js](https://github.com/AmauriC/tarteaucitron.js) cookie-consent
library. Renders the GDPR consent banner and gates third-party services behind opt-in. The JS library is
NOT bundled — install it into `web/libraries/tarteaucitron/`. Config forms are generated dynamically from
the installed library (parsed with regex by `LibraryJsDiscover`), so available options/services/texts
depend on the library version present.

- **The two admin forms, both config objects, every stored key, library install, text strategies** →
  [configure/settings.md](configure/settings.md)
- **The `tarte_au_citron` service plugin type, the deriver, and how services are discovered/attached** →
  [plugins/services.md](plugins/services.md)
- **The three alter hooks other modules can implement** → [hooks/hooks.md](hooks/hooks.md)
- **The three permissions and what they gate** → [permissions/permissions.md](permissions/permissions.md)

Key facts:
- `configure` route = `tarte_au_citron.configuration_js` at `/admin/config/tarte_au_citron/js`.
- Config objects: `tarte_au_citron.settings` (`tacConfig` map, `services` list, `services_settings`)
  and `tarte_au_citron.texts.settings` (`strategy`, `forced_lang`, `texts`).
- `hook_page_attachments_alter` attaches `tarte_au_citron/tarte_au_citron` + `drupalSettings.tarte_au_citron`
  on every page unless the user has `bypass tarte au citron`.
- `hook_requirements` warns when `libraries/tarteaucitron/tarteaucitron.js` is absent.
- Security posture (no finding): texts run through `Xss::filterAdmin()`, URL config keys through
  `UrlHelper::filterBadProtocol()`; all inputs are admin/translator config.
