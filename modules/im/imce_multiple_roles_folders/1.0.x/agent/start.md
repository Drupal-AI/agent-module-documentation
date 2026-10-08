<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Imce Multiple Roles Folders — agent index

**Merges IMCE folder permissions for users with multiple roles** (multi-role user gets the **union** of their
roles' allowed folders, not just one role's). Depends on `imce`. Version **1.0.4**. Core `^9||^10||^11`.

Access-related (IMCE file browser) — makes folder access **additive** across roles; design IMCE profiles so
no single role grants a folder you wouldn't want a multi-role user to reach (union can be broader). Relies on
IMCE's access model.
