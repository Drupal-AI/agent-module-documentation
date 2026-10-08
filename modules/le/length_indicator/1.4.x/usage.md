<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Length Indicator adds a colored bar under a text field's edit widget that shows, as the editor types, whether the current length is too short, acceptable, optimal, or too long against a configurable target range.

---

The module is a per-widget enhancement for core text fields: it has no field type, settings form, configure route, permissions, Drush commands, or plugins of its own. It hooks into the *Manage form display* page via `hook_field_widget_third_party_settings_form()`, adding a "Length indicator" checkbox plus three numeric options — **Optimum minimum** (`optimin`), **Optimum maximum** (`optimax`), and **Tolerance** — but only for the two supported widgets, `string_textfield` and `string_textarea` (checked by `_length_indicator_widget_is_supported()`). The choices are stored as a third-party setting on that field's component in the `entity_form_display` config entity (`third_party_settings.length_indicator.indicator: true` and `indicator_opt: {optimin, optimax, tolerance}`). At form build time `hook_field_widget_single_element_form_alter()` attaches the `length_indicator/length_indicator` library, adds `data-length-indicator-total` / `length-indicator-enabled` attributes to the input, and renders a `length_indicator` themed element whose colored segments (bad / ok / good / ok / bad) are computed by the `length_indicator.get_width_pos` service (`GetWidthPos::getWidthAndPosition()`). Validation enforces `optimax > optimin` and `tolerance < optimin`. The effect is purely an editing aid — stored values and formatters are untouched, and it does nothing on unsupported widgets or non-text fields.

---

- Show editors a live "too short / just right / too long" bar on an SEO page-title field.
- Guide meta-description-style summary fields toward an optimal character range.
- Keep teaser or card-summary text within a design's length budget.
- Encourage consistent headline lengths across a content type.
- Nudge authors writing social-share titles toward platform-friendly lengths.
- Constrain a "short description" string field to a house-style range without hard validation.
- Add editorial guidance to a plain-text textarea used for blurbs.
- Set a target of, e.g., optimum 50–60 characters with a 5-character tolerance on a title.
- Give a marketing team visual feedback on call-to-action button label length.
- Standardize product-name field lengths across an editorial team.
- Apply length guidance per form mode (e.g. only on the default form, not a custom one).
- Coach authors on abstract/summary length in a scholarly content type.
- Provide a soft length target where a hard `maxlength` would be too strict.
- Help translators keep translated strings near the source length.
- Visualize length ranges on a taxonomy term name or description field.
- Turn the indicator on for a textarea used for image alt-text guidance.
- Configure via exported config (`third_party_settings.length_indicator`) for deployment.
- Toggle guidance per environment by overriding the form-display config.
- Reduce over-long titles that break responsive layouts.
- Give new editors an at-a-glance sense of "good" content length.
- Apply to a string field on a media, user, or custom entity form.
- Set a wide tolerance for loose guidance or a tight tolerance for strict targets.
- Combine with core string fields without writing a custom widget.
- Improve content quality by discouraging one-word or over-padded titles.
