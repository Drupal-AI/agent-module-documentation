<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Y Branch turns the Branch content type of the YMCA Website Services (Open Y) distribution into a Layout Builder page, scaffolding the fields, form groups and a ready-made layout that every branch location shares.

---

On install the module adds three fields to the Branch bundle — `field_use_layout_builder` (a per-node "Use Layout Builder" toggle), `field_branch_menu_links` and `field_more_hours_link` — reorganizes the Branch edit form into field groups (creating a **Menu** group, folding a **More Hours Link** and later a **Show All Holidays** checkbox into the existing **Hours** group, and marking the old header/content/bottom groups as deprecated), and stamps a complete Layout Builder layout on the Branch `full` view display: a WS header, a branch header, the branch menu, social links, a body region, an amenities inline block and a WS footer, together with the `y_lb` style defaults (blue colorway) and allow/deny lists that constrain which layouts and inline blocks editors may add. A custom `entity_view_display` class (`YBranchLayoutBuilderEntityViewDisplay`) makes the `field_use_layout_builder` checkbox a real switch — when an editor unchecks it, the node stops rendering its Layout Builder sections and falls back to normal field display. The module also registers `node--branch--lb` and `page--node--branch-lb` templates and a small CSS library, and ships a `y_branch.hours_helper` service that other Open Y modules use to turn a branch's regular-hours and holiday-hours fields into render-ready tables and JavaScript settings (holiday rows are shown only inside a configurable date window unless the node's Show All Holidays box is ticked). It depends on `y_lb`, `openy_loc_branch`, `lb_branch_social_links_blocks`, `lb_branch_amenities_blocks` and `y_branch_menu`, and is meant to run inside the full YMCA Website Services distribution; in a plain Composer project the unconstrained `y_lb` requirement resolves to the sole Packagist release (`ycloudyusa/y_lb` 0.1, 2022, for Drupal 8/9), so the module cannot be enabled until the YMCA Composer repository providing a current `y_lb` is added — this documentation is therefore written from source.

---

- Compose a YMCA branch page with Layout Builder.
- Give every branch location the same block vocabulary.
- Let one branch's page differ from another's.
- Toggle Layout Builder on or off for a single branch node.
- Fall a branch back to plain field display when LB is off.
- Add a branch sub-menu with the Menu links field.
- Add a "More Hours Link" to a branch's Hours group.
- Show all holiday hours for a branch regardless of date.
- Render a branch's weekly hours as a collapsed table.
- Render a branch's holiday hours inside a date window.
- Highlight the current weekday in the hours table.
- Reuse the branch hours helper service from another module.
- Restrict which Layout Builder layouts editors may add to a branch.
- Denylist inline blocks that should not appear on a branch page.
- Understand the default branch layout (header, menu, amenities, footer).
- Install the YMCA Website Services distribution to run this module.
- Add the YMCA Composer repository to resolve `y_lb`.
- Diagnose a `y_lb` incompatibility at enable time.
- Constrain `y_lb` explicitly in a project.
- Audit a YMCA site's branch page composition.
- Plan a consistent multi-location branch site.
- Document the branch composition for a content team.
