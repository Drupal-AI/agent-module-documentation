<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Extra Field Plus Example — agent index

Demo submodule of [Extra Field Plus](../../../../3.0.x/agent/start.md). Provides two ready-made
extra-field display plugins with settings for `node.*`. Enable it, then place the fields on a
node's *Manage display*. No configure route, no permission, no Drush.

- **The two example plugins, their settings, and how to place/configure them** →
  [plugins/examples.md](plugins/examples.md)

Key facts:
- Plugins: `example_node_label` (raw, `ExampleNodeLabel` → `ExtraFieldPlusDisplayBase`) and
  `example_node_label_formatted` (`ExampleNodeLabelFormatted` → `ExtraFieldPlusDisplayFormattedBase`).
- Both are `node.*`, `visible: false` (start Disabled on Manage display).
- Settings: `link_to_entity` (checkbox) and `wrapper` (select span/p/h1–h5, default `span`).
- Component ids on the display: `extra_field_example_node_label` /
  `extra_field_example_node_label_formatted`; settings live in that component's `settings`.
- Config schema: `field.formatter.settings.extra_field_example_node_label[_formatted]`.
