<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ELI Permalinks (eli_permalinks) — agent index

**Creates/resolves European Legislation Identifier (ELI) permalinks to a redirect URL or an attached file, via pluggable jurisdiction profiles.**

- **Version:** 1.0.x
- **Core:** ^10 || ^11
- **Package:** Content
- **Dependencies:** file, options
- **Entity:** `eli_permalink` (fields: `eli_path`, `destination_url`, `destination_file`)
- **Permission:** `administer eli permalinks` (restrict access: true) — create/edit/delete
- **Route:** `/eli/{eli_path}` (`_access: 'TRUE'`, GET/HEAD, `no_cache`, regex `.+`) → `EliPermalinkController::resolve`
- **Services:** `eli_permalinks.profile_manager` (tagged `eli_permalinks.profile` — Spain, EU), `eli_permalinks.route_subscriber`
- **Security:** The public `/eli/...` resolver is `_access: 'TRUE'` by design (ELI URIs are meant to be openly citable). It loads only **published** (`status=1`) permalinks and returns admin-configured destinations: a 302 `TrustedRedirectResponse` to the entity's `destination_url` (browser redirect, not a server-side fetch → no SSRF) or a `BinaryFileResponse` streaming the entity's referenced managed file (admin-set reference, not request input → no arbitrary file read / traversal). Management is permission-gated. Reviewed sound.

See [extend/profiles.md](extend/profiles.md).
