<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Y Layout Builder Branch Social Links provides a block type for a location's own social media accounts.

---

Branches run their own social accounts — a local Facebook page, an Instagram for the swim team — and those are not the organisation's national ones. A block type for them keeps the distinction, so a location page links to the accounts a visitor to that location would actually want.

Its `link_attributes` dependency is the detail worth noting: social links are outbound and usually open in a new tab, and `target="_blank"` without `rel="noopener"` hands the opened page a handle on yours. Having the attribute settable per link is what allows that to be set correctly rather than remembered.

**This module cannot be enabled as composer resolves it, and it was verified.** It depends on `y_lb` (Y Layout Builder), and `ycloudyusa/y_lb` on Packagist has exactly one version — **0.1, published in 2022** — whose `core_version_requirement` is `^8 || ^9`. Drupal therefore refuses:

```
Unable to install modules: module 'y_branch_menu'. Its dependency module 'y_lb'
is incompatible with this version of Drupal core.
```

The current `y_lb` (3.x, 4.x, 5.x) lives in the YMCA's own composer repository, not on Packagist. Because this module requires `y_lb` with **no version constraint**, composer happily accepted the 2022 stub and the failure surfaced later, at enable time.

There is an instructive contrast inside the same family: `lb_branch_hours_blocks` **does** constrain the version (`y_lb ^4 || ^5`), so it failed loudly at composer time with a resolvable explanation. The modules that look laxer fail quietly and later. Adding the YMCA composer repository is the fix; documentation here is written from source.

---

- Link to a branch's own social accounts.
- Distinguish local from national accounts.
- Add link attributes to social links.
- Set rel="noopener" on outbound links.
- Open social links in a new tab safely.
- Place social links in a branch layout.
- Model social links as paragraphs.
- Keep social presentation consistent.
- Add the YMCA composer repository.
- Diagnose a y_lb incompatibility.
- Constrain y_lb explicitly.
- Audit outbound link attributes.
- Plan a location's social presence.
- Document a location's social accounts.
- Report the missing y_lb constraint upstream.
- Review link attributes across branches.
