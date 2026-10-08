<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Group Media Library provides functionality to use the media library with Group, enabling group-scoped media.

---

Group Media Library integrates the core Media Library with the Group module — so media can be associated
with and browsed per group, enabling group-scoped media management (each group works with its own media). It
ships `group_media_library_groupmedia`, `group_media_library_media_tracker` and `group_media_library_widget`
submodules, and depends on core Media Library and the Group module.

Use it to scope media to groups. It is a media/group feature; media access should follow the group's
membership/permission model (verify that group-scoped media is only accessible to the appropriate group
members — media access ultimately depends on the Group/media access configuration). It has no access-control
role of its own beyond bridging media into groups. Configure the group media types and library.

---

- Use the media library with Group.
- Scope media to groups.
- Browse media per group.
- Ship groupmedia/tracker/widget submodules.
- Depend on Media Library and Group.
- Enable group-scoped media.
- Follow the group's access model.
- Verify group members-only media access.
- Have no access-control role of its own.
- Configure group media types.
- Associate media with groups.
- Manage group media.
- Bridge media into groups.
- Configure the library.
- Handle group media.
- Scope the media library.
- Use group media.
- Configure group media library.
- Browse group media.
- Integrate media with Group.
