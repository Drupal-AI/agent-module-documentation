<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Taxonomy Term Selection Role Filter — agent index

Filters **selectable taxonomy terms by the user's role** (each term carries a role-reference field; users are
offered only terms whose roles they hold — scope vocabularies by role). Depends on core `taxonomy`. Version
**1.0.0-alpha3**. Core `^8||^9||^10||^11`.

Access-adjacent editing — governs the **selection widget** (authoring convenience), **not** a hard boundary on
the term data (terms still exist/reachable elsewhere). No entity-access-control role.
