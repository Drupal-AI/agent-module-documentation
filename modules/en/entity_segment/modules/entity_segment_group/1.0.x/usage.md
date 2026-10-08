<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Segment: Group makes global segments Group content, so a segment can be related to a group and governed by group roles.

---

An integration target submodule that bridges the Entity Segment engine to the contributed Group module. It ships a `group_segment` relation plugin with a deriver — one relation per segment type — so a group type can independently accept Contact segments, User segments, or any admin-created segment type. Access is additive and orthogonal: group members with the relevant group role gain CRUD on that group's segments in addition to the base engine's owner/scope/admin access, and a relation-access decorator downgrades Group's default "forbidden" to "neutral" so base grants union in and are never revoked. Only global segments can be group content, enforced end to end (a personal segment cannot be added to a group; a segment created inside a group is forced global; a grouped segment cannot revert to personal). `drupal/group` (`^3.3 || ^4`) is a dependency of this submodule only.

---

- Relate a global segment to a group via the Group module.
- Let group roles govern CRUD on a group's own segments.
- Enable Contact-segment or User-segment relations per group type.
- Enable a relation for any admin-created segment type automatically (deriver).
- Create a new segment inside a group (forced to global scope).
- Add an existing global segment to a group through Group's UI.
- Add group-scoped segment access on top of site-wide segment permissions.
- Give group members segment access without a site-wide permission.
- Keep a site-wide segment-permission holder's access whether or not a segment is grouped.
- Scope a group's segment reference field to global segments only.
- Prevent a grouped segment from being switched back to personal.
- Test the integration against both Group 3.x and Group 4.x.
- Delegate segment membership management to group administrators.
- Build per-group audiences for group-scoped campaigns.
- Keep segment machinery unchanged while adding only the Group wiring.
