Custom CSS Class to Body lets editors attach arbitrary CSS class(es) to the `<body>` tag of individual node pages, with an option to also emit the node's content-type machine name and per-content-type classes.

---

The module is entirely procedural (a single `.module` file, no plugins, services, routes, permissions or config entities). It adds two base fields to every node entity via `hook_entity_base_field_info()`: `body_class` (a string textfield for one or more space-separated CSS classes) and `specific_node_class` (a boolean checkbox). Both surface on the node add/edit form, grouped under a "Custom CSS Class to Body - Settings" details element in the form's *advanced* sidebar via `hook_form_node_form_alter()`. On the content-type edit form (`node_type_edit_form`), a "CSS class(es)" textfield is added and persisted as a third-party setting (`node_type_class.classes`) on the `NodeType` config entity. At render time, `hook_preprocess_html()` inspects the current route's `node` parameter and appends: the node's `body_class` value, the node's type machine name (when the checkbox is set), and the content-type-level classes — each pushed onto `$variables['attributes']['class']`. A shared validation callback (`_node_special_character_form_validate()`) rejects a set of special characters in both the node field and the content-type field. There is no admin settings page; configuration is per-node and per-content-type on their respective forms.

---

- Add a one-off CSS hook class to a single landing-page node so a theme can style just that page.
- Tag a specific node with a class (e.g. `campaign-2024`) used by custom CSS or JS.
- Append the content-type machine name (e.g. `article`, `page`) to `<body>` for every node of that type by ticking the per-node checkbox.
- Apply a house class to *all* nodes of a content type via the content-type edit form's "CSS class(es)" field.
- Give designers a per-node styling seam without touching templates or preprocess code.
- Drive layout variants (e.g. `full-width`, `no-sidebar`) from a body class chosen per node.
- Scope print or media-query CSS to particular pages by their body class.
- Add a feature-flag-style class to trigger conditional front-end JS behaviour on chosen nodes.
- Mark editorial states (e.g. `promo`, `sponsored`) as body classes for styling.
- Namespace A/B-test variants per node via distinct body classes.
- Let content editors, not developers, control page-level theming hooks.
- Provide theme-agnostic targeting: the class rides on `<body>` regardless of the active theme.
- Combine multiple classes on one node by separating them with spaces in the field.
- Distinguish node types visually (e.g. colour-code articles vs. basic pages) using the auto-appended type class.
- Apply a section-wide class to every node of a "Product" content type from one place.
- Support multilingual styling — both base fields are translatable, so classes can differ per translation.
- Retrofit legacy CSS that keys off body classes without migrating the stylesheet.
- Add analytics/tracking hooks that read a body class on specific pages.
- Quickly prototype page-specific styling during theme development.
- Give a per-node override that layers on top of the content-type default class.
