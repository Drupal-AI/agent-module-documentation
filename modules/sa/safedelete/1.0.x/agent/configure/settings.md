<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure SafeDelete

## Prerequisites
- Enable **Linkit** and **Node**.
- Install `ezyang/htmlpurifier` (`composer require ezyang/htmlpurifier`) — used to parse body-field links.

## Settings
Route `safedelete.settings` → `admin/config/development/safedelete` (perm `safedelete administration`):
- Enable/disable protection **per bundle**.
- Set the **record limit** shown on the node delete form.
- Toggle whether the **delete button** is disabled for dependent content
  (users with `safedelete show delete button` still see it).

## Behavior
On node delete — or on changing to an **archived** moderation state — SafeDelete checks whether the
node is linked from other nodes' body fields (via Linkit). If it is, it blocks the operation and
lists the referencing content.

## Orphaned-node reports
- Generate: `admin/content/safedelete-orphanedpages` (perm `safedelete create orphans report`).
- View: `.../viewreport` (perm `safedelete view orphans report`).
