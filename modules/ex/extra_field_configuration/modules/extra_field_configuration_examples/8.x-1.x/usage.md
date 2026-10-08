<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Ships two sample Extra Field Configuration plugins (a simple one and a formatted one) so you have working providers to create extra-field instances from.

---

Extra Field Configuration Examples is the optional submodule of `extra_field_configuration`. It
contains two `@ExtraFieldDisplay` plugins that both declare the module's
`ExtraFieldConfigurationDeriver`, so once enabled they show up as selectable providers on the *Add
extra field instance* form at `/admin/structure/extra-field`. `ExampleField`
(id `example_configurable_field`) extends `ExtraFieldDisplayBase` and renders a static string via
`view()`. `ExampleFormattedField` (id `example_configurable_formatted_field`) extends
`ExtraFieldDisplayFormattedBase`, renders a static string via `viewElements()`, and defines
`getLabel()` / `getLabelDisplay()` so it displays wrapped in the standard field template with an
"above" label. They are demonstration/reference code only — static translated output, no settings,
routes, permissions, config or services of their own — meant to be copied when writing your own
configurable extra field plugins.

---

- Get working extra-field providers immediately after installing Extra Field Configuration.
- See a minimal simple extra field plugin (`ExampleField` / `ExtraFieldDisplayBase` / `view()`).
- See a minimal formatted extra field plugin (`ExampleFormattedField` / `ExtraFieldDisplayFormattedBase` / `viewElements()`).
- Learn how to add the deriver annotation that makes a plugin configurable.
- Create test instances at `/admin/structure/extra-field` and place them on an entity display.
- Verify the module works end-to-end before writing custom plugins.
- Copy the class structure as a starting template for a real extra field plugin.
- Compare label handling between the simple and formatted base classes.
- Confirm the `extra_field_{machine_name}` field name renders in a Twig template.
- Demonstrate reusing one plugin as multiple named instances on the same entity.
- Provide onboarding examples for developers new to Extra Field / Extra Field Configuration.
- Disable it in production once you have your own plugins.
- Show how a formatted plugin injects `string_translation` via `ContainerFactoryPluginInterface`.
- Illustrate the `getLabelDisplay()` = "above" label placement.
- Use as a smoke test for Manage-display integration after upgrades.
