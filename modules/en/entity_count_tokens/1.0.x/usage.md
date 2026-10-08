<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Adds a token group whose tokens resolve to the number of entities of a given type (and bundle).

---

Entity Count Tokens extends Drupal's Token system with a dynamic `entity_count_token` type. Any place that accepts tokens can embed `[entity_count_token:ENTITY_TYPE]` (for entity types with a single bundle, e.g. `user`) or `[entity_count_token:ENTITY_TYPE:BUNDLE]` (for entity types with multiple bundles, e.g. `[entity_count_token:node:article]`), and it is replaced by the current count. Counts are produced with the entity query API: content-entity counts run an access-checked aggregate count query, while config-entity counts use `loadMultiple()`. The module is pure token integration — no configuration form, no routes, no services file, no external dependencies — and it works on Drupal 8 through 11. To render tokens inside body/formatted-text fields you typically also enable the contrib Token Filter module.

---

- Show the total number of nodes of a bundle, e.g. `[entity_count_token:node:article]`.
- Show the number of published/basic pages with `[entity_count_token:node:page]`.
- Display a live count of registered users with `[entity_count_token:user]`.
- Display a Commerce product count per type, e.g. `[entity_count_token:commerce_product:default]`.
- Count taxonomy terms in a vocabulary, e.g. `[entity_count_token:taxonomy_term:tags]`.
- Put "We have N articles" style dynamic copy into a block or basic page.
- Add counters to a landing page hero without writing custom code.
- Include an entity count in an email/message template that supports tokens.
- Surface a media item count, e.g. `[entity_count_token:media:image]`.
- Show a comment count across the site with `[entity_count_token:comment]`.
- Show a file entity count with `[entity_count_token:file]`.
- Report a count of a custom content entity type by machine name.
- Build a simple site-statistics block from several count tokens together.
- Feed an entity count into any field or setting that runs token replacement.
- Combine with Token Filter to render the token inside WYSIWYG/body text.
- Give content editors a no-code way to embed counts that stay current.
- Display per-bundle breakdowns for a multi-bundle entity type.
- Show a total for a single-bundle entity type without naming a bundle.
- Count config entities (e.g. views, roles) via the same token syntax.
- Drive marketing copy such as "Join N members" that updates automatically.
- Add counts to a footer or sidebar informational block.
- Reuse the same count token across multiple pages consistently.
- Prototype a stats display quickly before building custom reporting.
