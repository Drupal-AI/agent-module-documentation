# eu_cookie_compliance — agent start

Cookie‑consent banner for EU/GDPR compliance. Depends on core `filter`. Single settings
form at **Admin → Config → System → EU Cookie Compliance → Settings**
(`/admin/config/system/eu-cookie-compliance/settings`, route `eu_cookie_compliance.settings`).
Config object: `eu_cookie_compliance.settings`; cookie categories are `cookie_category` config entities.

- Configure banner, consent method, EU‑only, categories → [configure/settings.md](configure/settings.md)
- Theme the banner (templates + theme hooks) → [theming/templates.md](theming/templates.md)
- Add a consent‑storage backend (plugin) → [plugins/consent-storage.md](plugins/consent-storage.md)
- Alter visibility / GeoIP / cache id via hooks → [hooks/hooks.md](hooks/hooks.md)
- Permissions → [permissions/permissions.md](permissions/permissions.md)
