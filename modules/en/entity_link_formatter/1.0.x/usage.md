<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Link Formatter is a field formatter that renders an entity-reference field as a link built from any of the referenced entity type's link templates (canonical, edit-form, delete-form, etc.), with token-driven link text, route parameters and an optional return destination.

---

Entity Link Formatter adds one field formatter (plugin id `entity_link`, label "Entity link") for `entity_reference` fields. Instead of rendering the referenced entity's full content, it renders each referenced entity as a single hyperlink whose target is chosen from the entity type's registered link templates (for example `entity.node.canonical` or `entity.node.edit_form`). The link text is a configurable string that supports tokens (e.g. `[node:title]`), and up to three route parameters can be filled from tokens against either the referenced entity or the entity being displayed. An optional destination setting appends a `?destination=` query (including a `[current-destination]` shortcut) so the target page can send the user back afterward. Access is respected: it iterates core's `getEntitiesToView()` and also checks `Url::access()` before emitting a link, so links to entities/routes the viewer cannot use are silently skipped. It targets Drupal 10 and 11, needs no other module, and optionally uses the Token module for the token-browser helper in its settings form.

---

- Render an entity-reference field as a compact link instead of the full referenced entity.
- Link a referenced node/user/term to its canonical page.
- Link a reference to the referenced entity's **edit form** (e.g. inline "Edit" links in a list).
- Link a reference to the referenced entity's **delete form** for quick admin cleanup.
- Use any registered link template of the target entity type, not just canonical.
- Set custom link text such as "View", "Edit", or "Open".
- Use tokens in the link text, e.g. `[node:title]` to label the link with the referenced title.
- Add a `?destination=` back-link so editors return to the current page after editing.
- Use the `[current-destination]` token to redirect back to the exact page being viewed.
- Build a destination from a token like `[node:url:path]` against the displayed or referenced entity.
- Fill a route's first/second/third parameter from a token (e.g. `[node:nid]`).
- Choose per parameter whether the token context is the referenced entity or the displayed entity.
- Create "edit this referenced item" affordances on a parent entity's display.
- Provide action links in Views/entity displays that point at referenced content.
- Show a reference on a teaser as a link rather than an embedded render.
- Reduce page weight by linking references instead of rendering their full view mode.
- Present a list of referenced entities as a list of hyperlinks.
- Route to custom entity link templates provided by other modules.
- Hide links automatically when the viewer lacks access to the target route.
- Skip referenced entities that are unsaved (new) or that resolve to no route.
- Configure everything per view display on the Manage display screen (no global config).
- Combine with the Token module's browser to discover available replacement tokens.
- Link references to non-canonical routes such as revision or moderation pages when those templates exist.
- Attach the referenced entity's cache tags automatically so links invalidate correctly.
- Offer editors quick navigation between related content items.
- Keep display markup minimal while still driving users to full entity pages.
