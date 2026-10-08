<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Custom body class lets editors add arbitrary CSS class(es) to the `<body>` tag of a node's page — per individual node, and/or for every node of a content type.

---

The module adds two **base fields** to every node entity: `body_class` (a string for one or more space-separated CSS classes) and `specific_node_class` (a boolean that, when checked, adds the node's content-type machine name as a body class). Both appear in a "Custom Body Class Settings" details group on the node add/edit form. At the content-type level it stores a per-bundle **third-party setting** `custom_body_class.classes` (a space-separated class string) set on the *node type edit* form, applied to all nodes of that type. On page render, `hook_preprocess_html()` reads the current route's node and appends: the node's own `body_class` value, the node type machine name (if `specific_node_class` is on), and the content type's stored classes — all onto `$variables['attributes']['class']` for the `<body>` tag. A form validator rejects a small set of special characters in the class inputs. There is no configuration page, no permission, no config schema, no plugins, and no Drush; everything is driven by the node fields and the node-type third-party setting.

---

- Add a one-off CSS class to a single landing-page node to give it a unique look.
- Tag a promotional node with a class so a campaign stylesheet targets only it.
- Add a class to every node of a content type (e.g. `blog-post`) via the node type form.
- Automatically add the content-type name as a body class using the per-node checkbox.
- Style all "Article" pages differently by setting a content-type-wide body class.
- Give print or PDF stylesheets a hook via a body class on specific pages.
- Add a theme/skin class (e.g. `dark-hero`) to selected nodes without template edits.
- Let content editors control body classes without touching Twig or CSS files.
- Apply multiple classes at once (space-separated) to a node's body tag.
- Differentiate layouts per node using body-scoped CSS selectors.
- Add JavaScript hooks (a body class) that scripts can detect on certain pages.
- Mark seasonal/holiday nodes with a class that toggles decorative styles.
- Combine a content-type class and a node-specific class on the same page.
- Provide per-node A/B styling flags via body classes.
- Add accessibility or high-contrast body classes to specific content.
- Give editors a body class field on any node type out of the box (base field).
- Namespace body classes per content type for scoped theming.
- Add a body class used by a cookie/consent or analytics integration on selected pages.
- Support translated class values (the fields are translatable).
- Avoid a custom preprocess-html module by using this ready-made field-driven approach.
