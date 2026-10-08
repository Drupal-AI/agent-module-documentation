<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

Two permissions, defined in `simple_styleguide.permissions.yml`.

| Permission | Gates | Notes |
|---|---|---|
| `access style guide` | Viewing the styleguide page `/simple-styleguide` (route `simple_styleguide.controller`). | Grant to roles who should see the styleguide. |
| `administer style guide` | Managing custom `styleguide_pattern` entities (add/edit/delete/reorder at `/admin/config/styleguide/patterns`). It is the config entity's `admin_permission`. | `restrict access: TRUE` — treated as a security-sensitive permission. |

The **settings form** (`/admin/config/styleguide/settings`) and the config-panel menu page are
gated separately by core's **`administer site configuration`** (see routing), not by the two
permissions above.

Note: even with `access style guide` granted, the styleguide page is emitted with
`noindex, nofollow` (see theming/templates.md), so it will not be indexed by search engines.
