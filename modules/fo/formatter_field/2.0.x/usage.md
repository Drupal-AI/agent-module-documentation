<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Formatter field adds a field whose value *is* a formatter choice: attach it to an entity, point it at another field, and an editor picks how that field is displayed on this particular entity.

---

Drupal decides display per bundle and view mode, which is the right default and occasionally the wrong granularity. The README's own example is the clearest one: a page type with an image field normally uses a single image style for every page, but sometimes an individual page needs a different crop — a full-width hero here, a thumbnail there — and the only supported answers are a new view mode, a new bundle, or a preprocess hack. This module makes the choice a field value instead, editable on the node form like anything else.

The pieces are a `FormatterItem` field type, a `FormatterWidget` for choosing formatter and its settings, and two formatters: `FromFieldFormatter`, which renders the target field using whatever was chosen, and `DefaultFormatter`. Because the choice is stored on the entity it is revisioned, translatable in the usual way, and visible to an editor rather than buried in Manage display.

The judgement to make is editorial governance. Handing display control to content editors is a deliberate loosening of the design system: it is exactly right for a marketing landing page and wrong for a strictly templated catalogue, where a hundred entities each choosing their own image style will drift. Scope it to the bundles that genuinely need it, and limit the formatters and settings the widget exposes so the choice stays within the design.

---

- Let an editor pick an image style per node.
- Vary a field's display on one entity without a new view mode.
- Give a landing page a full-width image while others stay small.
- Avoid creating a bundle just to change one display setting.
- Choose a date format per event.
- Select a text trim length per article.
- Store a display choice as a revisioned field value.
- Expose display control to editors on the node form.
- Configure formatter settings alongside the formatter choice.
- Replace a preprocess hook that switched formatters conditionally.
- Apply a different formatter in a promoted teaser.
- Limit per-entity display choice to specific bundles by only attaching the field there.
- Show editors only formatters core deems applicable to the target field type.
- Keep display variation out of the view mode explosion.
- Review how a specific entity is being displayed.