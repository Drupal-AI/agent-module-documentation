<!-- SPDX-License-Identifier: GPL-2.0+ -->
Views URL Path Arguments lets a view's contextual filter (argument) accept a URL path alias in the address and resolve it to the underlying entity ID, so a view can live at a clean, alias-based path instead of a numeric one.

---

The module ships two Views plugins that both register under the id `views_url_path`: an **argument default** plugin (`Entity ID converted from URL path alias`) and an **argument validator** plugin (`Entity ID from URL path alias`). When a view display has a contextual filter (e.g. Content: ID), you point that filter's *"Provide default value"* or *"Specify validation criteria"* at the `views_url_path` plugin. At runtime it reads the last raw parameter of the current route, and if it is not already numeric it looks the string up as a path alias via the core `path_alias.repository` service, returning the entity ID from the resolved system path. Both plugins expose two options: `provide_static_segments` (a checkbox) and `segments` (a slash-free string) which prepend a fixed prefix to the alias before lookup (e.g. `blog` so `blog/my-title` resolves). The default plugin caches per URL (`Cache::PERMANENT`, `url` context); the validator additionally accepts an already-numeric argument. The module has no configure route, no settings form, no permissions and no Drush — all configuration is per-view inside the Views UI, validated by the `views.argument_default.views_url_path` / `views.argument_validator.views_url_path` config schema.

---

- Let a view page use a human-readable URL alias in its contextual filter instead of a raw entity ID.
- Resolve `/blog/my-article-title` to the node ID so a view filtered on Content: ID renders the right node.
- Provide a default contextual-filter value derived from the current page's path alias.
- Validate an incoming contextual-filter argument by treating it as a path alias and converting it to an entity ID.
- Add a static URL prefix (e.g. `catalog`) so aliases under a known section resolve correctly.
- Build a "related content" block view keyed off the aliased entity on the current page.
- Drive a view embedded on an entity's canonical alias path without hard-coding IDs in the URL.
- Support clean, SEO-friendly URLs for view-driven listing/detail pages.
- Fall through gracefully when the argument is already a numeric entity ID (no alias lookup needed).
- Keep working under multilingual sites by looking up the alias in the current URL language.
- Prefix multi-segment aliases (e.g. `shop/products`) before resolving to the entity ID.
- Reuse the same view at both an aliased path and a numeric path since numeric arguments pass through.
- Avoid writing a custom argument default plugin just to map an alias to an ID.
- Feed the resolved entity ID into downstream relationships/filters in the same view.
- Let editors change a node's URL alias without breaking a view that keys off it.
- Fail validation (404) when an alias does not resolve to a numeric entity ID, keeping views tidy.
- Configure a page display's path with a wildcard while still resolving via alias.
- Provide alias-aware default arguments for taxonomy-term or user views, not just nodes.
- Cache the resolved argument permanently per URL for performance.
- Migrate legacy numeric-URL views to alias-based URLs without changing the underlying query.
