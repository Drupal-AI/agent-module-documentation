<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Dynamic Breadcrumb rewrites the labels of the breadcrumb items that Drupal core already generates, replacing the default text of entity links (node, taxonomy term, media, user) with an admin-defined, token-driven value chosen per entity type and per bundle.
---
The module does not build its own breadcrumb trail; it hooks into core's finished breadcrumb via `hook_system_breadcrumb_alter()` and, on the canonical routes of node, taxonomy term, media and user entities, walks the existing breadcrumb links and rewrites the text of any link that points at one of those entity routes. For each entity type + bundle you enable, you supply a text pattern (typically containing tokens such as `[node:title]` or `[term:name]`); the pattern is run through the Token service against the linked entity and the resulting string becomes the link label, falling back to the entity's own label when the replaced value is empty. Configuration is two steps: an Entity Types form (`dynamic_breadcrumb.entity_types_config`) selects which content entity types the module manages, then a Breadcrumbs settings form (`dynamic_breadcrumb.settings`) shows a collapsible fieldset per selected type with a checkbox and a token-enabled value field per bundle. The Token module provides the browsable token tree in the form. Everything is gated by the core `administer site configuration` permission; there are no custom permissions, services, plugins, or Drush commands. Note the module's `hook_requirements()` blocks installation if Easy Breadcrumb 2.0.7+ is present, because these features were merged upstream into Easy Breadcrumb.
---
- Replace the default breadcrumb label of a node with its title via `[node:title]`.
- Show a taxonomy term's name in the breadcrumb using `[term:name]`.
- Use a media item's name as its breadcrumb label with a media token.
- Display a user's name in the breadcrumb via a user token.
- Customize breadcrumb labels differently per content type (bundle).
- Give Article and Page nodes distinct breadcrumb label patterns.
- Combine tokens and static text in a breadcrumb label, e.g. a prefix plus `[node:title]`.
- Pull a field value (e.g. `[node:field_short_title]`) into the breadcrumb label.
- Choose which entity types the module manages from the Entity Types form.
- Enable dynamic labels only for specific bundles, leaving others untouched.
- Fall back to the entity's real label when the token pattern resolves to empty.
- Keep core's breadcrumb structure and links while only changing the visible text.
- Follow Drupal's recommended breadcrumb-alter approach rather than a custom builder.
- Use the Token browser in the form to discover available replacement tokens.
- Restrict breadcrumb-label configuration to site administrators.
- Shorten long entity titles in breadcrumbs by pointing the pattern at a shorter field.
- Localize or rephrase breadcrumb labels through token patterns per bundle.
- Apply a consistent breadcrumb label format across all pages of one entity type.
- Avoid writing a custom module just to relabel entity breadcrumb items.
- Turn dynamic labeling on or off per bundle by toggling its checkbox.
