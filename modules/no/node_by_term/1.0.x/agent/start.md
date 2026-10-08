<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Node by Term (node_by_term) — agent index

**Filters and lists nodes by vocabulary, taxonomy term and content type via an admin form + results table.**

- **Version:** 1.0.x
- **Core:** ^9 || ^10
- **Dependencies:** node, taxonomy
- **Routes:** `node_by_term.nodelist` (`/node-list`, configure route, filter form + paged results table); `node_by_term.form` (`/node-by-term-form`, standalone filter form).
- **Permission:** both routes require `administer node by term` (string is undeclared — effectively user-1 only).
- **Security:** admin-gated listing; the `/node-list` route carries both `_permission: 'administer node by term'` and a redundant `_access: 'TRUE'` (AND-combined, so not a bypass). The list includes unpublished nodes but only for accounts that pass the (undeclared) permission gate. Queries use the DB API with parameterised conditions; no anonymous or mutating endpoints.

See [configure/filter.md](configure/filter.md)
