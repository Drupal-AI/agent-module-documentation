<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Public Preview — agent orientation

Secret per-node/per-language preview links granting anon read of UNPUBLISHED nodes.

- Version 8.x-1.x, core `^8||^9||^10`, dep node. Link form `/node/{node}/preview-links` (`access preview links form`).
- Route `/node/{node}/preview-link/{hash}` is `_access: TRUE`; real gate is `hook_entity_access` — allows view only when hash matches a stored record for that exact nid+langcode. Hash = `Random::name(69, TRUE)`; lookup uses escapeLike (no wildcard bypass).
- SECURITY: intended design (share-by-secret-link). Token is 69 chars, unpredictable, scoped; not CSPRNG but not practically guessable. No expiry (link-leak is the only risk). No access-bypass found.