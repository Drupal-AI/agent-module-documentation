Breadcrumb Manager - Context adds a title resolver (and a Context reaction) so that a breadcrumb segment's title can be supplied by the Context module: you configure a "Breadcrumb" reaction on a context with a title string, and matching pages use it as their breadcrumb title.

---

The submodule (depends on `context`) provides two plugins. A `Breadcrumb` **Context reaction** (`@ContextReaction(id="breadcrumb")`) with a single "Breadcrumb title" textfield, whose `execute()` returns the configured string. And a `context_reaction` **breadcrumb title resolver** (`@BreadcrumbTitleResolver`, disabled by default) that, for the segment being resolved, evaluates the active contexts for the segment's path and returns the title from the first active `breadcrumb` reaction. Because the segment path may differ from the current request, the resolver temporarily swaps the request in the request stack and re-evaluates contexts (restoring afterward), caching the resulting reactions per path in the dedicated `cache.breadcrumb_manager` bin; a config event subscriber invalidates that cache (tags `breadcrumb_manager`, `breadcrumb_manager_context`) whenever a context using the breadcrumb reaction is saved or deleted. Enable the `context_reaction` resolver in Breadcrumb Manager's settings to activate it. There is no config of its own beyond the parent's form and the Context UI.

---

- Set a breadcrumb segment title from a Context reaction instead of a route/menu title.
- Give landing pages or grouped sections a custom breadcrumb title via Context conditions.
- Override the breadcrumb title for a path pattern using a context.
- Provide breadcrumb titles for route-less or dynamic paths through Context.
- Centralize breadcrumb title overrides in the Context UI.
- Apply a breadcrumb title based on any context condition (path, role, etc.).
- Enable the `context_reaction` resolver and prioritize it via weight in Breadcrumb Manager.
- Keep breadcrumb titles in sync automatically (cache invalidated when contexts change).
- Combine Context-based titles with menu-link/page-title resolvers as fallbacks.
- Define per-section breadcrumb labels without code.
- Use context conditions to vary breadcrumb titles by environment or audience.
- Manage breadcrumb titles for campaign/landing paths from Context.
- Add a breadcrumb reaction to an existing context configuration.
- Resolve titles for paths whose real title is not suitable for breadcrumbs.
- Extend breadcrumb behavior without writing a custom title-resolver plugin.
