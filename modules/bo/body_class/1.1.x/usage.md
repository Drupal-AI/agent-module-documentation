<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Body Class adds admin-entered CSS classes to the `<body>` tag of individual nodes so you can target them with theme CSS/JS.

---

Body Class stores a free-text string of space-separated CSS classes per node in its own `body_class`
database table (keyed by `nid`) and emits those classes onto the page's `<body>` element via
`hook_preprocess_html`, but only on the node's own canonical route. Editors enter the value in a
"CSS Class(es)" textfield added to the node edit form under *Additional settings*; the field only
appears for users holding the access-restricted `administer body class` permission, and only on the
content types selected on the settings form (`/admin/config/development/body_class`, config object
`body_class.settings`, key `enabled_content_types`, defaulting to all types via the `_all` sentinel).
An admin usage list at `/admin/config/development/body_class/list` shows every node that has a class.
Values are validated on input (letters, digits, hyphens, underscores only) and sanitized again on
output with `Html::getClass()`, so the field carries CSS tokens, not markup. The module depends only on
core `node`, provides no fields/entities/plugins, and drops its table on uninstall (classes are not
recoverable). Core `^9 || ^10 || ^11`.

---

- Add one or more CSS classes to the `<body>` tag of a specific node.
- Style individual landing pages differently from the rest of the site.
- Give a node a class so a theme's CSS can target just that page.
- Attach per-node JavaScript behaviors keyed off a body class.
- Mark campaign/seasonal nodes with a class for temporary styling.
- Flag print- or PDF-oriented nodes with a body class for print CSS.
- Apply a layout-variant class (e.g. `full-width`, `no-sidebar`) per node.
- Limit which content types expose the Body Class field via the settings form.
- Enable the field for all content types (including future ones) with one checkbox.
- Enable the field for only a specific subset of content types.
- Restrict who can set body classes to trusted editors via `administer body class`.
- Review every node that has a body class from the admin usage list.
- Jump straight from the usage list to editing a node's classes.
- Add multiple space-separated classes to a single node at once.
- Remove a node's body class by clearing the field (its row is deleted).
- Have body-class rows cleaned up automatically when a node is deleted.
- Set body classes programmatically by assigning `$node->body_class_value` before save.
- Keep the class scoped to the node's canonical page only (not listings).
- Provide theme hooks without writing a custom preprocess function.
- Configure everything through the UI at `/admin/config/development/body_class`.
