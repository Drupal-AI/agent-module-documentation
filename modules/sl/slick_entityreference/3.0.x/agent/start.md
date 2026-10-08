<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# slick_entityreference — agent start

Adds a Field UI display formatter that renders a **multi-value entity-reference field** as a
Slick carousel — each referenced entity (rendered in a chosen view mode) becomes a slide.
Primary formatter id `slick_entityreference_vanilla` for `entity_reference` and
`entity_reference_revisions` fields; sibling `slick_dynamicentityreference_vanilla` for
`dynamic_entity_reference`. Carousel behaviour comes from a **Slick optionset** (a `slick`
config entity, default `default`, from the Slick module), selected in the formatter's
`optionset` setting. The formatter only shows on **multi-value** fields. No settings form,
permissions, services, or Drush — all config is per-field on the `entity_view_display`.
Depends on `slick` (which brings Blazy).

- Point a reference field's display at the Slick formatter (formatter id, `optionset`/`view_mode` settings, drush/config) → [configure/slick_entityreference.md](configure/slick_entityreference.md)
- The formatter plugins it defines, their ids, field types, and applicability rule → [plugins/slick_entityreference.md](plugins/slick_entityreference.md)
