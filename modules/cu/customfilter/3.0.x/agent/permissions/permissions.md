<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Custom Filter — permissions

One permission, defined in `customfilter.permissions.yml`:

| Permission | `restrict access` | Gates |
|---|---|---|
| `administer customfilter` | **TRUE** | The entire filter/rule admin UI (`/admin/config/content/customfilter*`): creating, editing, and deleting filters, rules, and subrules. It is also the config entity's `admin_permission`. |

All routes in `customfilter.routing.yml` require this single permission.

## What this permission is worth (trust level)

Defining a rule is effectively **code / raw-HTML authoring**, so this permission must be
treated with the same trust as "administer filters" / a PHP-or-Full-HTML text format:

- A rule with the **PHP Code** box ticked stores its replacement as PHP that is executed with
  `@eval()` (`CustomFilterBaseFilter::replaceCallback`) every time a text format using the
  filter renders content → **arbitrary PHP execution** on the server.
- A rule with the code box off inserts its `replacement` into rendered content **verbatim**
  (no escaping) → it can inject arbitrary HTML/JS (**stored XSS**) into any content processed
  by a text format that enables the filter.

The permission is correctly declared `restrict access: TRUE`, so Drupal warns when granting it
and it should only go to fully trusted administrators. This is by design (the whole point of
the module is to let a trusted admin author transformations without writing a module) and is
**not** a vulnerability — it is the same power core already gives an admin who can add a PHP or
Full-HTML text format. Do not grant `administer customfilter` to any role you would not also
trust with `administer filters` or arbitrary PHP.
