<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Reference Overflow is a field formatter that tops up an entity-reference field's display with dynamically queried related content when fewer items are referenced than a configured minimum.

---

Entity Reference Overflow adds a **"Reference Overflow"** display formatter for `entity_reference` fields. It renders the entities an editor has manually referenced, and if that count is below a configured **Minimum Items** threshold, it runs an entity query to find additional published entities of the same target type/bundles and appends their rendered output until the threshold is reached. The extra ("overflow") entities can be constrained to share values in one or more other reference fields on the host entity, so the fallback pulls genuinely *related* content. This is aimed at "Related Content" sections that mix hand-picked curation with an automatic fallback. It has no dependencies beyond Drupal core, no permissions, no services, and no settings page — everything is configured on the field's formatter under *Manage display*. It runs on Drupal 8.8 through 11.

---

- Build a "Related Content" block that mixes editor-picked references with an automatic fallback.
- Guarantee a minimum number of teasers always render on an article's related-articles field.
- Let editors hand-pick a few references and have the field top up the rest automatically.
- Fill an under-populated reference field with the most recent published content of the target type.
- Pull dynamic fallback items that share a taxonomy term (via a configured tag reference field).
- Relate content by author, category, or any other entity-reference field on the host entity.
- Show N related nodes even when the curated field has fewer than N selections.
- Configure the minimum item count per view-display via the formatter settings.
- Choose the referenced-entity view mode (teaser, full, etc.) reused for both manual and overflow items.
- Constrain the dynamic fallback to specific bundles using the field's own handler settings.
- Exclude already-referenced entities from the overflow query to avoid duplicates.
- Exclude the host entity itself from the overflow query when the field targets the same entity type.
- Apply the formatter to reference fields on Paragraph entities, not just nodes.
- Keep curated "featured" items first, followed by dynamically discovered items.
- Provide a dynamic fallback for sparsely populated cross-reference fields.
- Surface recent published content in sidebars without building a View.
- Relate products, events, or articles by one or more shared category fields.
- Order the overflow results by the newest created date by default.
- Reuse the reference field's existing target-type/bundle configuration to decide the fallback pool.
- Avoid empty or short related-content sections on newly published pages.
- Set up manual-plus-dynamic related listings without writing custom code or a View.
