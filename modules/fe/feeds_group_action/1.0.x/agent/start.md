<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Feeds Group Action (feeds_group_action) — agent index

**A Feeds target that stages Group relationships (memberships) for imported entities via Group / Group Action.**

- **Version:** 1.0.0 (dir 1.0.x)  •  **Core:** ^10 || ^11  •  **Requires:** feeds, feeds_tamper, group, group_action
- **Plugin:** FeedsTarget `feeds_group_action_membership` ("Group Membership") — property `group_id`; config `relationship_plugin_id` (Group relation type) and `add_method` (`skip_existing` | `always_add` | `update_existing`).
- **Mechanism:** `GroupMembership::setTarget()` stages requests on `$entity->_feeds_group_action[]`; actual group content is created downstream through the Group Action API after save.
- **No routes, permissions, or services.**
- **Security:** Operates only within the Feeds import pipeline; relationship creation delegates to Group Action (its access/logic applies). No public endpoints or request-facing surface.

See [plugins/target.md](plugins/target.md)
