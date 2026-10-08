# Silktide — agent index

Integrates Drupal with the hosted **Silktide** website-quality/SEO/accessibility service. On node
publish/update it POSTs the page URL to Silktide's API, and it injects an encrypted `silktide-cms` meta
tag for the Silktide toolbar. One config key (`apikey`), one permission, no plugins/Drush.

- **Settings form, the `apikey` config, the permission, and the exact phone-home / meta-tag behavior** →
  [configure/settings.md](configure/settings.md)

Key facts:
- Config UI: `/admin/config/services/silktide` (route `silktide.form`), permission `silktide configuration`.
- Config object `silktide.settings`: `apikey` (string), `lastnotified_time` (timestamp).
- Outbound POST to `https://api.silktide.com/cms/update` on publish/update of a **published** node
  (`SilktideService::notify`, subscribed to `SilktideEvent`). External dependency, by design.
- `silktide_page_attachments` adds `<meta name="silktide-cms">` on node pages = AES-256-CBC(edit-form URL)
  keyed by the API key.
