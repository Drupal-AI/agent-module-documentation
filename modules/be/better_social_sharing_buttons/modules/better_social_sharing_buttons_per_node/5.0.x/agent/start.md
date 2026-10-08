# better_social_sharing_buttons_per_node — agent start

Submodule of **better_social_sharing_buttons** (`part_of`). Adds a per-node on/off toggle for
the sharing buttons, configured per content type. Depends on the parent module.

- **No config UI** (`configure: null`). Settings live on the `node_type` as third-party
  settings under the `better_social_sharing_buttons_per_node` namespace:
  - `active` (int) — enable the feature for this content type.
  - `override` (int) — allow a per-node toggle.
  - `override_default` (int) — default state for new nodes (1 = enabled, 0 = disabled).
  Set on the content type edit form (`/admin/structure/types/manage/<type>`), in the
  "Better Social Sharing Buttons" details group.
- **Node field:** adds boolean base field `better_social_sharing_buttons_active` to nodes;
  when `active` + `override` are on, the node form shows a "Display the social sharing buttons"
  checkbox.
- **Permission:** `edit social sharing buttons node display` — gates who can see/change the
  per-type and per-node toggles.
- Implemented as OOP hooks (`BetterSocialSharingButtonsPerNodeHooks`):
  `entity_base_field_info`, `entity_bundle_field_info`, `form_node_type_form_alter`,
  `form_node_form_alter`.

Parent module docs: `../../../../better_social_sharing_buttons/5.0.x/agent/start.md`.
