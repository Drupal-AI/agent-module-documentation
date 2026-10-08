<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Block Layout (rest_block_layout) — agent orientation

- REST resource `BlockLayoutResource` (id `block_layout`, `GET /block-layout`). Reads
  `?path=` from the request, builds a sub-`Request` for that path, matches the route via
  `AccessAwareRouterInterface::matchRequest()` (catches ResourceNotFound/ParamNotConverted →
  404, HttpException → status; falls back to system.401/403/404 pages). Collects
  `block.repository->getVisibleBlocksPerRegion()` and returns as `ResourceResponse`.
- For a resolved `entity:*.canonical` route it computes `$entity->access('view', NULL, TRUE)` and
  stashes route/entity/access on request attributes.
- Normalizer `BlockNormalizer` only adds the entity payload when `$access->isAllowed()`.

Security review (reasonably sound): endpoint requires the `restful get block_layout` REST
permission (no rest.resource config shipped, so admin must enable it). `matchRequest()` uses the
ACCESS-AWARE router; `getVisibleBlocksPerRegion()` applies block access for the current user;
entity payload is gated by an explicit `access('view')` check in the normalizer. The `path` arg
drives internal routing only (no outbound fetch) → no SSRF. No finding.
