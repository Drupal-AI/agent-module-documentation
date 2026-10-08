# webform_example_variant — agent start

Developer example module. Shows how to write a custom `@WebformVariant` plugin for A/B testing / personalization; copy to scaffold your own. Depends on `webform`. Ships a config schema but no config UI.

Key source (read directly — shorter than any summary):
- `src/Plugin/WebformVariant/ExampleWebformVariant.php` — variant plugin (`defaultConfiguration`, `buildConfigurationForm`, `applyVariant`, `isApplicable` scoping to `webform_example_variant_*`).
- `config/schema/webform_example_handler.schema.yml` — variant settings schema.
- `config/install/webform.webform.webform_example_variant_ab_test.yml`, `...segments.yml` — demo webforms.
- `templates/webform-variant-example-summary.html.twig` — variant summary.
