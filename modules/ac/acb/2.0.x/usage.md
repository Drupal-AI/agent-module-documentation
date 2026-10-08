<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Access Control Bridge reconciles several node-access modules running at once, so Content Access, Domain Access, Workflow, Organic Groups and Taxonomy Access Control do not cancel each other out.

---

Drupal's node access system is a grants table, and its combining rule is the source of endless confusion: a node is visible if **any** participating module grants it, which means adding a second access module to a site usually makes content *more* visible, not less. Teams expect restrictions to intersect and instead they union. This module's help text puts the problem exactly: the modules are individually excellent and "tend to break each other's functionality if used together". It sits between them and produces a combined result that behaves the way the site owner expected. Version **2.0.2** on core `^9.5 || ^10 || ^11`, with no dependencies of its own — it bridges whatever is present. Approach it with care, because this is the most consequential category of module on a site. Anything that alters node access grants needs **testing as its deliverable**, not as an afterthought: enumerate the roles, enumerate the content states, and check each cell of that grid before and after, including the anonymous row. And whenever grants change, `node_access_rebuild()` has to run and the site must be watched while it does, since a partially rebuilt grants table is a live disclosure risk rather than a cosmetic problem.

---

- Combine two node access modules.
- Stop access modules cancelling each other.
- Use Organic Groups with Content Access.
- Make restrictions intersect rather than union.
- Reconcile Domain Access with taxonomy access.
- Fix unexpectedly visible content.
- Add a second access module safely.
- Support a complex permissions model.
- Model departmental and group access together.
- Keep workflow states and group access aligned.
- Audit combined access behaviour.
- Restrict content by two dimensions.
- Support an intranet's access rules.
- Resolve conflicting grants.
- Model per-section editorial access.
- Combine role and group restrictions.
- Support a multi-tenant site's access.
- Diagnose a node access conflict.
