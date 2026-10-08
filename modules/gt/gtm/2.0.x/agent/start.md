# GTM (gtm) 2.0.x

Injects the Google Tag Manager container snippet (head `gtm.js` script + `<noscript>`
iframe) into pages from one settings form. All state lives in the simple config object
`gtm.settings` (keys: `enable`, `google-tag`, `admin-pages`, `admin-disable`). No config
schema, no Drush command, no plugins. Configure route `gtm.settings` →
`/admin/config/system/gtm`, gated by the `administer gtm` permission. Requires Drupal core
`^11 || ^12` (2.0.x dropped D8/9/10).

- **Set the container ID, enable it, and control where it fires** → [configure/gtm.md](configure/gtm.md)
- **How the snippet is injected (hooks) and how to read/write config in code** → [api/gtm.md](api/gtm.md)
