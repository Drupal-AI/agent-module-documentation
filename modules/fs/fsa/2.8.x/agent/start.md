<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Fastly Streamline Access (project `fsa`, module `fastly_streamline_access`) — agent index

Adds an authenticated user's IP to a **Fastly ACL**, for environments shielded at the edge
(Lagoon-style). Core requirement `^10.2 || ^11`.
Config at `/admin/config/development/fastly_streamline_access` (`administer site configuration`).
Submodule: `fastly_streamline_access_admin`.

> **Project and module names differ** — `drush en fsa` fails; use `drush en fastly_streamline_access`.

Key facts:
- `fsaResponse()` fires on the module's own event; failures of the Fastly call are **caught and
  logged**, so a misconfiguration is silent — check the log when access is not granted.
- **Nothing expires ACL entries.** Membership is additive; a stale allow-listed IP is an access
  path nobody reviews. Plan a retention/cleanup process.
