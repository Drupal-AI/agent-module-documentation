A reference example module demonstrating how to add custom properties to existing Webform elements via alter hooks and expose them in the Webform UI.

---

Webform Element Properties Example is a developer teaching module showing the supported way to bolt extra configuration properties onto any Webform element without subclassing it. Its `WebformExampleElementPropertiesHooks` service implements four hooks: `hook_webform_element_default_properties_alter()` to declare the new default property, `hook_webform_element_translatable_properties_alter()` to mark it translatable, `hook_webform_element_configuration_form_alter()` to add a widget for it on the element edit form, and `hook_webform_element_alter()` to act on the property at render time. Because it depends on `webform_ui`, the new property appears in the element configuration UI. It uses the modern OOP `#[Hook]` attribute pattern registered through `webform_example_element_properties.services.yml`. There is no config, permissions, or schema — it is purely a copy-and-adapt scaffold for adding element properties from a custom module.

---

- Learn how to add a custom property to any Webform element.
- Copy as a scaffold for element-property alterations in your module.
- See the four alter hooks Webform provides for element properties.
- Study `hook_webform_element_default_properties_alter()` usage.
- Reference `hook_webform_element_configuration_form_alter()` to add UI widgets.
- Learn how to mark an added property as translatable.
- Model `hook_webform_element_alter()` for render-time behavior.
- Understand the modern `#[Hook]` attribute + service registration pattern.
- Add a data attribute or wrapper class to every element site-wide.
- Inject an extra setting into third-party or contrib elements you can't edit.
- Teach the Webform element alter API during developer onboarding.
- Provide a known-good hook implementation for QA of Webform UI.
- Verify custom properties persist through save/load of an element.
- Compare attribute-based hooks vs legacy `.module` hook functions.
- Prototype element-level behavior before writing production code.
- Expose a new option in the element edit form under Webform UI.
- Bootstrap a module that themes elements via added properties.
- Reference for writing tests around element property alters.
- Explore how default properties flow into element configuration.
