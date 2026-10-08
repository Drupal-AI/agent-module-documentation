# context_active_trail — how it overrides core

Two integration points do the work. Neither requires configuration beyond adding the reaction.

## 1. `menu.active_trail` service override

`ContextActiveTrailServiceProvider` (a `ServiceProvider`, discovered automatically) swaps the core
`menu.active_trail` service class for `Drupal\context_active_trail\ContextActiveTrail`, a subclass
of core `MenuActiveTrail`. It adds the `context.manager` and a logger, and adds
`'context_active_trail'` to the service's cache tags.

Overridden method — `getActiveLink($menu_name = NULL)`:

- Iterates `contextManager->getActiveReactions('active_trail')`.
- For the first reaction that yields a `getLinkId()`, loads that menu link instance.
  - If the link plugin is missing → logs an error and returns `FALSE`.
  - If a `$menu_name` is passed and the link isn't in that menu → breaks out and falls back.
  - Otherwise returns that link instance (this becomes the active trail).
- If no context provides a link, falls back to `parent::getActiveLink()` (normal core behavior).

Because this replaces a core service, the forced trail affects menu-link highlighting, the
`menu.active_trail` used by menu blocks, and anything else that reads the active trail.

## 2. Breadcrumb builder

`ContextBreadcrumbBuilder` is registered as a `breadcrumb_builder` with **priority 110** (higher
than core's default builder), constructed with `context.manager`, `menu.active_trail`,
`plugin.manager.menu.link`, `title_resolver`, `request_stack`.

- `applies()` returns TRUE (and caches the reaction config) only when an active `active_trail`
  reaction has `setsBreadcrumbs()` true (i.e. its `breadcrumbs` checkbox is on). Otherwise it
  returns FALSE and core builds the breadcrumb.
- `build()` constructs the breadcrumb from the (now context-forced) active trail:
  - Starts with a **Home** link, adds `url.path` cache context.
  - Reverses the active-trail link ids and adds each as a breadcrumb link.
  - If `breadcrumb_title` is set, appends the current page title (resolved via `title_resolver`) as
    a final `<none>` link.

## Cache tag contract

`ContextActiveTrail::CACHE_TAG_BREADCRUMBS` = `"cache_tag_breadcrumbs"`. All breadcrumbs get this
tag (`hook_system_breadcrumb_alter`), and it is invalidated whenever an active_trail reaction is
created/updated/deleted, so pages pick up the right breadcrumb builder after a config change. If
you build breadcrumbs elsewhere and want them re-evaluated on context changes, add this tag.

## Extending

- To change which menu link is forced, implement your own logic by decorating `context.manager`
  reactions, or add conditions to the context — there is no hook specific to this module.
- Do not stack this with another active-trail-overriding module; the last service override wins and
  breadcrumb builders will compete by priority.
