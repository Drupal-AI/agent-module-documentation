# simple_sitemap — agent start

Generates hreflang XML sitemaps; sitemaps + settings are config entities. Admin UI:
**Admin → Config → Search and metadata → Simple XML Sitemap**
(`/admin/config/search/simplesitemap`, configure route `entity.simple_sitemap.collection`).

- Enable entity bundles, set priority/changefreq, manage variants → [configure/sitemaps.md](configure/sitemaps.md)
- Add a custom URL/sitemap generator plugin → [plugins/generators.md](plugins/generators.md)
- Generate & set bundle settings in code (generator service) → [api/generator.md](api/generator.md)
- Drush commands (generate, rebuild-queue) → [drush/commands.md](drush/commands.md)
- Alter/exclude links and attributes via hooks → [hooks/hooks.md](hooks/hooks.md)
- Permissions → [permissions/permissions.md](permissions/permissions.md)
