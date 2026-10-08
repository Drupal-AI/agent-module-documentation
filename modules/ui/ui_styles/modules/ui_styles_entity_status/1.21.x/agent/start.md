<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# UI Styles Entity Status — agent index

Applies UI Styles classes to any content entity rendered while **unpublished**. Configured on
each theme's *Appearance → Settings* form (an "Unpublished entity styles" selector); stored in
`<theme>.settings` → `third_party_settings.ui_styles_entity_status.unpublished`; merged onto the
entity build's `#attributes` by the `EntityView` hook when the entity is not published.

- **Config key, where to set it, and the unpublished-only render rule** →
  [configure/unpublished-styles.md](configure/unpublished-styles.md)

Key fact: `<theme>.settings` →
`third_party_settings.ui_styles_entity_status.unpublished` =
`{selected: {style_id: class}, extra: "classes"}` (constant
`UNPUBLISHED_CLASSES_THEME_SETTING_KEY`). No route/permission; configured via the core theme
settings form. Applies only to `EntityPublishedInterface` content entities that are unpublished.
