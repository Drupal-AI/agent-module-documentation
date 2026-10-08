<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Comment Mover — operations

## Routes (permission: `administer comments`)
- `GET /comment_mover/cut/{entity_type}/{entity_id}` → `CommentMoverController::cut()` —
  stores the entity on the clipboard (`comment_mover.clipboard`), then
  redirects to `?destination`.
- `GET /comment_mover/paste/{entity_type}/{entity_id}` → `::paste()` — re-parents clipboard
  comments under the target and invalidates cache tags.

## Services
- `comment_mover.clipboard` → `Clipboard` (uses `tempstore.private`): `cut()`, `paste()`.
- `comment_mover.mover` → `CommentMover` (uses `entity_type.manager`): performs the re-parenting
  and node↔comment conversion (`CutEntity`).
