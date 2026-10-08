# yoast_seo — agent start

Real-time on-page SEO analysis in entity edit forms via the rtseo.js library. Builds on
`metatag` + core `path`/`views`. Requires the external **goalgorilla/rtseo.js** library under
`/libraries/rtseo.js`. Global settings: **Admin → Config → Real-time SEO**
(`/admin/config/yoast_seo`, route `yoast_seo.settings`).

- Enable per bundle + global score settings → [configure/settings.md](configure/settings.md)
- The `yoast_seo` field (type/widget/formatter) & how to add it → [configure/field.md](configure/field.md)
- Services: SeoManager, EntityAnalyser → [api/services.md](api/services.md)
- Metatag override + theme/entity-build hooks it uses → [extend/integration.md](extend/integration.md)
- Permissions → [permissions/permissions.md](permissions/permissions.md)
- Templates / theme hooks → [theming/templates.md](theming/templates.md)
