<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Extra Field Settings Provider Example is the demo submodule of Extra Field Plus: it ships two working extra-field display plugins with settings that you enable and place on any node's Manage display to see the feature in action.

---

Enabling `extra_field_plus_example` registers two `@ExtraFieldDisplay` plugins for all node bundles (`node.*`, `visible: false` so they start in the Disabled region of *Manage display*): **`example_node_label`** (`ExampleNodeLabel`, extends `ExtraFieldPlusDisplayBase`) and **`example_node_label_formatted`** (`ExampleNodeLabelFormatted`, extends `ExtraFieldPlusDisplayFormattedBase`). Both render the node's label with the suffix "(from extra_field_plus example)" and expose two settings via `extraFieldSettingsForm()`: `link_to_entity` (checkbox — wrap the label in a link to the node) and `wrapper` (select an HTML tag: span/p/h1–h5, default `span`). They implement `defaultExtraFieldSettings()` and a `settingsSummary()`. Settings are stored in the placed component of the `entity_view_display` (e.g. `content.extra_field_example_node_label.settings`), validated by the submodule's config schema `field.formatter.settings.extra_field_example_node_label[_formatted]`. The `formatted` variant additionally implements `getLabel()`/`getLabelDisplay()` so it renders inside the standard field template with a label. This module is meant as a reference/starting point for writing your own Extra Field Plus plugins; it has no configure page, permission, or Drush.

---

- Enable it to demo Extra Field Plus without writing any code.
- See a raw-output extra field (`example_node_label`) with configurable settings.
- See a field-template-wrapped extra field (`example_node_label_formatted`) with a label.
- Try the `wrapper` setting to render a node label inside `span`/`p`/`h1`–`h5`.
- Try the `link_to_entity` setting to link the rendered label to the node.
- Copy `ExampleNodeLabel` as a template for a raw custom extra field plugin.
- Copy `ExampleNodeLabelFormatted` as a template for a formatted custom extra field.
- Learn the 3.x static-method API (`extraFieldSettingsForm`, `defaultExtraFieldSettings`).
- Study a working `settingsSummary()` implementation for the Manage display summary.
- Study a matching config schema (`field.formatter.settings.*`) for extra-field settings.
- Verify Extra Field Plus is working by placing an example field on Article display.
- Compare raw vs formatted base classes side by side in one module.
- Show per-view-mode settings by configuring the example field differently per mode.
- Use as a smoke test that extra field discovery and settings storage work on a site.
- Demonstrate storing extra-field settings in exported display config.
- Teach site builders how the extra-field cog/settings summary behaves.
