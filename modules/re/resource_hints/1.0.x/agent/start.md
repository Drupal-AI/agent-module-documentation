# Resource Hints — agent index

Adds W3C resource hints (`dns-prefetch`, `preconnect`, `prefetch`, `prerender`) to every page,
output as an HTTP `Link` header or an HTML `<link>` element. One admin form; one permission
(`administer resource hints`); no Drush; no dependencies. All work happens in
`resource_hints_page_attachments_alter()`.

- **The settings form, every config key, output modes, DNS-prefetch control, and the attach
  logic** → [configure/settings.md](configure/settings.md)

Key facts:
- Route `resource_hints.settings` → `/admin/config/development/performance/resources-hints`.
- Config object `resource_hints.settings`; per type `<type>_resources` (sequence of URLs) and
  `<type>_output` (0 = Link header, 1 = link element). Plus `dns_prefetch_control` (`on`/`off`).
- URLs pass through `UrlHelper::stripDangerousProtocols()` before output; the DNS-control string
  is `Html::escape()`d. Applied to all pages.
