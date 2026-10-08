<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Y Layout Builder (y_lb) — agent index

Layout Builder integration point for **YMCA Website Services**, underpinning the `lb_branch_*` and
`y_branch*` modules. Depends on `layout_builder`, `bootstrap_styles`,
`bootstrap_layout_builder`, `layout_builder_blocks`.

**The copy composer installs from Packagist is a stub — state this first.**
`ycloudyusa/y_lb` on Packagist has **one version, 0.1 (October 2022)**, with
`core_version_requirement: ^8 || ^9`. Current releases (3.x–5.x, which the siblings expect) are in
the **YMCA's own composer repository**.

**Verified consequence:** `lb_branch_amenities_blocks`, `lb_branch_social_links_blocks`,
`y_branch_menu` and `y_branch` install cleanly then refuse to enable —
*"Its dependency module 'y_lb' is incompatible with this version of Drupal core."* They require
`y_lb` with **no version constraint**. `lb_branch_hours_blocks`, which constrains `^4 || ^5`,
failed earlier and more usefully at composer time.

**Add the YMCA composer repository before requiring anything in this family.** General lesson: an
unconstrained dependency on a name that also exists, in an old form, on a public repository is how
a project silently gets the wrong thing.