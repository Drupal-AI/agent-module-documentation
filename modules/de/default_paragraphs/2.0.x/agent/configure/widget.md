# Configure the Default Paragraphs widget

No admin page of its own — configure it in a field's **form display** at
`/admin/structure/types/manage/{bundle}/form-display` (or the equivalent form-display route
for any entity type that has a Paragraphs / `entity_reference_revisions` field).

## Enable the widget
1. Ensure the field is an **`entity_reference_revisions`** field targeting a Paragraph type
   (a standard Paragraphs field). The widget's `field_types` is `entity_reference_revisions`.
2. On the form display, set that field's **Widget** to **"Default paragraphs widget"**
   (plugin id `default_paragraphs`).
3. Click the gear to open settings and Save.

## Settings (`settingsForm()`)
The widget inherits all Paragraphs stable-widget options plus a defaults table:

- **Paragraph Title / Plural Paragraph Title** — labels for the "Add new …" button.
- **Closed mode** — how closed paragraphs render (`summary` default, or `preview`).
- **Autocollapse** — collapse other open paragraphs when one is opened.
- **Add mode** — how new paragraphs are added (`dropdown` default, `select`, `button`, `modal`).
- **Form display mode** — form mode used to render each paragraph.
- **Enable widget features** — duplicate, collapse/edit-all, add-above, etc.
- **Default paragraph types** — a table of every allowed paragraph type with columns:
  - **Use as Default** (checkbox) — seed this type on new entities.
  - **Edit mode** — `Open` (expanded) or `Closed` (collapsed, default) for the seeded item.
  - **Weight** — drag to set the order seeded paragraphs appear.

## Behavior
- Checked types are added, in weight order, **only** when creating a new host entity and the
  field is currently empty (`formMultipleElements()` guards on `$max == 0 && isNew()`), and
  not while translating.
- **Cardinality guard:** you cannot check more default types than the field's cardinality.
  Over-selecting fails validation with "… allows you to select not more than N paragraph
  types as default." (Unlimited cardinality = no limit.) See
  `settingsFormDefaultParagraphsValidate()`.
- `settingsSummary()` lists the chosen title, closed mode, autocollapse, add mode, form
  display mode, and enabled features on the form-display overview.

To set field values on the seeded paragraphs (rather than just which types appear), subscribe
to the add event → [../extend/default-paragraphs-add-event.md](../extend/default-paragraphs-add-event.md).
