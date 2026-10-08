<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# fences — agent start

Fences alters the **wrapping markup of fields**. It overrides core's `field.html.twig` and
adds eight per-field settings letting you pick the HTML tag (and CSS classes) for four
wrappers: the **field**, the **label**, the **items wrapper**, and each **item**. Choosing
the tag `none` removes that wrapper entirely.

Storage: settings are **third-party settings on the field's formatter**, saved into the
`entity_view_display` config for that bundle/view-mode under
`content.<field>.third_party_settings.fences.*` (schema `field.formatter.third_party.fences`).
Edit them in the collapsible **Fences** section under each field on **Manage display**
(gated by the `edit fences formatter settings` permission). A global settings form
(`fences.settings`, route `/admin/config/user-interface/fences/settings`) toggles whether the
override applies to all themes. Default field tag is `div`, label `div`, item `div`, items
wrapper `none`. Depends on nothing but core. Submodule **fences_presets** adds reusable
named tag bundles.

- Per-field wrapper tags/classes, the 8 settings keys, global settings, drush → [configure/fences.md](configure/fences.md)
- Tag registry (`*.fences.yml`), the `none` value, `fences.tag_manager`, alter hook → [plugins/tags.md](plugins/tags.md)
- The `field.html.twig` override and the preprocess variables it consumes → [theming/fences.md](theming/fences.md)
- Reusable preset entities that apply a bundle of tags in one click → [../../modules/fences_presets/3.0.x/agent/start.md](../../modules/fences_presets/3.0.x/agent/start.md)
