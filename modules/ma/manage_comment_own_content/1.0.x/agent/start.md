<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Manage Comment Own Content — agent index

Lets **users manage (approve/update/delete/view-unpublished) comments on content THEY own** via per-comment-type
permissions. Depends on core `comment`, `node`. Provides permissions. Version **1.0.0-beta3**. Core `^10||^11`.

**Correctly ownership-scoped** — `hook_ENTITY_TYPE_access` grants only when the commented entity's
`getOwnerId()` == current user AND the per-type permission is held; else **neutral** (never forbidden), so it
only **adds** scoped access. Access-control; layers on core comment access.
