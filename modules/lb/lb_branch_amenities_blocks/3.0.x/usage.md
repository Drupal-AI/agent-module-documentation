<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Y Layout Builder Branch Amenities renders the facilities available at a location — pool, gym, childcare and so on — as a placeable block.

---

Amenities are the question a visitor actually has about a branch: does this one have a pool, is there parking, can I bring a child. Presenting them as structured, iconographic data rather than a paragraph of prose is what makes a location page answer that at a glance, and makes the same data usable for filtering locations elsewhere on the site.

Modelling them as paragraphs with media (hence `paragraphs`, `media` and `blazy` for lazy-loaded images) means each amenity carries an icon and a label rather than being free text, which is also what keeps them consistent across dozens of branch pages.

**This module cannot be enabled as composer resolves it, and it was verified.** It depends on `y_lb` (Y Layout Builder), and `ycloudyusa/y_lb` on Packagist has exactly one version — **0.1, published in 2022** — whose `core_version_requirement` is `^8 || ^9`. Drupal therefore refuses:

```
Unable to install modules: module 'y_branch_menu'. Its dependency module 'y_lb'
is incompatible with this version of Drupal core.
```

The current `y_lb` (3.x, 4.x, 5.x) lives in the YMCA's own composer repository, not on Packagist. Because this module requires `y_lb` with **no version constraint**, composer happily accepted the 2022 stub and the failure surfaced later, at enable time.

There is an instructive contrast inside the same family: `lb_branch_hours_blocks` **does** constrain the version (`y_lb ^4 || ^5`), so it failed loudly at composer time with a resolvable explanation. The modules that look laxer fail quietly and later. Adding the YMCA composer repository is the fix; documentation here is written from source.

---

- Show which facilities a branch has.
- Answer a visitor's first question about a location.
- Present amenities as icons and labels.
- Keep amenity data consistent across branches.
- Reuse amenity data for location filtering.
- Lazy-load amenity icons with blazy.
- Model amenities as paragraphs.
- Place the block in a branch layout.
- Add the YMCA composer repository.
- Diagnose a y_lb incompatibility.
- Constrain y_lb explicitly.
- Avoid free-text facility descriptions.
- Audit amenity data across locations.
- Plan a location comparison feature.
- Document the amenity vocabulary.
- Report the missing y_lb constraint upstream.
