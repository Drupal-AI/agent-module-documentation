# Meta tags on custom routes

Attaches Metatag configuration to non-entity **routes/paths** (module-provided controllers,
Views without an entity context, bespoke pages) that would otherwise emit no meta tags.

- Manage per-route tag mappings from the module's admin route
  (`metatag_routes.routing.yml` defines the UI/routes).
- A service (`metatag_routes.services.yml`) resolves the current route to its stored tag
  values and hands them to the Metatag manager for rendering.
- Values are token-enabled; any enabled tag submodule's tags are available.
- Use for utility pages (about/contact/search) and custom controllers needing SEO.

No config schema of its own; complements `metatag_page_manager` for Page Manager routes.
