<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Open Y Branch Selector gives a visitor a way to pick their local branch and keep it — a "My YMCA" link that returns them to the location they care about.

---

A multi-site organisation with dozens of physical locations has a navigation problem that no menu solves: every visitor wants one branch, and which one differs per visitor. The usual outcomes are a location picker on every page or a visitor who bookmarks a branch page and never sees anything else. Saving the choice turns the site from a directory into something that behaves like it knows where you go — schedules, programmes and opening hours default to the right place.

The module is small and sits on top of `openy_loc_branch`, the Open Y module that defines branch locations. Its job is the selection and the persistent link, not the location data.

**It could not be enabled on the review install, and the reason is worth knowing before planning around it.** `drush en openy_branch_selector` fails with *"missing its dependency module openy_loc_branch"*, and `openy_loc_branch` is **not a separate drupal.org project** — the packages server returns 404 for `drupal/openy_loc_branch`. It ships inside the Open Y distribution. So this module is installable only on a site built from Open Y, not on a standalone Drupal site that merely wants the feature. This documentation is written from source for that reason.

---

- Let a visitor save their local branch.
- Show a "My YMCA" link in the header.
- Return a visitor to their chosen location.
- Default schedules to a visitor's branch.
- Reduce navigation for a multi-location organisation.
- Personalise programme listings by branch.
- Let a visitor change their saved branch.
- Improve repeat-visit experience on a directory site.
- Link members to their home location's page.
- Build branch-aware navigation on Open Y.
- Understand the Open Y distribution dependency.
- Confirm `openy_loc_branch` is present before installing.
- Audit an Open Y site's branch personalisation.
- Explain why it cannot install outside Open Y.
- Plan branch personalisation on a non-Open Y site.
