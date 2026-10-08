<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Bookmark Field gives an entity a stable, human-readable identifier (a "bookmark") and lets you reach or render that entity by the bookmark instead of its numeric ID.

---

Bookmark Field adds a `bookmark` field type whose value is a short text key (e.g. `homepage_hero`, `privacy_policy`) that stays constant across environments, so content can be referenced by name rather than by its environment-specific node/entity ID. From that key the module offers several resolution paths: a redirect route `/bookmark/redirect/{entity_type}/{bookmark}` that forwards to the target entity's canonical URL (preserving query parameters); a **Bookmark block** that renders a chosen entity by its bookmark, field name and view mode; a `bookmarkFieldRender()` Twig function for templates; two **Views argument-default** plugins (a fixed bookmark, or one pulled from a path component of the current URL); and a `[bookmark:<name>]` **token** that resolves to a node's URL. The service/block/Twig render paths check the entity's published status and `view` access before emitting anything, so a bookmark is a lookup key, not an access grant. Depends only on core Field and Block; there is no settings page.

---

- Give a "Homepage Hero" node a bookmark like `homepage_hero` so it can be embedded identically on dev, staging and production regardless of its node ID.
- Add a `bookmark` field (commonly `field_bookmark`) to a content type via Structure → Content types → Manage fields.
- Set a per-entity bookmark value on the node edit form.
- Link to content by a stable URL such as `/bookmark/redirect/node/privacy_policy` that always resolves to the current canonical page.
- Preserve query parameters through the redirect (e.g. `?utm_source=...` is carried onto the canonical URL).
- Place a Bookmark block in a region to render a specific entity by its bookmark value.
- Configure the Bookmark block's entity type, field name, view mode and bookmark value.
- Render a bookmarked entity inside a Twig template with `{{ bookmarkFieldRender('node', 'my_bookmark') }}`.
- Render a bookmarked entity in a non-default view mode via the Twig function's fourth argument.
- Drive a View's contextual filter from a fixed bookmark using the "Bookmark" argument-default plugin.
- Drive a View's contextual filter from a bookmark taken out of the current URL path using the "Bookmark from URL" plugin.
- Point the "Bookmark from URL" plugin at a specific path component (1-based index) or at the path alias instead of the internal path.
- Insert a `[bookmark:homepage_hero]` token in a text field or path pattern to output a node's URL by bookmark.
- Reference stable content keys from a decoupled/headless front-end instead of numeric IDs.
- Swap which node appears in a fixed layout region by changing the bookmark value, without a developer editing configuration.
- Constrain bookmark storage per field: maximum length, ASCII-only, and case sensitivity.
- Restrict who may edit the bookmark widget value with the intended "edit bookmark" permission (see the caveat in the agent docs about how it is registered).
- Use Pathauto + Token alongside it to build automatic aliases that reference bookmarked content.
- Serve the same promotional/legal block (hero banner, privacy notice) across environments by bookmark.
