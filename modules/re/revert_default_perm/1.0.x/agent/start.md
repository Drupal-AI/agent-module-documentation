<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Revert Default Permission (RDP) — agent index

**Controls visibility of the 'Revert to Default' button in Layout Builder**. Depends on core `layout_builder`.
Provides permissions. Version **1.0.4**. Core `^9||^10||^11`.

Layout Builder UI-access — gates the revert button by permission (ensure the underlying revert action is also
permission-appropriate); no broader access role.
