<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

Declared in `views_evi.permissions.yml`:

| Permission | Restrict access | Effect |
|---|---|---|
| `use php for views_evi` | `TRUE` | Controls whether the `php` Value plugin and `php` Visibility plugin textareas are **editable** in the Views UI settings form (`#disabled => !hasPermission('use php for views_evi')`). |

## Important scope caveat

The permission gates only the *editability of the textarea* in the admin UI. It is **not** checked at execution time: `ViewsEviValuePhp::getValue()` and `ViewsEviVisibilityPhp::getVisibility()` call `eval()` on whatever snippet is stored, for every visitor who triggers the view, regardless of the permission. Because the permission is marked `restrict access: TRUE`, Drupal already warns that granting it is equivalent to granting the ability to run arbitrary PHP — treat it as a trusted-administrator-only permission, and treat the ability to *save a view* (`administer views`) as equally sensitive on any site where the `php` plugins are used.

No other permissions are defined. There is no per-view or per-filter access control added by this module beyond the normal Views access system.
