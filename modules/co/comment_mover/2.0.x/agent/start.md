<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Comment Mover (comment_mover) — agent index
**Cut/paste comments (and threads) between nodes; convert nodes↔comments.**

- **Version:** 2.0.x (dev-2.0.x)  •  **Core:** ^10 || ^11  •  **Requires:** node, comment
- **Routes (both `administer comments`):** `comment_mover.cut` `/comment_mover/cut/{entity_type}/{entity_id}`; `comment_mover.paste` `/comment_mover/paste/{entity_type}/{entity_id}`
- **Services:** `comment_mover.mover` (CommentMover), `comment_mover.clipboard` (private tempstore)
- **Block:** `CommentMoverBlock` clipboard UI
- **Security:** routes require `administer comments`.

See [api/moving.md](api/moving.md).