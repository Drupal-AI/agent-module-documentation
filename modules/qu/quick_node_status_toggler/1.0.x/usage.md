<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Quick Node Status Toggler adds a toggle to quickly publish/unpublish nodes from the content listing.

---

Quick Node Status Toggler **adds a publish/unpublish toggle to the content listing** — a Views field/switch
that lets editors flip a node's published status directly from the admin content list without opening the node. It
depends on core Node and Views.

Use it to quickly toggle publish status. It is a content-administration convenience, and it enforces access
correctly: the toggle route requires the **`administer nodes`** permission, and before changing status the code
**checks `$node->access('update')`** (in both the Views field and the toggle controller) and only then calls
`setPublished()` + `save()` — so a user can't toggle a node they lack update access to. This is the right pattern
(a positive). It has no broader access-control role. Enable it for the content-list toggle.

---

- Add a publish/unpublish toggle to the content list.
- Flip node status without opening the node.
- Provide a Views field/switch.
- Depend on core Node + Views.
- Serve content administration.
- Toggle from the listing.
- REQUIRE 'administer nodes' on the toggle route.
- CHECK $node->access('update') before toggling (positive).
- Only then setPublished() + save().
- Prevent toggling nodes the user can't update.
- Have no broader access-control role.
- Enable it for the toggle.
- Handle status toggling.
- Toggle status.
- Configure nothing (behavior).
- Publish/unpublish.
- Handle the listing.
- Flip status.
- Check access.
- Provide a node status toggle.
