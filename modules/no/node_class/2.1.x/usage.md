<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Node class adds a single "CSS class(es)" text field to every node so editors can type arbitrary CSS classes that are then printed onto the rendered node's wrapper element.

---

Node class is a tiny styling helper. It declares one base field, `node_class` (a `string` field labelled "CSS class(es)"), on the `node` entity type via `hook_entity_base_field_info()`, so the field exists on *every* content type with no per-bundle field setup. On the node edit form the field is grouped into a collapsible "Node Class settings" details element placed in the form's `advanced` (sidebar) group by `hook_form_node_form_alter()`. At render time `hook_preprocess_node()` reads the stored value and appends it to the node template's `attributes.class`, so whatever the editor typed becomes a class on the node's wrapper (the `<article>` element in most themes). There is no admin settings page, no permission of its own, no config entity, and no config schema — the value is stored as node field content and travels with the node/revision. It is a per-node styling hook: give one node a `featured` class, another a `two-column` class, and target them from your theme CSS.

---

- Add a `featured` CSS class to a single promoted article so the theme can style it differently.
- Give a landing-page node a `full-width` class to trigger a wide layout in the theme.
- Tag specific nodes with a `dark-theme` class for a per-node color scheme.
- Apply a `two-column` class to certain pages without creating a new content type or view mode.
- Let editors flag a node as `highlight` and style it with a colored border in CSS.
- Add a print-specific class like `print-hide` to nodes that should not appear in print stylesheets.
- Attach a JavaScript hook class (e.g. `js-carousel`) to a node so front-end behaviors target it.
- Mark seasonal content with a `holiday` class for temporary themed styling.
- Give sponsored posts a `sponsored` class for disclosure styling.
- Differentiate event nodes with an `event--upcoming` or `event--past` class typed by the editor.
- Add multiple classes at once (space-separated) to a node's wrapper element.
- Provide a quick per-node override class without touching Twig templates or preprocess code.
- Let a site builder style one specific node by URL/id using a memorable class instead of `.node-123`.
- Apply a `no-sidebar` class on a per-node basis to hint layout regions.
- Give press-release nodes a `press` class to pull them into a branded style.
- Tag nodes for A/B visual experiments with an experiment-specific class.
- Add a `bg-brand` utility class (Tailwind/utility CSS) to selected nodes.
- Flag deprecated/archived nodes with an `archived` class that dims them via CSS.
- Store an editorially chosen class that persists across node revisions.
- Provide content authors a self-service way to apply approved theme classes without developer involvement.
