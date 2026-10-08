<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

We Mega Menu defines exactly **one** permission (`we_megamenu.permissions.yml`):

| permission | machine name | `restrict access` | gates |
|---|---|---|---|
| Administer Mega Menu | `administer we_megamenu` | `TRUE` | the whole builder |

`administer we_megamenu` is required by every builder/admin route in `we_megamenu.routing.yml`:

- `we_megamenu.admin` — the listing at `/admin/structure/we-mega-menu`
- `we_megamenu.admin.configure` — the per-menu builder `/admin/structure/we-mega-menu/{menu_name}/config`
- `we_megamenu.admin.save`, `we_megamenu.admin.reset`, `we_megamenu.admin.style` — AJAX save/reset/style

Because it is flagged `restrict access: TRUE`, Drupal marks it as a security-sensitive permission
(only trusted roles should get it). The two *front-end* AJAX helper routes
`we_megamenu.renderblock` and `we_megamenu.geticons` instead require the core `access content`
permission, so anonymous visitors can render the menu but not edit it.

Grant it with:

```bash
drush role:perm:add editor 'administer we_megamenu'
```
