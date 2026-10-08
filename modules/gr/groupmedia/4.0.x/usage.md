<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Group Media integrates core Media entities with the contrib Group module, so a media item can be related to a group as group content and managed under that group's access rules. It adds a per-media-type "Group media" relation plugin, a group Media overview tab, and optional automatic tracking that attaches media referenced by group content to the group.

---

The module ships a derived `group_media` GroupRelationType plugin (one derivative per media type, e.g. `group_media:image`), which you install on a group type via *Set available content* just like Group Node or Group Content. Installing it makes that media type addable/creatable inside groups and lists it on the group's *Media* tab (the shipped `group_media` view). Each installed relation has a per-plugin `tracking_enabled` flag: when on, the `groupmedia.attach_group` service inspects entities as they are saved and automatically attaches referenced/embedded media to the relevant group(s). It finds media through a pluggable `media_finder` plugin type — core finders cover entity-reference fields, the WYSIWYG *Embed media* filter, and *Entity Embed*; the `groupmedia_paragraphs` submodule adds finders for media inside Paragraphs. Media can also be assigned/removed in bulk through the `assign_media_to_group` / `remove_media_from_group` core Action plugins (or the VBO equivalents in the `groupmedia_vbo` submodule). Three alter hooks (`hook_groupmedia_entity_group_alter`, `hook_groupmedia_finder_add_alter`, `hook_groupmedia_attach_group_alter`) let you veto or redirect automatic attachment. A media entity's edit form gains a read-only "Groups" panel listing the groups it belongs to. There is no global settings form — tracking is configured per relation plugin, and the older `groupmedia.settings` config was migrated away in update 8001.

---

- Attach a group's own logo/photo media items to that group as managed group content.
- Add an existing Image media item to a specific group from the group's *Media* tab.
- Let group editors create new media directly inside a group via *Create media*.
- Show every media item belonging to a group on a dedicated Media overview tab.
- Restrict who can view/add/create/update/delete group media using per-group-type permissions.
- Automatically attach media referenced by a group's article nodes to that group when saved.
- Track media embedded through the CKEditor *Embed media* filter and attach it to the group.
- Track media inserted with *Entity Embed* in formatted text and attach it to the group.
- Track media referenced inside Paragraphs (via the `groupmedia_paragraphs` submodule).
- Bulk-assign selected media items to a group using the *Assign media to a Group* action.
- Bulk-remove media from a group with the *Remove media from Group* action.
- Choose the target group at action time with Views Bulk Operations (`groupmedia_vbo`).
- Enable media tracking only for certain media types by toggling `tracking_enabled` per relation.
- Keep photo galleries scoped so each group only sees and manages its own media.
- Filter the group Media view's exposed bundle filter to only the media types enabled for that group.
- Show a media item's group memberships on its edit form for quick auditing.
- Write a custom `media_finder` plugin to detect media in a bespoke field type or embed syntax.
- Veto automatic attachment of specific media with `hook_groupmedia_finder_add_alter`.
- Redirect a media item to a different group set with `hook_groupmedia_entity_group_alter`.
- Prevent attaching media to particular groups with `hook_groupmedia_attach_group_alter`.
- Enforce single-group cardinality per media item (the plugin locks entity cardinality to 1).
- Model private, group-scoped asset libraries for teams, departments, or clients.
- Migrate a legacy site's media into groups programmatically via `groupmedia.attach_group`.
- Gate creation of a media bundle inside a group behind the `create group_media:<bundle> entity` permission.
- Provide per-group document repositories using the Document media type as group content.
- Combine with Group's visibility scopes to publish some group media publicly and keep the rest private.
- Give each community group its own moderated image library without duplicating media entities.
