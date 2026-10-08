<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Fix Anonymous Nodes (fix_anonymous_nodes) — agent index
**Bulk-reassigns nodes owned by deleted/anonymous users to a chosen user via one admin form.**

- **Version:** 1.0.x
- **Core:** ^10.3 || ^11
- **Dependencies:** node
- **Route:** `fix_anonymous_nodes.form` → `/admin/content/fix-anonymous-nodes` (form)
- **Permission:** `fix anonymous nodes` (restrict access: TRUE)
- **Configure link:** `fix_anonymous_nodes.form`

Operation: finds distinct node authors, diffs against existing users (plus uid 0), loads each orphaned node and `setOwnerId()` to the selected target user, then saves.

**Security:** single admin form gated by a dedicated restricted permission; validates target user exists; parameterized DB queries; no anonymous or mutating public endpoints. Processes all matching nodes in one request (no batch) — heavy on large sites.
