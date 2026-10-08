<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Custom body class — agent index

Adds CSS class(es) to the `<body>` tag of node pages — per node and/or per content type.
No configure route, no permission, no config schema, no plugins, no Drush. It works through
node **base fields** and a node-type **third-party setting**, applied in `hook_preprocess_html()`.

- **The two node fields, the per-content-type setting, and how classes reach `<body>`** →
  [configure/body-classes.md](configure/body-classes.md)

Key facts:
- Node base fields (on every node): `body_class` (string, space-separated classes) and
  `specific_node_class` (boolean → adds the node's content-type machine name as a class).
- Per-content-type: third-party setting `custom_body_class.classes` on the `node_type`
  entity (set on the node type edit form), applied to all nodes of that bundle.
- `custom_body_class_preprocess_html()` appends all three sources to the body `class` attribute.
- A validator blocks special characters (e.g. `^ £ $ % & * ( ) { } @ # ~ ? > < , | = +`) in the inputs.
