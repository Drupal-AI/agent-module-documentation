# webform_examples_accessibility — agent start

Demo module: installs example webforms for reviewing/testing accessibility. Depends on `webform`. No config UI, permissions, or schema. Ships a hook + CSS library for presentation only.

Bundled example webforms (`config/install/webform.webform.<name>.yml`):
- `example_accessibility_basic`, `example_accessibility_advanced`
- `example_accessibility_containers` — fieldset/legend grouping
- `example_accessibility_labels` — label/input association
- `example_accessibility_wizard` — accessible multi-step nav

Supporting files: `src/Hook/WebformExamplesAccessibilityHooks.php`, `css/webform_examples_accessibility.css`, `webform_examples_accessibility.libraries.yml`.
