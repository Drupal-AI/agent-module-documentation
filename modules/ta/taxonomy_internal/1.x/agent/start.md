<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Taxonomy Internal (taxonomy_internal) — agent index

Marks **taxonomy vocabularies as internal** (hides them from certain user-facing contexts). Version
**1.0.1**.

**Caveat:** confirm whether 'internal' removes the vocabulary only from **UIs** or actually restricts
**access** to its terms — if terms are still exposed (term pages, JSON:API field values), 'internal'
is an organisational hint, not access control. Don't rely on it for confidential term data unless it
enforces access.