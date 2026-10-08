<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Micon Content Type adds an "Icon" picker to the content-type (node type) add/edit form so each content type can carry a Micon icon, shown in the content-types admin list and exposed for reuse through the `micon_icons` string-matching system.

---

The submodule implements `hook_form_node_type_form_alter()` to add a `#type => 'micon'` element to the node type form, and an entity builder saves the chosen icon id as a **third-party setting** on the `node_type` config entity: `third_party_settings.micon_content_type.icon` (e.g. `fa-file`). It swaps the node type list builder for `MiconContentTypeListBuilder`, which prepends an "Icon" column rendering each type's icon via `micon()->setIcon()`. Through `hook_micon_icons_alter()` it also registers dynamic `micon_icons` definitions — `content_type.<label>` and `content_type.<machine_name>` both pointing at the type's icon — so `micon('content_type.article')` (or the lowercased label) resolves to that icon anywhere. Changing an icon invalidates the `micon.discovery` cache tag. There is no settings form and no `configure` route; the icon lives entirely on the node type config. Helper `micon_content_type_icon($type)` returns the stored id.

---

- Give the Article content type a document icon shown in the content-types list.
- Assign a distinct icon to each content type for a clearer admin overview.
- Store a content type's icon in config so it deploys with `config export`.
- Read a content type's icon in code with `micon_content_type_icon($node_type)`.
- Render a content type's icon anywhere via `micon('content_type.article')`.
- Match by human label too: `micon('content_type.basic page')` resolves via the lowercased label alias.
- Show content-type icons in a custom admin dashboard or menu.
- Drive a themed content-type switcher/menu with per-type icons.
- Keep a consistent icon vocabulary across content types using one Font Awesome package.
- Let editors recognise node types at a glance in the node-type overview.
- Pick the icon from a curated package via the searchable fonticonpicker element.
- Use the icon as a bundle label decoration in custom render arrays.
- Provide icons for an "Add content" landing page keyed by content type.
- Update a type's icon and have all `content_type.*` matches update after a cache clear.
- Expose content-type icons to other Micon-aware features (menus, local tasks) by string match.
- Set an icon on a newly created content type at creation time.
- Remove a content type's icon by clearing the picker (empties the third-party setting).
- Standardise iconography for an editorial team's content model.
- Integrate content-type icons into breadcrumb or title theming.
- Avoid custom preprocessing just to show a per-bundle icon.
