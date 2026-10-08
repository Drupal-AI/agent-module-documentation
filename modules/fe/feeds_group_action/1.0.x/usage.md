<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Feeds Group Action bridges Feeds and the Group module so that importing content can also create Group relationships (e.g. add the imported node or user to a group) as part of the same feed.
---
It provides a Feeds target plugin (`feeds_group_action_membership`, "Group Membership") with a `group_id` property. On the feed type's mapping you point a source at this target and choose a Group relationship type (relation plugin) and an add method — *skip if already in group*, *always add*, or *update if already in group*. During processing the target does not write immediately; it stages the requested relationships on the entity (`$entity->_feeds_group_action[]`) so the module's entity hooks / Group Action layer can create the actual group content after the entity is saved.

Requires Feeds, Feeds Tamper, Group and the Group Action module. It has no routes or permissions of its own — it operates entirely inside the Feeds import pipeline, and group creation goes through the Group Action API (subject to that layer's own logic).
---
- Add imported nodes to a group during a feed import
- Create group memberships from a CSV/RSS source
- Map a source column to a target Group ID
- Choose the Group relationship (relation) type to create
- Skip creating a relationship if it already exists
- Always add a new group relationship on import
- Update an existing group relationship on re-import
- Map multiple group IDs from an array source value
- Onboard imported users into groups automatically
- Bulk-assign content to groups via Feeds
- Combine content import and group placement in one feed
- Stage relationships for creation after entity save
- Use Group Action plugins to perform the membership write
- Migrate legacy memberships into Group relationships
- Populate group content from an external roster
- Keep group membership in sync on scheduled imports
