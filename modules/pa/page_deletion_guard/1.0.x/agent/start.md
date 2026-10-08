<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Page Deletion Guard — agent index

**Locks selected pages (nodes) to prevent deletion** (protect home/legal/landing pages from accidental/
unauthorized deletion). Depends on core `node`; provides permissions. Version **1.0.0-alpha5**. Core
`^10||^11`.

Content-protection — prevents deletion of locked nodes (guardrail); gate who can lock/unlock via its
permission; complements (not replaces) proper delete permissions.
