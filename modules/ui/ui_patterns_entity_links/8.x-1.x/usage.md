<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
UI Patterns Entity Links exposes an entity's link templates (canonical, edit-form, delete-form, etc.) as configurable Layout Builder blocks that render through UI Patterns components.

---

A block deriver (`LinkBlockDeriver`) enumerates every fieldable entity type and each of its link-template `rel`s, generating a `link_block:<entity_type>:<rel>` block per combination with an entity context. The `LinkBlock` plugin builds a UI Patterns render array (`#type => pattern`): it resolves the entity's URL for that `rel` (falling back to the raw link template on `RouteNotFoundException`, honouring an "Absolute URL" option) and a label (derived from the rel or an admin `label_override`), then maps them onto the chosen pattern's `url`/`label` source fields. An `EntityLinkSource` UI Patterns source plugin declares those two fields. The block form uses UI Patterns' `PatternDisplayFormTrait` to pick the pattern, variant and settings.

The module has no routes, permissions, services or config of its own; placement and access are governed entirely by Layout Builder / block visibility and the entity's own access. Values fed to the pattern are entity-derived URLs/labels (or an admin-entered override), rendered by UI Patterns. Typical use: in Layout Builder, add the "<Entity> entity links" block for the link you want, choose a UI Patterns component to render it. No security findings.

---

- Add a node's canonical link as a Layout Builder block.
- Place an entity's edit-form link as a component-rendered button.
- Expose a delete-form link block for privileged users.
- Render entity links for any fieldable entity type (users, terms, media...).
- Choose which UI Patterns component renders the link.
- Map the link URL and label onto the pattern's source fields.
- Override the auto-generated link label per block.
- Emit absolute URLs by enabling the Absolute URL option.
- Apply a UI Patterns variant to the rendered link.
- Pass extra pattern settings to the component.
- Build consistent CTA/link styling across content types via components.
- Use it inside Layout Builder default and override layouts.
- Style edit/delete/version-history links uniformly.
- Preview gracefully in Layout Builder even before an entity id exists.
- Fall back to the raw link template when a route is not found.
- Combine multiple link blocks in one region for an action bar.
- Rely on entity access + Layout Builder permissions for visibility.
