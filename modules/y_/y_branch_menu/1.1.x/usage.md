<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Y Branch Menu shows a single-level sub-menu within a branch page and its sub-pages, so visitors can move between that location's content.

---

A visitor on a YMCA branch page wants that branch's schedule, its programmes, its contact details — not the site's global navigation, which is about the organisation. A sub-menu scoped to the location gives them that, and stays visible as they move through the branch's pages.

Restricting it to a single level is a deliberate design decision worth noting: branch content is shallow by nature, and a nested sub-menu inside a site menu produces navigation nobody can hold in their head.

**This module cannot be enabled as composer resolves it, and it was verified.** It depends on `y_lb` (Y Layout Builder), and `ycloudyusa/y_lb` on Packagist has exactly one version — **0.1, published in 2022** — whose `core_version_requirement` is `^8 || ^9`. Drupal therefore refuses:

```
Unable to install modules: module 'y_branch_menu'. Its dependency module 'y_lb'
is incompatible with this version of Drupal core.
```

The current `y_lb` (3.x, 4.x, 5.x) lives in the YMCA's own composer repository, not on Packagist. Because this module requires `y_lb` with **no version constraint**, composer happily accepted the 2022 stub and the failure surfaced later, at enable time.

There is an instructive contrast inside the same family: `lb_branch_hours_blocks` **does** constrain the version (`y_lb ^4 || ^5`), so it failed loudly at composer time with a resolvable explanation. The modules that look laxer fail quietly and later. Adding the YMCA composer repository is the fix; documentation here is written from source.

---

- Show a branch-scoped sub-menu.
- Let visitors move within one location's content.
- Keep global navigation separate from local.
- Stay visible across a branch's sub-pages.
- Avoid deep nested navigation.
- Link a branch's schedule and programmes.
- Add the YMCA composer repository.
- Diagnose a y_lb incompatibility.
- Constrain y_lb explicitly.
- Plan location-scoped navigation.
- Audit branch navigation on a YMCA site.
- Understand the single-level design choice.
- Document branch navigation for editors.
- Report the missing y_lb constraint upstream.
- Review the menu depth decision.
