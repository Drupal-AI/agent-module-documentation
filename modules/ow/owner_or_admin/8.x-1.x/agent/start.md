<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Owner or Admin Filter — agent index

Views **filter**: rows where `uid = current user`, **OR everything if they have administer-nodes**.
Uses core Views substitutions (`***CURRENT_USER***`/`***ADMINISTER_NODES***`), adds a `user` cache
context. Depends on core `views`. Version **8.x-1.3**. Core `^8||^9||^10||^11`.

**Display filter, NOT an access boundary** — it shapes View rows but does not restrict the entities
(canonical route, JSON:API, other Views still reach them). For confidentiality use node/entity
access.
