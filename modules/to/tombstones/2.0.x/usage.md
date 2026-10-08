<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Tombstones creates tombstone nodes for removed content.

---

Tombstones lets you create **"tombstone" nodes** — placeholders that mark a piece of content as
permanently removed, so requests for the old URL can return an appropriate "gone" response (HTTP 410) instead of
a soft 404, which is cleaner for SEO and clients. It depends on core Menu UI, provides its own permissions.

Use it to signal that content is permanently gone. It is a site-structure/SEO feature; tombstone nodes are
admin/editor content and it has no access-control role beyond its permission. Create tombstones for removed
content.

---

- Create tombstone nodes.
- Mark content permanently gone.
- Return an HTTP 410-style response.
- Depend on core Menu UI.
- Provide its own permissions.
- Improve SEO on removed content.
- Treat tombstones as admin/editor content.
- Have no access-control role beyond permission.
- Create tombstones.
- Handle tombstones.
- Mark gone content.
- Configure the tombstones.
- Signal removal.
- Handle the nodes.
- Add tombstones.
- Configure SEO.
- Handle removed content.
- Mark gone.
- Set the tombstones.
- Provide content tombstones.
