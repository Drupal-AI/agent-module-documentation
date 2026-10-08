<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Y Layout Builder is the Layout Builder integration point for YMCA Website Services — and the copy composer installs from Packagist is a 2022 version that does not support Drupal 10 or 11.

---

On a real YMCA site this is the foundation the `lb_branch_*` and `y_branch*` modules build on: Layout Builder configured with the platform's conventions, Bootstrap styles and layout builder blocks.

**What composer actually installs is not that.** `ycloudyusa/y_lb` on Packagist has exactly one published version — **0.1, from October 2022** — and its `core_version_requirement` is `^8 || ^9`. The current releases (3.x, 4.x, 5.x, which the sibling modules expect) are published through the YMCA's own composer repository, not Packagist.

The consequence, verified in this wave: `lb_branch_amenities_blocks`, `lb_branch_social_links_blocks`, `y_branch_menu` and `y_branch` all install cleanly and then refuse to enable —

```
Unable to install modules: module 'y_branch_menu'. Its dependency module 'y_lb'
is incompatible with this version of Drupal core.
```

— because they require `y_lb` with **no version constraint**, so composer resolved the stub. `lb_branch_hours_blocks`, which does constrain (`y_lb ^4 || ^5`), failed earlier and more usefully, at composer time with an explanation.

**The fix is to add the YMCA composer repository** before requiring anything in this family. The general lesson is worth carrying: an unconstrained dependency on a package that also exists, in an old form, on a public repository is how a project silently gets the wrong thing.

---

- Provide Layout Builder integration for a YMCA site.
- Underpin the lb_branch_* block modules.
- Add the YMCA composer repository first.
- Get a current y_lb rather than the 2022 stub.
- Diagnose a y_lb core incompatibility.
- Understand why composer accepted an old version.
- Constrain y_lb explicitly in a project.
- Compare with lb_branch_hours_blocks' behaviour.
- Recognise an unconstrained dependency risk.
- Check which repository a package came from.
- Plan a YMCA Website Services build.
- Audit an inherited site's y_lb version.
- Configure Bootstrap layout builder blocks.
- Report the missing constraints upstream.
- Avoid installing this family from Packagist alone.
