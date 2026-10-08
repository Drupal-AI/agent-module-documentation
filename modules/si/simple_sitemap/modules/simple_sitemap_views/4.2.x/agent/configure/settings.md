# Configure Views in sitemaps

Settings page at `/admin/config/search/simplesitemap/views` (route `simple_sitemap.views`).
Uses the parent module's `administer sitemap settings` permission (no own permissions).

## Per-view (Views UI)
Editing a **page** display exposes a **Simple XML Sitemap** section (a Views
*display extender*, `SimpleSitemapDisplayExtender`). There you:
- toggle **Index this display** into a sitemap variant,
- set `priority` and `changefreq`,
- for displays with contextual filters, enable **indexing of arguments** and cap how many
  argument combinations are indexed.

## How it works
- `ViewsUrlGenerator` (plugin id `views`, in `Plugin/simple_sitemap/UrlGenerator`) enumerates
  view routes during sitemap generation.
- `ArgumentCollector` (event subscriber) records real contextual-filter values as pages are
  requested, so argument-driven URLs can be discovered.
- `GarbageCollector` queue worker prunes stale indexed-argument records.

Config schema: `simple_sitemap_views.views.schema.yml` (settings stored on the view display).
Regeneration is driven by the parent module's queue — see the
[simple_sitemap drush commands](../../../../simple_sitemap/4.2.x/agent/drush/commands.md).
