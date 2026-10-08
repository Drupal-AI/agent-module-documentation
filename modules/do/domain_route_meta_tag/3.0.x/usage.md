Domain Route Meta Tag sets per-route, per-domain meta tags on a Domain Access multi-site. You create records that map a path plus a domain to title/description/keywords, Open Graph, Twitter Card, canonical link and Facebook app-id values, and the module emits them into the page head when a visitor is on the matching domain and path.

---

The module adds a `domain_route_meta_tag` content entity (stored in the `domain_route_meta_tag` table) and an admin UI under Configuration to create one meta-tag record per (path, domain) pair. Each record picks a domain from the Domain module's active domains, a route path (e.g. `/user`, a Views page, a controller route — the path must resolve to a real, existing route), and any of: Meta Title, Meta Description, Meta Keywords, Canonical Url, OG Title/Description/Image Url/Url, Twitter Title/Description, and Facebook Application Id.

On every page request, `hook_page_attachments_alter()` reads the active domain from `domain.negotiator` and the current path, then loads the matching record — it tries the current path alias first, then the internal path — scoped to the active domain. When a record is found it appends `<meta name="...">` tags to the head plus a `<link rel="canonical">`. The `title` field is emitted as `<meta name="title">`, not as the page `<title>` element. The Canonical Url and OG Url fields are stored as a path and served prefixed with the record's domain scheme + hostname; the other fields are emitted verbatim.

Each record has an optional "Is Cachable" flag: when checked, the record's rendered meta data is written to Drupal's default cache under a key derived from the domain and path (4-hour lifetime, tag `domain_route_meta_tag`) so later requests skip the entity load. Route paths are validated on save (must start with `/`, must resolve to an existing route, and `(route_link, domain)` must be unique). At least one Domain entity must exist or the module reports an install/runtime requirement error. Per its README the module is intended for controller routes and Views pages; for nodes and taxonomy pages use the Metatag module instead.

---

- Give a Views listing page a distinct meta title and description on one specific domain of a Domain Access site.
- Set a custom canonical URL for a controller-provided page so duplicate paths across domains point to one address.
- Emit Open Graph title, description, image and URL for a landing page so it previews correctly when shared on Facebook/LinkedIn.
- Emit Twitter Card title and description for a marketing route.
- Publish a Facebook Application Id (`fb:app_id`) meta tag on a domain's pages.
- Serve different meta titles for the same path (e.g. `/products`) across two or more affiliate domains.
- Add meta keywords to a legacy controller route that has no node behind it.
- Point the canonical link of a domain's `/user` page at the domain's own hostname rather than the default site.
- Override the OG image per domain so each brand shares its own logo.
- Provide SEO metadata for a REST/JSON-driven page that Metatag cannot target because there is no entity.
- Cache the meta output for a high-traffic route by ticking "Is Cachable" to avoid an entity query per request.
- Manage all route/domain meta records from one admin list at `/admin/config/system/domain_route_meta_tag/list`.
- Ensure a promotional URL shared on social media resolves to the correct absolute domain URL via the OG Url field.
- Localize meta text by saving a record in a specific language (the add/edit form exposes a language selector).
- Add canonical + OG + Twitter tags to a search results page that lives on only one domain.
- Differentiate meta descriptions for the same controller route depending on which domain served it.
- Set a per-domain title tag for a dashboard or account page that core leaves untitled for SEO purposes.
- Assign metadata to a path alias (the matcher tries the alias before the internal path).
- Keep brand-specific social metadata in one place instead of scattering it across theme templates.
- Provide fallback meta tags for controller routes not covered by any entity-based Metatag configuration.
- Restrict meta-tag editing to trusted editors via the module's dedicated permission.
- Bulk-review which domains and routes have custom meta configured from the admin listing.
- Add an OG image URL to an otherwise imageless landing route so social previews render a thumbnail.
- Change a route's canonical target without touching code or theme templates.
