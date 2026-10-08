Scores field/display config: unused fields, orphaned storage, excess view/form modes, missing descriptions.

---

Registers the `fields` analyzer (`FieldsAnalyzer`, weight 2). It inspects entity types, bundles, fields, and display/form modes: flagging unused fields, orphaned field storage, missing field descriptions, questionable field visibility, bundles over `max_fields_per_bundle` (30), and excess view/form modes (over `max_view_modes` 5 / `max_form_modes` 2). The optional `analyze_field_usage` toggle enables deeper cross-display usage analysis. Includes a full field inventory and display-architecture overview.

---

- Detect fields attached to a bundle but not used in any display.
- Find orphaned field storage left after field deletion.
- Flag fields with missing descriptions and questionable visibility.
- Warn on bundles exceeding `max_fields_per_bundle` (30).
- Flag excess view modes (`max_view_modes` 5) and form modes (`max_form_modes` 2).
- Enable deeper usage analysis with `analyze_field_usage`.
- Review a complete field inventory and display architecture.
- Run headless: `drush audit:run fields --format=json`.
