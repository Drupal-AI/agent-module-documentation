# default_paragraphs — agent start

Adds a field widget (`default_paragraphs`, "Default paragraphs widget") for
`entity_reference_revisions` Paragraphs fields that **pre-seeds** one or more paragraphs
when a new host entity is created. Extends the Paragraphs stable widget
(`ParagraphsWidget`). Depends on `paragraphs`. No routes, permissions, config schema, or
Drush commands.

- Select the widget in a field's form display and pick which paragraph types are seeded (and how they open) → [configure/widget.md](configure/widget.md)
- Subscribe to `DefaultParagraphsEvents::ADDED` to modify each seeded paragraph before it is added → [extend/default-paragraphs-add-event.md](extend/default-paragraphs-add-event.md)

Key source: `src/Plugin/Field/FieldWidget/DefaultParagraphsWidget.php`,
`src/Events/DefaultParagraphsAddEvent.php`, `src/Events/DefaultParagraphsEvents.php`.
