<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Extend Collabora Online's document view/edit permissions to the Group module, so that who may preview or edit a document in Collabora can be decided by group membership.

---

Collabora Online Group is an optional submodule of Collabora Online that integrates it with the Group and Group Media modules. On its own, Collabora Online decides document access from site-wide per-media-type permissions; this submodule maps those same "preview" and "edit in Collabora" operations onto Group's per-group-type permission system, so a site can grant a group's members the right to view or edit documents belonging to that group. It does this by decorating Group Media's relation handlers: a permission provider that publishes group-scoped Collabora permissions (preview published, preview own unpublished, edit any, edit own), and an access control handler that correctly routes the "preview in Collabora" operation to the unpublished variant for unpublished media before delegating to Group's default access logic. Its install hook also adds "View in Collabora Online" and "Edit in Collabora Online" links to the Group Media view's operations dropbutton.

---

- Control who can preview or edit documents in Collabora based on group membership rather than only site-wide roles.
- Grant group members "preview published", "preview own unpublished", "edit any" and "edit own" Collabora permissions per group content type.
- Reuse the parent module's WOPI editor/viewer while sourcing access decisions from Group.
- Add Collabora view/edit links to the Group Media administrative view automatically on install.
- Support Group Media 3.x and 4.x.
