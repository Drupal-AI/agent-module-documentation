<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# View Mode by Role (VMBR) — agent index

Provides a **view mode per user role** (render entities differently by the viewer's role). Version
**1.0.0-alpha1**. Core `^8||^9||^10||^11`.

Content-display/site-building — **presentation, not access**: a field omitted from a role's view mode is still
readable via other paths (JSON:API/REST); use real field/entity access to restrict data. No access role.
