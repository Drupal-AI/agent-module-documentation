<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Splide UI permissions

Splide UI declares a single permission (`splide_ui.permissions.yml`):

| Permission | Gates |
|---|---|
| `administer splide` | All Splide UI routes: the optionset collection, add/edit/duplicate/delete optionset forms, and the Splide UI settings form. Marked `restrict access: true` (security-sensitive). |

Grant it to a site-builder/administrator role:

```bash
drush role:perm:add site_builder 'administer splide'
# read back:
drush php:eval 'var_export(\Drupal\user\Entity\Role::load("site_builder")->hasPermission("administer splide"));'
```

There are no other permissions; the parent Splide module (formatters, Views style, filter) defines
none of its own — rendering sliders relies on the usual field/view/filter access, not a Splide
permission.
