<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Open Y Branch Selector (openy_branch_selector) — agent index

Saves a visitor's chosen branch as "My YMCA" and links to it.
Version **1.1.2**. Core `^10 || ^11`. Depends on **`openy_loc_branch`**.

**Documented from source — could not be enabled. Verified:**
`drush en openy_branch_selector` → *"missing its dependency module openy_loc_branch"*, and
`https://packages.drupal.org/files/packages/8/p2/drupal/openy_loc_branch.json` returns **404** —
`openy_loc_branch` is not a separate project, it ships inside the **Open Y distribution**.

So: installable on an Open Y site, not on standalone Drupal. Say that before recommending it.

The module supplies selection and the persistent link only; branch location data belongs to
`openy_loc_branch`.