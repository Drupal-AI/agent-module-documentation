# webform_example_element — agent start

Developer example module. Enable to learn how to add a custom Webform element; copy to scaffold your own. Depends on `webform`. No config UI, permissions, services, or config schema.

Key source (read directly — shorter than any summary):
- `src/Element/WebformExampleElement.php` — the Form API render element.
- `src/Plugin/WebformElement/WebformExampleElement.php` — the `@WebformElement` plugin (`defineDefaultProperties`, `prepare`, `preview`).
- `config/install/webform.webform.webform_example_element.yml` — demo webform using the element.
