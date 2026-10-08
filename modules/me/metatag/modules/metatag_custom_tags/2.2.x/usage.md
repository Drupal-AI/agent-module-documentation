Lets you define your own custom meta tags through the admin UI — no code — and manage them like any other Metatag tag.

---

Sometimes you need a meta tag Metatag doesn't ship (a niche verification tag, a partner integration, an experimental structured-data hint). Instead of writing a `MetatagTag` plugin, this submodule adds a `metatag_custom_tag` config entity and admin UI where site builders define custom tags: name, type (meta name / property / link rel), group, and defaults. Defined tags then appear in every Metatag defaults form and per-entity field, with token support, exactly like built-in tags. It adds its own permission (`administer custom meta tags`) and config schema. Depends on the main Metatag module. Great for one-off or client-specific tags without deployments.

---

- Define a custom `<meta name>` tag without writing code.
- Define a custom `<meta property>` (Open Graph-style) tag.
- Define a custom `<link rel>` tag.
- Add a niche search-engine verification tag on the fly.
- Add a partner/integration-specific meta tag.
- Prototype an experimental structured-data tag.
- Group custom tags under a named tab in the Metatag form.
- Give custom tags default values with tokens.
- Manage custom tags as exportable config entities.
- Deploy custom tag definitions between environments.
- Grant `administer custom meta tags` to specific roles.
- Set custom-tag defaults globally or per bundle.
- Override custom tags per entity via the Metatag field.
- Avoid a code deployment for a single new tag.
- Support client requests for bespoke meta tags.
- Add vendor pixels/verification tags site-wide.
- Standardize custom tags across a platform.
- Remove obsolete custom tags from one screen.
