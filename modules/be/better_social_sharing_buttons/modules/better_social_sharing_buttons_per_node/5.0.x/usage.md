Submodule of Better Social Sharing Buttons that lets editors turn the sharing buttons on or off on individual nodes, controlled per content type.

---

Part of the `better_social_sharing_buttons` project, this submodule depends on the parent module and adds a boolean base field, `better_social_sharing_buttons_active`, to node entities. On each content type's edit form (`/admin/structure/types/manage/<type>`) it adds a "Better Social Sharing Buttons" details group with three third-party-setting checkboxes/radios stored under the `better_social_sharing_buttons_per_node` namespace on the `node_type`: `active` (enable the feature for the type), `override` (allow a per-node toggle) and `override_default` (default state for new nodes, 1 = enabled). When both `active` and `override` are on, the node add/edit form shows a "Display the social sharing buttons" checkbox so editors can hide the buttons on a specific node. It defines one permission, `edit social sharing buttons node display`, which gates who can see and change those toggles. It provides no config UI of its own (`configure: null`); all settings live on the node type and per node. Behavior is implemented as OOP hook classes (`entity_base_field_info`, `entity_bundle_field_info`, `form_node_type_form_alter`, `form_node_form_alter`).

---

- Let editors hide the social sharing block/field on a single node while keeping it on for the rest of the content type.
- Enable per-node sharing control for the Article type only, leaving other types unaffected.
- Set a content type's new nodes to have sharing buttons enabled (or disabled) by default.
- Restrict who can change the per-node sharing toggle using the `edit social sharing buttons node display` permission.
- Provide a "Display the social sharing buttons" checkbox on the node edit form for chosen content types.
- Turn the whole feature on for a content type without exposing a per-node override (buttons simply active for all its nodes).
- Store the on/off state as a revisionable, translatable node base field (`better_social_sharing_buttons_active`).
- Bulk-clear the per-node field before uninstalling by disabling the override on the node type.
- Keep sharing decisions with content editors instead of site builders, per node.
- Pair with the parent block/field so the toggle actually controls whether buttons render for that node.
- Enable sharing for a content type but keep the per-node override off, so all its nodes always show buttons.
- Add the "Better Social Sharing Buttons" details group to a content type's edit form for site builders to configure.
- Give landing-page content types sharing buttons while leaving internal/utility types without them.
- Set new press-release nodes to have sharing enabled by default while allowing editors to opt a node out.
- Suppress sharing on legal or policy pages by unchecking the per-node display toggle.
- Query or update the `better_social_sharing_buttons_active` base field programmatically across nodes.
- Use the revisionable field so a node's sharing state is tracked through its revision history.
- Translate the sharing on/off state per language via the translatable base field.
- Migrate legacy per-node sharing flags into the `better_social_sharing_buttons_active` field.
- Gate the per-node toggle to trusted editors while hiding it from other authenticated users via the permission.
