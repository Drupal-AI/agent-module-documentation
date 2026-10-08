<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Authenticated Entity Access — agent index

**Per-node 'authenticated-only' checkbox** enforced by `hook_entity_access`. Version **1.x-dev**. Core `^8.8..^11`.

Authoritative individual access (`forbiddenIf(!authenticated)`) protects canonical + JSON:API/REST (positive). Nuance: no node grants, so raw Views listings aren't query-filtered (title/teaser could show to anonymous; open 403s) — pair with grants for full listing hiding. Perm `configure auth entity access`.