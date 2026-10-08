<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# UUID URL — agent index

Provides **`/by_uuid/{entity_type}/{uuid}`** that redirects to an entity's canonical URL (link by stable UUID
vs ID/alias). Version **8.x-1.4**. Core `^8||^9||^10||^11`.

Routing/utility — **access-safe**: the controller **checks `$entity->access('view')` before redirecting**
(verified), so the public route does not expose entities the user can't view. No other access role.
