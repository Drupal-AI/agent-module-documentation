<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Group Media Views Bulk Operations (VBO) is a submodule of Group Media that adds Views Bulk Operations actions for assigning media to, and removing media from, a group. Unlike the core-Action variants (which store one fixed group), the VBO actions let an operator pick the target group at run time from the view.

---

The submodule registers two VBO action plugins of type `media`: `vbo_assign_media_to_group` ("VBO: Assign media to a Group") and `vbo_remove_media_from_group` ("VBO: Remove media from a Group"). They extend `ViewsBulkOperationsActionBase` and delegate the work to the parent's `groupmedia.attach_group` service (`assignMediaToGroups()` / the corresponding remove logic), so the actual relate/unrelate behaviour matches the manual Group Media flow. Each action exposes a required `group_id` entity-autocomplete field in its configuration form, but because VBO collects that configuration as part of the bulk-operation execution, the group can be chosen for each bulk run rather than baked into a saved action — which is why the module is recommended when you have many groups. Access requires `update` permission on each selected media item. You use these actions by adding a Views Bulk Operations field to a media-based View and enabling the VBO action there; the submodule itself adds no configuration, permissions, routes, or services. Requires `groupmedia` and `views_bulk_operations`.

---

- Bulk-assign many selected media items to a chosen group from a media admin View.
- Bulk-remove media from a group in one operation.
- Pick the destination group at run time instead of pre-configuring a fixed group.
- Manage large numbers of groups where per-group core actions would be impractical.
- Add a "VBO: Assign media to a Group" operation to the site's Media library View.
- Let editors triage newly uploaded media into the right group in batches.
- Reassign a batch of media from one group to another (remove + assign).
- Combine with VBO's row selection and filters to target a precise media subset.
- Keep group asset libraries tidy by bulk-removing stale media.
- Scope a bulk assignment to only the media a filtered View shows.
- Delegate the actual relate logic to groupmedia.attach_group for consistent behaviour.
- Respect media update access when performing bulk group assignment.
- Provide a moderator workflow to sort media into department/team groups.
- Use on a custom media View with exposed filters for per-group curation.
- Onboard a large media backlog into groups without scripting.
- Offer bulk group operations alongside VBO's other media actions.
- Replace one-group-per-action setups with a single run-time group picker.
- Support content operations teams managing shared media across many groups.
- Bulk-assign a filtered set of images to a campaign group before launch.
- Remove a set of media from a group when a project is archived.
