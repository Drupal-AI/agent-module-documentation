# webform_example_handler — agent start

Developer example module. Shows how to write a custom `@WebformHandler` submission handler; copy to scaffold your own. Depends on `webform`. Ships a config schema for its settings but no config UI of its own.

Key source (read directly — shorter than any summary):
- `src/Plugin/WebformHandler/ExampleWebformHandler.php` — full handler lifecycle (`defaultConfiguration`, `buildConfigurationForm`, `submitForm`, `confirmForm`, `preSave`/`postSave`, `getSummary`) with a debug switch that prints each method call.
- `config/schema/webform_example_handler.schema.yml` — settings schema (`message`, `debug`).
- `templates/webform-handler-example-summary.html.twig` — handlers-page summary.
- `config/install/webform.webform.webform_example_handler.yml` — demo webform.
