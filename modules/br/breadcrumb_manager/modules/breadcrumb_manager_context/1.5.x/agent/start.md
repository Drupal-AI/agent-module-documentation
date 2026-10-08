# Breadcrumb Manager - Context — agent index

Adds a Context-powered breadcrumb title source to Breadcrumb Manager: a `breadcrumb` Context
reaction (holds a title string) + a `context_reaction` title-resolver plugin that returns it.
Depends on `context`. No own config beyond the parent's settings form.

- **Setting it up: the reaction, the resolver, enabling it, caching** →
  [configure/reaction.md](configure/reaction.md)

Parent module: [../../../../1.5.x/agent/start.md](../../../../1.5.x/agent/start.md)

Key facts:
- `ContextReaction` plugin `breadcrumb` (`src/Plugin/ContextReaction/Breadcrumb.php`) — one
  `breadcrumb` textfield; `execute()`/`summary()` return the stored string.
- `BreadcrumbTitleResolver` plugin `context_reaction`
  (`src/Plugin/BreadcrumbTitleResolver/ContextReaction.php`), **`enabled = FALSE`** by default —
  enable it in Breadcrumb Manager settings. Inactive if `context` is not installed.
- Resolver swaps the request in the request stack to evaluate contexts for the segment path,
  caches reactions per path in `cache.breadcrumb_manager`.
- `ConfigEventsSubscriber` invalidates cache tags `breadcrumb_manager` /
  `breadcrumb_manager_context` when a `context.context.*` using the breadcrumb reaction is
  saved/deleted.
