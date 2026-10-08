# webform_examples — agent start

Config-only demo module (no PHP). Installs example webforms showcasing advanced features; copy their config into your own forms. Depends on `webform`. No config UI, permissions, schema, or services.

Bundled example webforms (`config/install`, plus `config/optional` for cards):
- `example_computed_elements`, `example_computed_elements_ajax` — computed values.
- `example_element_states` — `#states` conditional logic.
- `example_flexbox_layout` — flexbox multi-column layout.
- `example_input_masks` — input masks.
- `example_wizard` — multi-step wizard.
- `example_style_guide` — element/theming preview.
- `example_cards` (optional, needs `webform_cards`).

To learn a feature, read the matching `config/install/webform.webform.<name>.yml` directly.
