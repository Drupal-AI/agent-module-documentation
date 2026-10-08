Context Active Trail adds an "Active trail" reaction to the Context module so you can force the active menu trail — and optionally the breadcrumb — of any page based on the context it matches.

---

The module plugs into [Context](https://www.drupal.org/project/context): each context you define can carry an **Active trail** reaction that points at a menu link (chosen with the standard menu-parent selector). When that context is active, the module makes the page behave as though it lives under that menu link — e.g. every *article* node can appear to sit under a *Blog* menu item, highlighting it and expanding the menu accordingly. It does this by overriding the core `menu.active_trail` service with its own `ContextActiveTrail` (via a `ServiceProvider`); that subclass checks active context reactions first and returns the configured menu link, falling back to Drupal's normal behavior when no context matches. The reaction can also **override breadcrumbs**: a high-priority (`110`) `ContextBreadcrumbBuilder` rebuilds the breadcrumb from the forced active trail, with an option to append the current page title. Correctness is kept with a dedicated cache tag (`cache_tag_breadcrumbs`) that is invalidated whenever an active-trail reaction is saved or deleted, and `hook_install` clears the render cache once on enable. It has no settings page of its own — configure it through Context (Context UI recommended) — and it is incompatible with other modules that also take over the active trail, such as Menu Trail By Path.

---

- Make every node of a given content type appear under a chosen menu item (e.g. articles under "Blog").
- Highlight and expand the correct main-menu item on pages that aren't themselves menu links.
- Set the breadcrumb for a section of the site based on a matching context instead of URL structure.
- Force the active trail for a landing page built from a view so its menu parent stays highlighted.
- Give taxonomy term pages a consistent menu trail under a curated navigation item.
- Append the current page title to a context-driven breadcrumb for a complete trail.
- Keep a product or campaign microsite's menu highlighting consistent across all its routes.
- Drive breadcrumbs on entity pages that have no natural place in the menu hierarchy.
- Use Context's condition system (path, content type, role, etc.) to decide which trail applies.
- Provide different active trails to different user roles on the same page via role-based contexts.
- Set the active trail for search or listing pages so global navigation reflects the section.
- Unify menu highlighting for a group of pages that share a theme but live at unrelated paths.
- Override the trail per-language by combining with language-based context conditions.
- Ensure a "current section" menu block stays open on deep, menu-less content pages.
- Replace fragile path-based active-trail logic with explicit, condition-driven configuration.
- Point several contexts at different menu parents to model overlapping site sections.
- Give editorial hubs a stable breadcrumb even when their child content is reorganized.
- Highlight a "Documentation" menu item across an entire docs section regardless of URL depth.
- Configure the trail entirely through exported Context config for repeatable deployments.
- Temporarily reassign a page's menu context during a campaign without moving it in the menu.
