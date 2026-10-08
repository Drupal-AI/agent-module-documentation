Castorcito sync exports and imports Castorcito component configuration as a downloadable tarball, so you can move components between sites.

---

Castorcito sync is a sub-module of Castorcito (requires the core config module). It adds an export form at `/admin/castorcito/export` where you choose "All" or a selection of components; on submit it collects each selected `castorcito_component` and its `castorcito_category` config (recursing into container/advanced-container child components), reads them from core's config export storage, writes them into `config.tar.gz` in the temp directory, and redirects to a download route. The import form at `/admin/castorcito/import` accepts an uploaded tarball, extracts each YAML file, resolves its config-entity type from the filename prefix, and creates or updates the corresponding configuration entities on the current site.

---

- Export all Castorcito components to move them to another environment.
- Export just a few selected components and their categories.
- Carry container components together with their child components automatically.
- Download the component configuration as a `config.tar.gz` archive.
- Import a component package into a staging or production site.
- Migrate components built on a local site into a shared codebase or another site.
- Share a reusable component library between projects.
- Back up a curated set of components before making changes.
- Restore components on a fresh site after enabling Castorcito.
- Keep component definitions in sync across a multi-site setup.
