<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Term Hierarchy By Language (thbl) — agent index

Makes taxonomy **term hierarchy (parent) and weight language-aware**. Version **1.0.1**. Core `^8 || ^9 || ^10`.

Depends on core content_translation + taxonomy. Services `thbl.query_manager` and `thbl.form_helper` override how term parent/weight are read/stored, keyed by language. No public routes, no permissions.
