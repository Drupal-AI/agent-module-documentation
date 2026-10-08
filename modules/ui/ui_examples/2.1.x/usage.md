UI Examples (part of the UI Suite) lets modules and themes declare example pages — snippets of render arrays — that are collected into a browsable "Examples library" so theme developers can preview standard Drupal elements and design-system components in their theme.

---

Modules and themes define examples as YAML plugins discovered from a `ui_examples/` folder (`*.ui_examples.yml`) or a root `<extension>.ui_examples.yml` file, in any enabled module or theme. Each example has an `id`, `label`, `description`, `category`, optional `links`, `weight`, `enabled` flag, and a `render` array — the render array that gets displayed. The `ExamplePluginManager` (a `DefaultPluginManager` over `YamlDirectoryDiscovery` + `YamlDiscoveryDecorator`) loads them into `ExampleDefinition` objects, groups/sorts them by category, weight and label, and an alter hook `hook_ui_examples_examples` can modify them. The controller renders an overview at `/admin/appearance/ui/examples` (route `ui_examples.overview`, theme `ui_examples_overview_page`) and a single example at `/admin/appearance/ui/examples/{name}` (`ui_examples.single`), both behind the `access_ui_examples_library` permission; a parent "UI libraries" page (`/admin/appearance/ui`) aggregates sibling UI Suite libraries. For authoring ergonomics, examples may omit the `#` prefix on render properties — `ExampleSyntaxConverter` restores it (e.g. `type` → `#type`, `theme` → `#theme`, and known children like component `slots`, table `rows`, layout regions), so example YAML stays readable. The bundled **ui_examples_defaults** submodule ships two examples ("Normalize" standard HTML elements, "Status messages"). Note: the module's `update_8101` grants `access_ui_examples_library` to every role. No config UI, no Drush; requires PHP 8.3 and Drupal 11.4+.

---

- Preview standard HTML elements (headings, lists, tables, blockquotes) as your theme renders them.
- Preview Drupal status/error/warning messages styling.
- Build a living style guide for a custom or design-system theme.
- Let a theme declare example pages for its own components.
- Let a module ship example render arrays demonstrating its UI.
- Browse all registered examples grouped by category at `/admin/appearance/ui/examples`.
- View a single example in isolation to inspect its markup and styling.
- Author examples in readable YAML without typing `#` on render-array keys.
- Demonstrate a Single Directory Component (`type: component`) with slots.
- Show a layout example with regions rendered as children.
- Provide "external documentation" links alongside an example.
- Order examples with a `weight` and organize them by `category`.
- Disable a specific example without deleting it (`enabled: false`).
- Alter or remove examples from another module via `hook_ui_examples_examples`.
- Give front-end developers a fixed catalog of elements to QA against.
- Verify theme changes against a consistent set of reference elements.
- Aggregate multiple UI Suite libraries (styles, components, icons, patterns) under one admin page.
- Test dark-mode / responsive rendering of standard elements in one place.
- Onboard new themers by pointing them at the examples library.
- Ship a baseline set of element examples via the ui_examples_defaults submodule.
