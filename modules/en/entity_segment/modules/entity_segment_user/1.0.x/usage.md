<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Segment: User ships a predefined `user` segment type and a first-class Segments area under People, making site users a targetable audience.

---

A thin target submodule of the Entity Segment engine for core `user`. Enabling it enables `entity_segment` and installs the `user` segment type — a `segment_type` config entity whose `target_entity_type_id` is `user`. It also adds a Segments local task under People at `/admin/people/segments`, pinned to the `user` type so it lists only user segments and offers an "Add user segment" action. Everything else — the condition builder, the `field_value` plugin, resolution to user IDs, and the per-segment-type permissions — is provided unchanged by the base module.

---

- Group site users into named, reusable cohorts.
- Segment users by role, status, or created/access date.
- Segment users by any profile or custom field on the user entity.
- Traverse user reference fields to segment on a referenced entity's field.
- Manage user segments from a dedicated Segments tab under People.
- Add a new user segment with the pinned "Add user segment" action.
- Restrict a View of users to a user segment's audience.
- Show a user segment's member count or member list with tokens.
- Target user cohorts in ECA no-code automations.
- Grant per-type user-segment permissions (view/create/update/delete, own/global).
- Ship a user segment as install config for deploy-time availability.
- Add custom fields to the user segment type via Field UI.
- Keep personal user segments separate from shared global ones.
- Expose viewable user members safely via the access-filtered audience.
- Feed a decoupled front end a user segment's members through JSON:API.
