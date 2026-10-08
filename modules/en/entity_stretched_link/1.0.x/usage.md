<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Adds a "Stretched Link" display pseudo-field to entities so the whole rendered card/teaser becomes clickable, enabled per view-display on Manage Display.

---

Entity Stretched Link is a very lightweight display helper. Via `hook_entity_extra_field_info()` it registers an extra display component named "Stretched Link" on every entity type and bundle, hidden by default. When a site builder enables that component for a given view-display on the Manage Display screen, `hook_entity_view()` injects an empty core link (`#type => 'link'`) pointing to the entity's canonical URL, carrying the CSS class `stretched-link`, `rel=tag`, and a visually-hidden "Read more about <title>" accessible title. Combined with a theme-provided `.stretched-link::after` absolute-overlay rule (the classic Bootstrap "stretched link" pattern), the whole rendered area becomes a single click target that navigates to the entity. The module ships no CSS, JS, config, routes, or permissions — it depends only on core `field` and supports Drupal 10 and 11.

---

- Make an entire node teaser clickable so any click opens the full node.
- Turn a card/grid tile into a single click target linking to its entity.
- Enable the effect only on specific view-displays (e.g. Teaser, not Full).
- Add a whole-card link to taxonomy term displays.
- Add a whole-card link to media entity displays.
- Add a whole-card link to user profile card displays.
- Add a whole-card link to any custom content entity bundle.
- Provide an accessible "Read more about <title>" link for screen readers.
- Reduce the need for a per-bundle custom "read more" link field.
- Build Bootstrap-style card components that are fully clickable.
- Replace a manually-templated overlay `<a>` in a Twig template.
- Apply the effect per bundle by toggling the pseudo-field in Manage Display.
- Keep the visible title/other links non-clickable-conflicting via CSS z-index.
- Use with Views entity-rendered rows to make each row card clickable.
- Use with Layout Builder view-displays that render an entity teaser.
- Link search-result cards to their source entity.
- Provide a link that always resolves to the entity's current canonical URL.
- Localize the target URL to the entity's own language automatically.
- Avoid shipping extra CSS by reusing an existing theme `.stretched-link` rule.
- Add the clickable-card behavior without writing any custom PHP or plugins.
- Position the pseudo-field among other display components by adjusting weight.
