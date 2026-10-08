<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Target Audience restricts who may view or edit any entity by attaching a reusable 'target audience' field targeting roles, individual users, or Group memberships — using node grants for nodes and hook_entity_access for other entities, with a sensible public default.

---

Restricting content to a specific audience — a role, named users, a group — is a recurring need, and Target Audience provides a clean, general way to do it: attach a reusable target-audience field to any entity, and each target independently grants view and/or edit to a role, an individual user (by email), or a Group membership. This is genuine access control, and it is thoughtfully built — reviewed and verified. For NODES it uses Drupal's node grants system (hook_node_access_records + hook_node_grants), the correct query-level mechanism, so a restricted node 'never renders anywhere — canonical page, listings, Views or search' (grants filter it out of all queries, not just the canonical page). For OTHER entity types it enforces at runtime via hook_entity_access, and — importantly — the README is honest about the inherent Drupal limitation that there are no query-level grants for non-node entities, so custom listing queries must call entity access themselves; that is exactly right and the kind of caveat many modules omit. The restriction field itself is protected: it is only visible/editable to users with 'Administer target audience access', and the default formatter renders nothing, so the targeting data does not leak on forms, view modes, REST or JSON:API. The default is 'All' (public), which is the correct default for an opt-in restriction — content is public unless you add a target. This is one of the better-designed access modules in the campaign: use it to gate content by audience, and for non-node entities remember to enforce access in any custom listing queries.

---

- Restrict an entity to an audience.
- Gate content by role.
- Restrict to named users.
- Restrict to a Group.
- Grant view or edit per target.
- Use node grants for nodes.
- Filter restricted nodes from all queries.
- Enforce non-node access at runtime.
- Call entity access in custom listings.
- Keep targeting data from leaking.
- Rely on the public default.
- Add a reusable audience field.
- Restrict view and edit independently.
- Protect the restriction field (admin-only).
- Gate content cleanly.
- Verify non-node listing queries.
- Enable when needed.
- Keep disabled otherwise.
- Restrict administration.
- Confirm on your site.
- Test before production.
- Review configuration.