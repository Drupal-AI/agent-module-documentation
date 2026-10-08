# klaro — agent start

Cookie/consent manager: a Klaro! banner gates third-party services until the visitor
opts in. Consent is modeled as **Services** (`klaro_app`) grouped by **Purposes**
(`klaro_purpose`), both config entities. Admin UI: **Admin → Config → User interface →
Klaro!** (`/admin/config/user-interface/klaro`, route `klaro.admin`).

- Global settings + banner/modal text → [configure/settings.md](configure/settings.md)
- Define/manage services & purposes (the consent entities) → [configure/services-purposes.md](configure/services-purposes.md)
- Gate scripts/iframes/embeds until consent (JS + `klaro_filter`) → [api/decorate-external.md](api/decorate-external.md)
- Permissions → [permissions/permissions.md](permissions/permissions.md)
