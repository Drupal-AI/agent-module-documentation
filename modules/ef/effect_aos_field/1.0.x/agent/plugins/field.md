<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Effect AOS Field — plugins & rendering

## Field type
`effect_aos` (`EffectAosItem`) stores a JSON string in one text column: a per-entity list of `{target_field, effect, duration, easing, delay, anchor_placement}` entries.

## Widget
`effect_aos_widget` (`EffectAosWidget`): editor picks an **allowed** target field (configured in widget settings), effect, duration, easing, delay, anchor. `massageFormValues()` JSON-decodes and sanitizes each entry to a whitelist of keys before save.

## Formatter
`effect_aos_formatter` renders nothing itself — the effects are applied to the *target* fields, not this field.

## Render pipeline
1. `hook_entity_view` reads the JSON and stashes each effect onto its target field's render array.
2. `hook_preprocess_field` writes `data-aos`, `data-aos-duration`, `data-aos-easing`, `data-aos-delay`, `data-aos-anchor-placement` onto the target field wrapper (at preprocess so AOS registers triggers on first paint). Values go through Drupal's attribute system (auto-escaped).

## Options discovery
`effect_aos_field.attributes_manager` (`AttributesManager`) aggregates effect/easing/anchor option lists from any module or theme `*.options.yml`. Add a file to extend or override the lists.

## Library note
`animate_aos_library` pulls AOS 3.0.0-beta.6 from cdnjs without an SRI hash — consider vendoring the asset for integrity/offline.
