Breadcrumbs Visibility adds a per-node "Display breadcrumbs" checkbox (plus a per-content-type default) that suppresses the core breadcrumb block on individual nodes, letting editors turn breadcrumbs off page-by-page without touching block visibility rules.

---

The module adds a revisionable, translatable boolean base field `display_breadcrumbs` to all nodes (`hook_entity_base_field_info`), defaulting to TRUE, and surfaces it on the node edit form inside a "Page display options" details group (grouped under the `advanced` sidebar). It also adds a "Page display defaults" checkbox to the node type edit form, whose value is stored in simple config `breadcrumbs_visibility.content_type.<bundle>` (`display_breadcrumbs`) and used as the default for new nodes. Enforcement is via `hook_block_access()`: for the `system_breadcrumb_block` and the `view` operation, it loads the current route's node (handling `node_revision` too), reads the node's `display_breadcrumbs` value (falling back to the content-type config default when the node value is NULL), and returns `AccessResult::forbiddenIf($value == "0")` — otherwise `neutral`, so non-node routes and other blocks are unaffected. A `administer breadcrumbs visibility config` permission gates who may change the checkbox: without it, the widget is rendered `#disabled` on both the node and node-type forms (a UI restriction; the base field itself has no field-access handler). `hook_install` backfills `display_breadcrumbs = 1` for existing published nodes (direct DB updates on `node_field_data`/`node_field_revision`) and sets the module weight to 99 so it runs after modules like Scheduler; a `hook_clone_node_alter` marks cloned nodes so they inherit the source's value rather than the type default. Impact is limited to whether the breadcrumb block renders.

---

- Hide breadcrumbs on a specific landing page while keeping them site-wide.
- Turn breadcrumbs off for an entire content type by default (per-type default checkbox).
- Let editors toggle breadcrumb display per node from the node edit form.
- Default new nodes of a type to "no breadcrumbs" (e.g. campaign pages).
- Keep breadcrumbs on articles but off on full-width homepage-style nodes.
- Suppress breadcrumbs on print/landing nodes without custom block visibility PHP.
- Restrict who can change breadcrumb visibility via a dedicated permission.
- Preserve a node's breadcrumb choice across revisions (field is revisionable).
- Preserve breadcrumb choice across translations (field is translatable).
- Match a cloned node's breadcrumb setting to the original rather than the type default.
- Backfill existing content to "breadcrumbs on" automatically at install time.
- Give a content team a simple on/off control instead of editing the breadcrumb block.
- Override the per-type default on individual nodes as needed.
- Ensure breadcrumbs never appear on a legally-required standalone page.
- Provide a per-node display option that coexists with the core breadcrumb block config.
- Disable breadcrumbs on nodes without affecting Views, taxonomy, or other routes.
- Order the module after Scheduler so scheduled publishing still respects the setting.
- Expose the field in view display config if you also want to render it (configurable display).
- Let only privileged editors set breadcrumb visibility while others see it read-only.
- Roll out a policy of "no breadcrumbs on section front pages" per content type.
