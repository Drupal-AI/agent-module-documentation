<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Reference Display adds an `entity_reference_display` field type that lets a content editor pick which display mode (view mode) a companion entity reference field should be rendered with, so the same reference can be shown differently per piece of content.

---

Out of the box a formatter for an entity reference field renders every referenced entity with one fixed view mode chosen by a site builder on Manage display. Entity Reference Display moves that choice to the editor: you add its **Display mode** field (`entity_reference_display`) to a bundle, and it stores a single view-mode machine name (a `varchar(255)` string such as `default`, `teaser`, or `full`) as an ordinary field value. The field offers the view modes as select options via core's Options widgets (it reuses the `list_string` widgets like `options_select` and `options_buttons`), and its settings let you **exclude** specific view modes, or flip `negate` to turn that list into an allow-list of the only modes offered. On the display side the module ships a **Selected display mode** formatter (`entity_reference_display_default`, extending core's entity view formatter) that you place on the actual entity reference field; at render time it reads the value of the display-mode field on the same entity and uses it as the view mode for the referenced entities. When more than one display-mode field exists on the bundle the formatter's `display_field` setting picks which one drives it, and a `erd-list--<view_mode>` CSS class is added to the field wrapper. Cardinality is locked to 1 (one choice per field), and when Entity Reference Revisions is installed the formatter transparently swaps to a revisions-aware variant.

---

- Let an editor choose per node whether a referenced entity renders as `teaser` or `full`.
- Give a "Related content" reference field an editor-selectable card vs. list view mode.
- Store a single view-mode machine name as a plain string field on a content type.
- Offer only a curated set of view modes by excluding all the others in field settings.
- Use `negate` to turn the exclude list into an allow-list of just the permitted modes.
- Render a paragraph reference with a display mode the author selects while editing.
- Drive a media reference's rendering (e.g. `thumbnail` vs `large`) from an editor choice.
- Present the choice as radio buttons via the `options_buttons` widget instead of a select.
- Present the choice as a plain select list via the default `options_select` widget.
- Add several display-mode fields to one bundle and bind each to a different reference field.
- Pick which display-mode field feeds a formatter with the formatter's `display_field` setting.
- Style referenced items differently per mode using the auto-added `erd-list--<mode>` class.
- Let editors switch a promoted block of references between compact and expanded layouts.
- Set a default view mode for new content via the field's default value.
- Control how Entity Reference Revisions (e.g. Paragraphs) items render, per host entity.
- Keep site builders' view modes central while delegating the pick to content authors.
- Show the same reference field as a slider on one node and a grid on another.
- Provide a "layout switch" on landing pages without Layout Builder or custom code.
- Migrate a hard-coded formatter view mode into an editor-controllable field value.
- Read the selected mode programmatically as `$entity->get('field_display_mode')->value`.
- Restrict which view modes appear so editors cannot pick internal/technical modes.
- Reuse core Options widgets and formatters with no extra widget code to maintain.
- Combine one display-mode field with multiple reference fields sharing the same choice.
