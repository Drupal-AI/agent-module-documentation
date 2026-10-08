<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Address Processor — agent orientation

Search API processor that adds the human-readable country name of Address fields to the index.

Structure: a `@SearchApiProcessor` plugin under `src/Plugin/search_api/Processor/`; depends on `address` + `search_api`. No routes, permissions, config forms, or request handling.

Security posture: none — index-time data transformation only; no request input, no external I/O, no dynamic SQL. Nothing to review. Operational note: enabling/disabling requires a reindex.
