<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Field Label Override lets a field's label be changed per entity view display (view mode), rather than once on the field configuration.

---

Install it like any contributed module (`composer require drupal/field_label_override`, then enable at Admin > Extensions or `drush en field_label_override`); it depends only on core **Field** and needs no other setup, has no settings page, and adds no permissions. All configuration is per field and per view mode on **Manage display** (Structure > Content types > *type* > Manage display, and the equivalent page for any other entity — taxonomy terms, media, blocks, Paragraphs, users). Switch to the view mode you want (or the Default), and in the **Label** column of a field pick one of the three options this module adds — **Above (Overridden)**, **Inline (Overridden)**, or **- Visually Hidden (Overridden) -**. An **Override label** textfield (up to 255 characters) and a **Preserve original label** checkbox then appear for that field; type the label you want for this view mode and save. With *Preserve original label* unchecked, the custom text simply replaces the field's label in that display. With it checked, the original label is left in place and the custom text is exposed to the theme as a separate `label_override` Twig variable, so a `field.html.twig` override can render both. Overrides are stored in the view display configuration as third-party settings, so they export with your configuration and are set per view mode independently — nothing is stored globally on the field itself. To remove an override, set the field's Label back to a normal (non-overridden) option and save.

---

- Give a field a different label in the teaser view mode.
- Show "From" instead of "Start date" in a compact card.
- Rename a shared field per view mode without editing code.
- Keep a field's original label but expose a second one to the template.
- Avoid a preprocess function just to reword a label.
- Avoid duplicating a field only to change its label.
- Set a context-appropriate label for a search-result display.
- Override a field label on a taxonomy term display.
- Override a field label on a media entity display.
- Override a field label on a block or Paragraph.
- Use a shorter visible label to save space in a listing.
- Export field-label overrides with configuration.
- Set label overrides per view mode independently.
- Expose a custom label to Twig as `label_override`.
- Preserve the original label while showing a different visible one.
- Reword a field label for a print or PDF display.
- Change a label without a new field type or formatter.
- Remove an override by choosing a non-overridden Label option.
- Configure labels from Manage display instead of from code.
- Apply overrides to fields on any entity type.
