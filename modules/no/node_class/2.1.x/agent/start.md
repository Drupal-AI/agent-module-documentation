<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Node class — agent index

Declares one **base field** `node_class` (`string`, label "CSS class(es)") on **every** node
via `hook_entity_base_field_info()`, shows it in a collapsible "Node Class settings" group on
the node form, and prints the value onto the rendered node's wrapper `class` attribute via
`hook_preprocess_node()`. No settings form (`configure: null`), no permission, no config
entity, no config schema — the value is ordinary node field content.

- **Set/read the class on a node, field storage, disabling it** →
  [configure/node-class.md](configure/node-class.md)
- **How the class reaches the markup (`attributes.class`) and templating notes** →
  [theming/output.md](theming/output.md)

Key facts:
- Field name is `node_class` (a base field — no `field_` prefix, present on all bundles).
- Stored per node/revision; multiple space-separated classes are stored as one string value and
  appended as a single class token.
- Output lives in `hook_preprocess_node()`: `$variables['attributes']['class'][] = $classes[0]['value']`.
