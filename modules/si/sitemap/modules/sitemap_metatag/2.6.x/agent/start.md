# sitemap_metatag — agent start

Trivial glue submodule of `sitemap`. Requires `metatag` + `sitemap`. Ships one config
object (`metatag.metatag_defaults.sitemap.page`) that registers the sitemap page as a
Metatag context, so you can set meta tags for the `/sitemap` page on Metatag's defaults
screen (**Admin → Config → Search and metadata → Metatag**).

No code, plugins, services, permissions, or schema of its own. Configure meta tags via
the Metatag module UI; configure the sitemap page itself via the base module
([../../sitemap/2.6.x/agent/configure/settings.md](../../../sitemap/2.6.x/agent/configure/settings.md)).
