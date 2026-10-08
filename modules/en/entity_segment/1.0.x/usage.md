<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Segment lets you define named, reusable segments — saved audiences of any content entity type, described by a visual AND/OR tree of conditions and resolved live to the entities that match right now.

---

Entity Segment provides a generic `segment` content entity whose bundle (a `segment_type` config entity) names the target content entity type it selects — users, nodes, taxonomy terms, commerce entities, or your own custom entities. Each segment stores a tree of AND/OR condition groups built from `EntitySegment` plugins; the shipped `field_value` plugin compares any field of the target type with operators derived from that field's Views filter handler, and can traverse entity-reference fields to any depth. A resolver turns a segment's condition tree into target-entity IDs on every call (no materialized list), folding queryable conditions into a single entity query and falling back to set intersection/union for the rest. Membership is exposed only through the `entity_segment.audience_access` chokepoint, which offers a viewer-safe access-filtered audience and a separately permission-gated raw audience. Segments are revisionable, own global/personal scope, and carry granular per-segment-type permissions. Optional integrations add a Views filter, tokens, ECA condition/action, VBO bulk scope actions, Diff revision comparison, JSON:API resolved-members endpoints, and (via submodules) User, CRM Contact, and Group audiences. Requires Drupal 11.1+ and the contrib `entity` module.

---

- Define a reusable audience of users, nodes, terms, or any content entity type once and reference it everywhere.
- Build audience rules visually as nested AND/OR condition groups in the admin UI.
- Segment content entities by any field value ("Country is Belgium", "created after a date").
- Use type-aware operators automatically (contains/starts-with for strings, greater-than/between for numbers and dates).
- Traverse entity reference fields to segment on a related entity's field (an order's customer's country).
- Segment CRM Contacts for targeted email campaigns (Member Platform Initiative use case).
- Segment site users into cohorts by role, profile field, or activity date.
- Restrict a View to only the entities a segment resolves to, using the "Segment audience" filter.
- Show a per-segment member count or bounded member list with the `[segment:member-count]` / `[segment:members]` tokens.
- Drive no-code automation with ECA: run steps only when an entity "is in segment".
- Resolve a segment to a token of audience IDs inside an ECA model for downstream iteration.
- Bulk-switch selected segments between global and personal scope with Views Bulk Operations.
- Compare how a segment's condition tree changed between revisions using the Diff integration.
- Expose a segment's resolved membership to a decoupled front end via JSON:API resolved-members endpoints.
- Let a group grant CRUD on its own global segments through the Group integration, additively.
- Ship a segment type as install config so a target audience is available on deploy.
- Add custom fields (a description, a campaign reference, an external-audience id) to a segment type via Field UI.
- Grant per-segment-type, node-style permissions so teams manage only their own audiences.
- Keep personal, owner-only segments separate from shared global ones with the scope model.
- Read a segment's membership safely by exposing only the entities the current user may view.
- Reserve the full, unfiltered audience for trusted server-side work behind the membership permission.
- Personalize or target content by asking whether the current user or entity is in a given segment.
- Write your own `EntitySegment` plugin to add a new condition type for any target entity type.
- Refine which segments a listing shows by subscribing to the `entity.query_access.segment` event.
- Reuse the standalone Property Traversal service to walk Typed Data property paths across references.
