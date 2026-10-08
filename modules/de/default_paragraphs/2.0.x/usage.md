Default Paragraphs adds a field widget for `entity_reference_revisions` (Paragraphs) fields that pre-populates one or more paragraphs when a host entity is created, so editors start from a ready-made content structure instead of a blank field.

---

The module extends the Paragraphs "stable" widget with a new widget plugin, `default_paragraphs` ("Default paragraphs widget"), selectable in a paragraph field's form display. Its settings form reuses all the standard Paragraphs options (title, closed mode, autocollapse, add mode, form display mode, features) and adds a `default_paragraph_types` table listing every allowed paragraph type with a "Use as Default" checkbox, an Edit mode (Open/Closed) select, and a drag weight. When a **new** host entity's add form is rendered and the field is empty, `formMultipleElements()` creates a `Paragraph` entity for each checked type (in weight order) and seeds them as the field's initial items. A field-storage cardinality check prevents selecting more defaults than the field allows (validated in `settingsFormDefaultParagraphsValidate()`). Right before each default paragraph is placed, the widget dispatches `DefaultParagraphsEvents::ADDED` (`'default_paragraphs.added'`) with a `DefaultParagraphsAddEvent`, letting other modules read/replace the paragraph entity (e.g. to set default field values) via `getParagraphEntity()` / `setParagraphEntity()` and read the host bundle via `getTargetBundle()`. Defaults appear only on entity **creation** (not edit), only when the field is empty, and not while translating. The module has no admin routes, permissions, config schema, or Drush commands; it depends only on Paragraphs.

---

- Pre-populate a new node's paragraph field with a fixed content skeleton (e.g. hero + body + CTA).
- Give editors a ready-made starting structure instead of an empty Paragraphs field.
- Add several different paragraph types as defaults on one field, in a defined order.
- Set the order defaults appear using per-row drag weights.
- Choose whether each default paragraph opens expanded (Edit mode: Open) or collapsed (Closed).
- Enforce a consistent page layout across all content of a bundle.
- Reduce editor clicks by removing the need to manually "Add" common paragraphs.
- Swap the standard Paragraphs widget for the Default paragraphs widget on any `entity_reference_revisions` field.
- Keep all familiar Paragraphs widget options (add mode, closed mode, autocollapse, form display mode, features) while adding defaults.
- Limit default selections to the field's cardinality (validation blocks over-selection).
- Programmatically set default field values on each seeded paragraph via an event subscriber.
- Replace a seeded paragraph entity entirely from a subscriber before it is added.
- Vary default paragraph seeding based on the host entity's bundle (from the event's target bundle).
- Populate default paragraph text/media from tokens or config in a subscriber.
- Standardize onboarding content for a new content type across a site.
- Provide a template-like default body for landing pages built with Paragraphs.
- Ensure required-field paragraph types are present and open on the add form.
- Apply defaults only to brand-new entities, leaving existing content untouched.
- Build multi-field Paragraphs forms where each field seeds its own defaults.
- Drive editorial consistency without writing a custom widget from scratch.
