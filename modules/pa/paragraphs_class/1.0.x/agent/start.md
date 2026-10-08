<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Paragraphs Class — agent index

A single Paragraphs **behavior plugin** that adds a per-paragraph "Wrapper class" text field; the
entered value is appended to the paragraph's wrapper `class` attribute at render. Depends on
contrib `paragraphs`. No config UI (`configure` null), no permissions/schema/Drush of its own.

- **Enable the behavior on a Paragraphs type, set the class, where it is stored & rendered** →
  [configure/behavior.md](configure/behavior.md)

Key facts:
- Plugin id `paragraphs_class_paragraph_class`, label "Paragraphs wrapper class"
  (`src/Plugin/paragraphs/Behavior/ParagraphsClassBehavior.php`), extends `ParagraphsBehaviorBase`.
- `isApplicable()` → TRUE for all Paragraphs types.
- Behavior setting key: `wrapper_class` (single free-text field, no validation/whitelist).
- `view()` does `$build['#attributes']['class'][] = <wrapper_class>` (Drupal escapes class values on render).
- Editing the field is gated by Paragraphs core permission "edit behavior plugin settings".
