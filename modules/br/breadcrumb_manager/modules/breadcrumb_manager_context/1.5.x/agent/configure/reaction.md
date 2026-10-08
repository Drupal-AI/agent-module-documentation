# Setting up Context breadcrumb titles

## 1. Enable the resolver
The `context_reaction` title resolver ships **disabled** (`enabled = FALSE` in its annotation).
Enable it on Breadcrumb Manager's settings form
(`/admin/config/user-interface/breadcrumb-manager`) in the *Title resolvers* table, and set its
weight relative to `menu_link_title` / `request_title` / `raw_path_component`. It is also inert if
the `context` module is not installed (`ContextReaction::isActive()` checks `moduleExists`).

## 2. Add the Breadcrumb reaction to a context
In the Context UI, add the **Breadcrumb** reaction to a context and set its *Breadcrumb title*
field. When that context is active for a page, `Breadcrumb::execute()` returns the string.

## How resolution works
`ContextReaction::getTitle($path, $request, $route_match)`:
- Gets active `breadcrumb` reactions for the segment's `$path` via `context.manager`
  (`getActiveReactions('breadcrumb')`), returns the first non-empty `execute()` result.
- Because a breadcrumb segment's path can differ from the current request, `getReactions()`
  temporarily pops the current request, pushes a request for `$path`, re-evaluates contexts, reads
  the reactions, then restores the original request and re-evaluates again.
- Results are cached per path (`cid = "context:$path"`) in the `cache.breadcrumb_manager` bin with
  tags `breadcrumb_manager`, `breadcrumb_manager_context`.

## Cache invalidation
`ConfigEventsSubscriber` (service `my_config_events_subscriber`) listens to config SAVE/DELETE; for
any `context.context.*` whose raw data contains a `reactions.breadcrumb` entry it invalidates the
two cache tags above, so title changes take effect immediately.

## Notes
- The reaction stores a plain title string (admin-entered via the Context UI). It is rendered as a
  breadcrumb `Link` title, escaped by the breadcrumb theme like any other segment title.
