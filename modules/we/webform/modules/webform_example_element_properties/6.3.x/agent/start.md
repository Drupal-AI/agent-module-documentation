# webform_example_element_properties — agent start

Developer example module. Shows how to add custom properties to existing Webform elements via alter hooks, surfaced in the element edit UI. Depends on `webform` + `webform_ui`. No config, permissions, or schema.

Key source (read directly — shorter than any summary):
- `src/Hook/WebformExampleElementPropertiesHooks.php` — implements `webform_element_default_properties_alter`, `webform_element_translatable_properties_alter`, `webform_element_configuration_form_alter`, `webform_element_alter` using `#[Hook]` attributes.
- `webform_example_element_properties.services.yml` — registers the hook service.
