<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
SEO Urls lets you define a clean, human-readable URL as an alternative to an existing canonical URL (typically one carrying query parameters, e.g. a filtered view), and surfaces it through a `seo-url` token for use in metatags.

---

Views and faceted listings often produce long, parameter-heavy URLs that are ugly and poor for SEO. SEO Urls stores `seo_url` config/content entities that each map a canonical URI to a nicer SEO URI. An inbound path processor (`SeoUrlPathProcessor`, priority 200) rewrites a requested SEO path back to its canonical internal path so routing still works, and an outbound processor (priority 400) can render the SEO form of a canonical path. The `SeoUrlManager` resolves the mappings (only entities with `status = TRUE` and both URIs set), merges the canonical URL's query parameters back onto the request, and exposes a `getSeoUrlToken()` used by the `[entity:seo-url]` token so you can point the canonical metatag at the SEO URL.

Entities are managed at `/admin/content/seo_url` (create/list/delete) and behaviour is configured at `/admin/structure/seo_url` (which entity types are eligible). All routes are permission-gated by a full CRUD permission set (`administer seo_url entities` is restricted; plus view/add/update/delete any/own). There is a "Create SEO URL" toolbar action that pre-fills the canonical field from the current page's redirect destination. Security review: URL resolution is driven entirely by admin/editor-created entities (stored as `internal:` link fields), not by arbitrary request input, so there is no open redirect or path-injection surface; the outbound processor explicitly collapses a leading `//` to a single slash to prevent protocol-relative external URLs (`SeoUrlPathProcessor::processOutbound`), and inbound resolution returns only a path (`getPathInfo()`), never an external target.

---

- Create a clean SEO URL for a filtered view page.
- Replace a long query-string URL with a readable path.
- Map /products/red-shoes to /catalog?color=red&type=shoes.
- Restrict which entity types can have SEO URLs.
- Manage SEO URL entities at /admin/content/seo_url.
- Create a SEO URL from the current page via the toolbar action.
- Expose the SEO URL through the [entity:seo-url] token.
- Point the canonical metatag at the SEO URL.
- Keep incoming requests working via the inbound path processor.
- Render outbound links in their SEO form.
- Preserve query parameters when resolving a SEO URL.
- Disable/enable a mapping via the entity status flag.
- Grant editors 'add/update own seo_url entities' permissions.
- Bulk-delete SEO URLs with the delete action.
- Provide SEO URLs for view pages via the seo_urls_views submodule.
- Improve shareability of complex listing URLs.
- Localize SEO URLs per language.
- Avoid duplicate SEO URLs via the unique-link constraint.
- Configure eligible content types at /admin/structure/seo_url.
