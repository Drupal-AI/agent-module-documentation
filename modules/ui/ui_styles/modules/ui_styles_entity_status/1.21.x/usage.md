<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
UI Styles Entity Status applies a chosen set of CSS classes to any content entity that is rendered while unpublished, so editors can instantly spot unpublished content in preview and on the front end.

---

This submodule adds an *Unpublished entity styles* `ui_styles_styles` selector to each theme's
system theme-settings form (`FormSystemThemeSettingsAlter`). The chosen `{selected, extra}`
mapping is saved into the theme settings config `<theme>.settings` under
`third_party_settings.ui_styles_entity_status.unpublished` (constant
`UNPUBLISHED_CLASSES_THEME_SETTING_KEY`). At render, an `EntityView` hook checks whether the
entity is a `ContentEntityInterface` implementing `EntityPublishedInterface` and is **not**
published; if so it merges the configured classes onto the entity build's `#attributes`. It has
no route or permission of its own (configuration piggybacks on the core theme settings form),
and uninstall clears the theme setting.

---

- Add a red border or "Unpublished" badge-style class to unpublished nodes.
- Tint the background of any unpublished content in preview.
- Help editors visually distinguish draft vs published content on the front end.
- Apply a diagonal-stripe or watermark utility to unpublished entities.
- Mark unpublished media or custom entities the same way as nodes.
- Give reviewers an obvious visual cue during editorial workflow.
- Add reduced-opacity classes to unpublished content.
- Apply a warning-colour outline to unpublished pages for content QA.
- Keep the unpublished styling consistent across all content types.
- Style unpublished content per theme (front-end vs admin theme).
- Use the extra free-text field for a one-off unpublished marker class.
- Export the unpublished styling as part of theme settings config.
- Combine with a design system's "state" utilities (e.g. `is-unpublished`).
- Signal unpublished state without editing every entity template.
- Add a dashed border to unpublished teasers in listings.
- Apply a muted text colour to unpublished content bodies.
- Make unpublished revisions visually obvious in preview.
- Provide an accessibility-friendly visual state for unpublished items.
- Roll out an "unpublished" visual convention site-wide in one form.
- Ensure translated unpublished content is flagged the same way.
- Quickly toggle the unpublished treatment by editing theme settings.
