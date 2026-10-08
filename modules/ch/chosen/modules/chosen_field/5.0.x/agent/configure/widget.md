# The `chosen_select` widget

Field widget plugin (`src/Plugin/Field/FieldWidget/ChosenFieldWidget.php`), extends core
`OptionsSelectWidget`.

- **Plugin id:** `chosen_select` (label "Chosen"), `multiple_values: TRUE`.
- **Field types:** `list_integer`, `list_float`, `list_string`, `entity_reference`.
- **Where:** select it on a field's **Manage Form Display** row (the gear icon).

Widget settings (schema `field.widget.settings.chosen_select`, extends
`field.widget.settings.options_select`):

| Setting | Type | Meaning |
|---|---|---|
| `chosen_placeholder` | label | Placeholder text for this field's widget. |
| `no_results_text` | label | Message shown when a search matches nothing. |
| `search_contains` | int | Per-widget override for "search anywhere in word" behavior. |

Behavior and assets come from the main `chosen` module; this widget just scopes and configures
Chosen for one field.
