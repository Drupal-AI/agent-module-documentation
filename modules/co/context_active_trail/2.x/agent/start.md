# context_active_trail — agent start

Adds an **"Active trail"** reaction to the [Context](https://www.drupal.org/project/context)
module: when a context matches, it forces the page's active menu trail (and optionally the
breadcrumb) to a chosen menu link. No settings page of its own — you configure it inside a
context (Context UI recommended). Depends on `context:context`.

Mechanism at a glance: it overrides core's `menu.active_trail` service with a `ContextActiveTrail`
subclass that consults active contexts first, and registers a high-priority breadcrumb builder.

## Capabilities

- [Configure the Active trail reaction (fields, stored config, cache)](configure/setup.md) — the
  `trail` / `breadcrumbs` / `breadcrumb_title` settings, defaults, schema, and cache invalidation.
- [How it overrides core (service swap, breadcrumb builder)](extend/active-trail.md) — the
  `ServiceProvider` menu.active_trail override, `ContextBreadcrumbBuilder`, the
  `cache_tag_breadcrumbs` tag, and known incompatibilities.
