Lets you assign meta tags to arbitrary routes/paths that aren't entity pages, filling the gap for custom and module-provided pages.

---

Many pages in a Drupal site are not entities — module-provided routes, views without a canonical entity, or bespoke controllers — and therefore get no entity meta tags. This submodule lets site builders attach Metatag configuration to specific routes (by route name / path), so those custom pages can still emit proper title, description, and social tags. It registers a service and routes to manage this mapping and injects the tags at render time. Depends on the main Metatag module. Useful anywhere you need SEO on a non-entity page.

---

- Add meta tags to a module-provided custom route.
- Give a bespoke controller page a proper title/description.
- Set Open Graph tags on a non-entity landing page.
- Provide meta tags for a Views page lacking an entity context.
- Control robots indexing on a custom route.
- Set a canonical URL on a custom path.
- Use tokens in meta tags for custom routes.
- Fill the SEO gap for pages Metatag can't reach via entities.
- Configure per-route metadata from an admin screen.
- Keep custom-route metadata in exportable config.
- Standardize meta tags on utility pages (contact, about, search).
- Provide social previews for custom app pages.
- Override global defaults for a specific route.
- Manage metadata for API/landing endpoints that render HTML.
- Ensure no custom page ships without meta tags.
- Complement Page Manager integration for other custom routes.
