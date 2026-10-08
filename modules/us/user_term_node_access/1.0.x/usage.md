<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
User term node access grants node access based on matching user and node taxonomy terms.

---

User term node access provides node access controlled by a user term — a user is assigned taxonomy term(s), and nodes tagged with matching terms are made accessible (or restricted) accordingly. Enforcement uses Drupal's node-access **grants** system (hook_node_grants / hook_node_access_records), so the restriction applies authoritatively at query level — listings, Views, search and canonical pages are all filtered, not just forms.

Administration is gated by `administer user term node access`. Because it uses the grants system, rebuild node access after configuration changes. Depends on core `node` and `taxonomy`; supports Drupal 9, 10, and 11.

---

- Control node access by user term.
- Match user and node taxonomy terms.
- Use the node-access grants system.
- Implement hook_node_grants/records.
- Enforce authoritatively at query level.
- Filter listings/Views/search.
- Not be form-only.
- Gate admin with `administer user term node access`.
- Rebuild node access after changes.
- Depend on core `node` and `taxonomy`.
- Support Drupal 9, 10, and 11.
- Restrict by taxonomy.
- Support per-term access
- Assign terms to users
- Filter canonical pages too.
- Control content visibility.
- Apply grants per op.
- Support access by term
