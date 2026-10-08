# inline_entity_form — agent start

Field widgets + a render element for creating/editing/removing referenced entities inline
on the parent form (order → line items pattern). Works on `entity_reference` and
`entity_reference_revisions` fields. No admin config page — configured per field on
**Manage form display**. No permissions, no Drush.

- Pick & configure a widget (Simple vs Complex, settings) → [configure/widgets.md](configure/widgets.md)
- Embed IEF in custom code via the `inline_entity_form` render element / `inline_form` handler → [api/element.md](api/element.md)
- Alter the embedded form, "add existing" form, or table columns → [hooks/hooks.md](hooks/hooks.md)
- Override the referenced-entities table template → [theming/table.md](theming/table.md)
