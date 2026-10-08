<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Redirect Options

Redirect Options extends the contrib [Redirect](https://www.drupal.org/project/redirect) module
by letting site builders classify each redirect. On install it creates a *Type of Redirect*
taxonomy vocabulary seeded with **Template** and **Server** terms, then alters the redirect
add/edit forms to add a *Select redirect type* dropdown. The selected type is written to the
redirect entity's otherwise-unused title column and mirrored into a small `redirect_options`
table keyed by source path.

This is a lightweight classification/organisation aid — it does not change how redirects
resolve; it only records metadata about why/what kind of redirect each one is.

---

## Installation & configuration

- Requires the `redirect` module.
- Install with `drush en redirect_options`. The install hook creates the `type_of_redirect`
  vocabulary and the `Template`/`Server` terms, and defines the `redirect_options` table.
- Add or edit further redirect types by managing the *Type of Redirect* vocabulary.
- On any redirect add/edit form the new *Select redirect type* select appears; its value is
  stored on submit.
- No permissions are added; access follows the Redirect module's own form permissions.

---

## Use cases

- Distinguish template-driven redirects from server/infrastructure redirects.
- Tag redirects by origin so teams know which are safe to remove.
- Add custom redirect categories via the taxonomy vocabulary.
- Report on redirects by type using the companion table.
- Document large redirect sets during a site migration.
- Keep an audit-friendly classification of every redirect's purpose.
- Coordinate redirect ownership between content and platform teams.
- Filter/triage redirects during cleanup by their recorded type.
- Preserve intent metadata that plain redirects lack.
- Support governance policies that require redirect categorisation.
- Seed a consistent taxonomy of redirect types across environments.
- Mirror redirect classification into a queryable table for tooling.
- Annotate redirects created during a platform migration.
- Provide editors a required choice when creating redirects.
- Extend Redirect without patching it, via form_alter.
- Maintain classification automatically as redirects are saved.
