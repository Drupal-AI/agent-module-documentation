<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Exclusiv Access adds a per-entity "Exclusiv Access" field that, when switched on, limits the entity's page to visitors carrying a matching `?token=` link, with a permission for trusted roles to bypass it.

---

Exclusiv Access is a light, content-by-content access limitation for small sites that have no full access-control setup. You add its "Exclusiv Access" field (field type `exclusiv_access_field_type`) to a fieldable entity bundle; the widget renders an "Exclusiv Access Control" details group with an "activate" checkbox. When an editor ticks it and saves, the field's `postSave()` generates a random token, stores it in Drupal State under `exclusiv_access[entity_type][entity_id]`, and shows a message with the tokenised URL (`…/node/1?token=…`) to share. A `kernel.request` event subscriber (`AccessCheck`) then requires that token on the gated entity's page for anyone who lacks the `see content without token` permission. It is deliberately a bearer-style, "light" limitation for previews and soft-gating, not a substitute for real per-user access control on sensitive material.

---

- Gate an individual node (or any fieldable content entity) behind a shareable link token.
- Share brand-new content with newsletter subscribers before making it public.
- Send a tokenised preview URL for an unlisted article.
- Soft-gate content on a small site with no dev team or client access-control system.
- Add per-bundle gating by attaching the "Exclusiv Access" field to a content type.
- Toggle the gate per entity from the "Exclusiv Access Control" tab on the edit form.
- Auto-generate a token on save and surface the ready-to-share tokenised URL.
- Let editors re-read an already-issued token from the (disabled) token field on the edit form.
- Grant trusted roles the `see content without token` permission so they never need the link.
- Open content back up later by unchecking the gate.
- Restrict casual/anonymous access to a specific page without building node-access grants.
- Provide bearer-style access via a link that can be forwarded to invitees.
- Keep the setup minimal: no central settings form, one field plus one permission.
- Work on Drupal 10.1+ and 11, depending only on core Field.
- Limit access on entity types that expose a canonical entity page.
- Distribute early-access links for events, launches, or embargoed posts.
- Give reviewers a link to view work-in-progress content.
- Avoid granting site accounts just to let a few people preview one page.
- Use for low-stakes, temporary gating rather than confidential data.
- Combine the bypass permission with existing editor roles for internal review.
