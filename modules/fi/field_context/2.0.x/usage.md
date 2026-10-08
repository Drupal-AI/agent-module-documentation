<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Field Context adds one Views **argument default** plugin, `fcmatch` ("Field from route context"), that defaults a contextual filter from a field on the current page's node — so an embedded view can filter itself by, say, the host node's category without any custom code or URL argument.

---

Views contextual filters can default from the URL, the current user, or a fixed value, but not from an arbitrary field on the page's node. This plugin fills that gap. In the contextual filter's settings, under "When the filter value is NOT available → Provide default value", you pick **Field from route context**; its options form first asks you to choose a **content type** (`fcftype`), then — via core `#states`, because an AJAX callback inside the plugin class is not callable — reveals a second select listing the fields on that bundle, built from `entity_field.manager`'s node field map. At runtime `getArgument()` reads the chosen field name, pulls the node from the current route (`$this->routeMatch->getParameter('node')`, checked with `instanceof NodeInterface`), confirms the node actually has that field, and returns `->getString()` on it. The plugin is node-only; if there is no node on the route or the node lacks the field it returns nothing, so the view falls back to whatever its "value not available" behavior is (set that deliberately). It implements `CacheableDependencyInterface` with `getCacheContexts()` returning `['url']` and `getCacheMaxAge()` returning `Cache::PERMANENT`, which keeps an embedded view's cache correct per page. There is no settings page, no permission, and no Drush command — configuration lives entirely inside the Views UI.

---

- Filter an embedded view by a field on the current node.
- Show related content sharing the host page's taxonomy term.
- List other items from the same department as this page.
- Drive a view from an entity-reference field on the page.
- Build a "more like this" block without custom code.
- Filter a listing by the current page's region field.
- Reuse one view across many pages with different context.
- Show sibling content under the same parent reference.
- Filter events by the venue referenced on the current node.
- Avoid writing a custom argument default plugin.
- Keep the contextual filter configuration inside the Views UI.
- Pick the source field per content type through the options form.
- Fall back gracefully when the current route has no node.
- Return NULL rather than erroring when the field is absent.
- Keep the embedded view cached correctly per URL.
- Show documents tagged like the current guide page.
- Filter a directory listing by the current channel's field.
- Build cross-linking blocks on landing pages.
- Support several content types with one plugin configuration.
- Reduce duplicated views built only to hard-code a filter value.
- Pass a multi-value field into a filter set to allow multiple values.
- Contextualize a "same author" or "same series" listing per node.
